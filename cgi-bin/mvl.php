#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          mvl.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the monitor volume levels settings form
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
    $readTables = array( "MonitorVolume"=>"MonitorVolume",
                         "LangMonitorVolume"=>"LangMonitorVolume",
                         "MonitorVolumeParams"=>"MonitorVolumeParams",
						 "DL2MonitorVolume"=>"DL2MonitorVolume" );

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "mvl", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangMonitorVolume"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "mvl" ), true, true );

        $template->setCurrentBlock( "MVL_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );
        $template->setVariable( "L1HEAD", $labelArray["Lane1Header"] );
        $template->setVariable( "L2HEAD", $labelArray["Lane2Header"] );

        $params = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$readTables["MonitorVolume"]} order by ID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $params[$rowResult["ID"]] = array(
                    "Type" => $rowResult["Type"],
                    "Volume" => $rowResult["Volume"],
                    "State" => $rowResult["State"] );
            }
            mysqli_free_result( $queryResult );
        }

        $paramsL2 = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$readTables["DL2MonitorVolume"]} order by ID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $paramsL2[$rowResult["ID"]] = array(
                    "Type" => $rowResult["Type"],
                    "Volume" => $rowResult["Volume"],
                    "State" => $rowResult["State"] );
            }
            mysqli_free_result( $queryResult );
        }

        $entries = 0;
        foreach ( $params as $ID => $paramAttributes )
        {
            if ( $paramAttributes["Type"] != "DL2Mix" )
            {
                $template->setCurrentBlock( "MVL_ENTRY" );
                $template->setVariable( "PARAM_NAME", $paramAttributes["Type"]  );
                $template->setVariable( "PARAM_DISPLAY_NAME", $labelArray[ $paramAttributes["Type"]]  );
                $template->setVariable( "ENTRY_A", ++$entries );
                $template->setVariable( "ENTRY_B", ++$entries );
                $template->setVariable( "ENTRY_C", ++$entries );
                $template->setVariable( "ENTRY_D", ++$entries );

                /* Grab the Lane 2 parameter */
                $paramL2Value = $paramsL2[$ID];

                if ( isset( $paramAttributes["State"] ) && ( $paramAttributes["State"] == 1 ) )
                {
                  $template->setVariable( "PARAM_STATE_VALUE",  $labelArray["RADIO_ON"] );
                  $template->setVariable( "RADIO_CHECKED_ON",  "CHECKED" );
                }
                else
                {
                  $template->setVariable( "PARAM_STATE_VALUE",  $labelArray["RADIO_OFF"] );
                  $template->setVariable( "RADIO_CHECKED_OFF",  "CHECKED" );
                }

                $template->setVariable( "PARAM_DISPLAY_VALUE",  $paramAttributes["Volume"] );
                $template->setVariable( "RADIO_VALUE_DISPLAY_ON",  $labelArray["RADIO_ON"] );
                $template->setVariable( "RADIO_VALUE_DISPLAY_OFF",  $labelArray["RADIO_OFF"] );
                $template->setVariable( "RADIO_VALUE_DISPLAY_ON_L2",  $labelArray["RADIO_ON"] );
                $template->setVariable( "RADIO_VALUE_DISPLAY_OFF_L2",  $labelArray["RADIO_OFF"] );
                $template->setVariable( "PARAM_DISPLAY_VALUE_L2", $paramL2Value["Volume"] );

                if ( isset( $paramL2Value["State"] ) && ( $paramL2Value["State"] == 1 ) )
                {
                  $template->setVariable( "PARAM_STATE_VALUE_L2",  $labelArray["RADIO_ON"] );
                  $template->setVariable( "RADIO_CHECKED_ON_L2",  "CHECKED" );
                }
                else
                {
                  $template->setVariable( "PARAM_STATE_VALUE_L2",  $labelArray["RADIO_OFF"] );
                  $template->setVariable( "RADIO_CHECKED_OFF_L2",  "CHECKED" );
                }
            }   
            else  // Type is DL2Mix
            {
                $template->setCurrentBlock( "MVL_MIX_ENTRY" );
                $template->setVariable( "PARAM_NAME", $paramAttributes["Type"]  );
                $template->setVariable( "PARAM_DISPLAY_NAME", $labelArray[ $paramAttributes["Type"]]  );
                $template->setVariable( "ENTRY_A", ++$entries );
                if ( isset( $paramAttributes["State"] ) && ( $paramAttributes["State"] == 1 ) )
                {
                  $template->setVariable( "PARAM_STATE_VALUE",  $labelArray["RADIO_SEPARATE"] );
                  $template->setVariable( "RADIO_CHECKED_ON",  "CHECKED" );
                  $template->setVariable( "PARAM_DISPLAY_VALUE",  $labelArray["RADIO_SEPARATE"] );
                }
                else
                {
                  $template->setVariable( "PARAM_STATE_VALUE",  $labelArray["RADIO_MIXED"] );
                  $template->setVariable( "RADIO_CHECKED_OFF",  "CHECKED" );
                  $template->setVariable( "PARAM_DISPLAY_VALUE",  $labelArray["RADIO_MIXED"] );
              }

                $template->setVariable( "RADIO_VALUE_DISPLAY_ON",  $labelArray["RADIO_SEPARATE"] );
                $template->setVariable( "RADIO_VALUE_DISPLAY_OFF",  $labelArray["RADIO_MIXED"] );
            }

            $template->setCurrentBlock( "FORM_ENTRY" );
            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "MVL_FORM" );

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
