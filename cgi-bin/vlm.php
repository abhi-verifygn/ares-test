#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          vlm.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the volume settings form
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "HTML/Template/ITX.php";
    require_once "venus_helper.php";


    /******************************************************************************
    **  Script entry point
    **
    */

    if ( session_start() == false )
    {
        die( "Unable to start session. Serious. Terminating script processing");
    }

    $timeNow = time();

    VenusSessionAuthenticate();

    $con = VenusDBConnect();

    $writeTables = array(  );
    $readTables = array( "Volume"=>"Volume",
                         "VolumeParams"=>"VolumeParams",
                         "LangVolume"=>"LangVolume",
						 "DL2Volume"=>"DL2Volume",
						 "DL2VolumeParams"=>"DL2VolumeParams" );

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "vlm", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

		if (VenusInstallerAccess()) /* Check for installer access */
		{
			$isInstaller = True;
		}
		else
		{
			$isInstaller = False;
		}

        $labelArray = VenusGetLabels( $con,
                $readTables["LangVolume"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "vlm" ), true, true );

        $template->setCurrentBlock( "VLM_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );
        $template->setVariable( "L1HEAD", $labelArray["Lane1Header"] );
        $template->setVariable( "L2HEAD", $labelArray["Lane2Header"] );

        $params = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$readTables["Volume"]} order by ID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $params[$rowResult["ParamNameID"]] = array(
                    "Value" => $rowResult["ParamValueID"],
                    "Type" => $rowResult["DataEntryType"] );
            }
            mysqli_free_result( $queryResult );
        }

        $paramsL2 = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$readTables["DL2Volume"]} order by ID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $paramsL2[$rowResult["ParamNameID"]] = array(
                    "Value" => $rowResult["ParamValueID"],
                    "Type" => $rowResult["DataEntryType"] );
            }
            mysqli_free_result( $queryResult );
        }

        $entries = 0;
        foreach ( $params as $paramName => $paramValue )
        {
			if( ($paramName == "LabelMicPreampGain") && !($isInstaller) )
			{
			    /* Grab the Lane 2 parameter */
			    $paramL2Value = $paramsL2[$paramName];

				$template->setCurrentBlock( "USER_READONLY" );
                $template->setVariable( "USER_DISPLAY_NAME", $labelArray[ $paramName ]  );
                $template->setVariable( "USER_NAME", $paramName  );
                $template->setVariable( "USER_ENTRY_NO", ++$entries );
                $template->setVariable( "USER_ENTRY_NO_L2", ++$entries );
                $template->setVariable( "USER_DISPLAY_VALUE", $paramValue["Value"] );
				$template->setVariable( "USER_DISPLAY_VALUE_L2", $paramL2Value["Value"] );
				$template->parseCurrentBlock();
			}
			else
			{
		        $template->setCurrentBlock( "FORM_ENTRY" );
                $template->setVariable( "PARAM_DISPLAY_NAME", $labelArray[ $paramName ]  );
                $template->setVariable( "PARAM_NAME", $paramName  );
                $template->setVariable( "ENTRY_NO", ++$entries );
                $template->setVariable( "ENTRY_NO_L2", ++$entries );

			    /* Grab the Lane 2 parameter */
			    $paramL2Value = $paramsL2[$paramName];

                switch( $paramValue["Type"] )
                {
                    case DATA_ENTRY_TEXT:
                        $template->setVariable( "PARAM_DISPLAY_VALUE", $paramValue["Value"] );
	    			    if($paramName == "VehicleAlertVol")
			            {
                            $template->setVariable( "PARAM_DISPLAY_VALUE_L2", $labelArray["NotApplic"] );
				        }
			            else
				        {
                            $template->setVariable( "PARAM_DISPLAY_VALUE_L2", $paramL2Value["Value"] );
				        }
                        $template->setCurrentBlock( "FORM_TEXT" );
                        $template->setVariable( "TEXT_PARAM_NAME", $paramName  );
                        $template->setVariable( "TEXT_DISPLAY_VALUE", $paramValue["Value"]  );
					    if($paramName == "VehicleAlertVol")
					    {
                            $template->setVariable( "TEXT_DISPLAY_VALUE_L2", $labelArray["NotApplic"] );
					    }
					    else
					    {
                            $template->setVariable( "TEXT_DISPLAY_VALUE_L2", $paramL2Value["Value"]  );
					    }
                        $template->parseCurrentBlock();
                        break;
                    default:
                        break;
                }
			
                $template->setCurrentBlock( "FORM_ENTRY" );
			}
            $template->parseCurrentBlock();
        }
        $template->setCurrentBlock( "VLM_FORM" );

        $template->setVariable( "ERROR_ID", AJAX_ERROR );
        $template->setVariable( "SESSION_ERROR_MESSAGE", $_SESSION[ SESS_ERROR ] );

        $submitEntry = "Not permitted";
        if ( $updateable == True )
        {
            $submitEntry ='<input id="submitFormButton" type="submit" value="'
                . $labelArray[ "ApplyChanges" ].'">';
        }
        $template->setVariable( "SUBMIT_ENTRY", $submitEntry );

        $template->setVariable( "HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "HIDDEN_SESSION", session_id() );

        $template->parseCurrentBlock();
        $template->show( );

        if ( isset( $_SESSION[ SESS_ERROR ] ) )
        {
            unset( $_SESSION[ SESS_ERROR ] );
        }

        if ( !@mysqli_query( $con, "UNLOCK TABLES;" ) )
        {
            VenusShowError( $con );
        }
    }
?>
