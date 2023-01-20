#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          ngt.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the night volume settings form
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
    $readTables = array( "NightVolume"=>"NightVolume",
                         "LangNightVolume"=>"LangNightVolume",
                         "Volume"=>"Volume",
						 "DL2NightVolume"=>"DL2NightVolume",
						 "DL2Volume"=>"DL2Volume",);

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "ngt", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangNightVolume"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "ngt" ), true, true );

        $template->setCurrentBlock( "NGT_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );
        $template->setVariable( "L1HEAD", $labelArray["Lane1Header"] );
        $template->setVariable( "L2HEAD", $labelArray["Lane2Header"] );


        // Special case. One item is a read-only value from another table
        $template->setVariable( "DAY_OUTBOUND_TALK_VOL", $labelArray["TalkVol"] );
        $params = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select ParamNameID, ParamValueID
                    from {$readTables["Volume"]}
                    where ParamNameID = 'TalkVol';" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            if ( ($rowResult = mysqli_fetch_array( $queryResult )) != null )
            {
                $params[$rowResult["ParamNameID"]] = array(
                    "Value" => $rowResult["ParamValueID"] );
            }
            mysqli_free_result( $queryResult );
        }
        if ( isset( $params[ "TalkVol" ]) )
        {
            $talkVol = $params[ "TalkVol" ]["Value"];
            $template->setVariable( "DAY_OUTBOUND_TALK_VOL_PARAM_NAME", "TalkVol"  );
            $template->setVariable( "DAY_OUTBOUND_TALK_VOL_VALUE", $talkVol );
        }
		
		// And the lane 2 version...
        if ( !($queryResult = @mysqli_query( $con,
                    "select ParamNameID, ParamValueID
                    from {$readTables["DL2Volume"]}
                    where ParamNameID = 'TalkVol';" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            if ( ($rowResult = mysqli_fetch_array( $queryResult )) != null )
            {
                $params[$rowResult["ParamNameID"]] = array(
                    "Value" => $rowResult["ParamValueID"] );
            }
            mysqli_free_result( $queryResult );
        }
        if ( isset( $params[ "TalkVol" ]) )
        {
            $talkVolL2 = $params[ "TalkVol" ]["Value"];
            $template->setVariable( "DAY_OUTBOUND_TALK_VOL_PARAM_NAME_L2", "TalkVol_L2"  );
            $template->setVariable( "DAY_OUTBOUND_TALK_VOL_VALUE_L2", $talkVolL2 );
        }


        // Special case done, read data from associated tables
        $params = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$readTables["NightVolume"]} order by ID;" ) ) )
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

		// And the lane 2 version...
        $paramsL2 = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$readTables["DL2NightVolume"]} order by ID;" ) ) )
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

        // Limit max night reduction to the value of outbound talk volume
        if ( isset( $talkVol ) )  # lane 1
        {
            $redNgtVol = $params["ReduceDriveThruVolBy"]["Value"];
            if ( $redNgtVol > $talkVol )
            {
                $params["ReduceDriveThruVolBy"]["Value"] =  $talkVol;
            }
        }
        if ( isset( $talkVolL2 ) ) # lane 2
        {
            $redNgtVolL2 = $paramsL2["ReduceDriveThruVolBy"]["Value"];
            if ( $redNgtVolL2 > $talkVolL2 )
            {
                $paramsL2["ReduceDriveThruVolBy"]["Value"] =  $talkVolL2;
            }
        }

        // Standard form processing
        $entries = 0;
        foreach ( $params as $paramName => $paramValue )
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
					$template->setVariable( "PARAM_DISPLAY_VALUE_L2", $paramL2Value["Value"] );
                    $template->setCurrentBlock( "FORM_TEXT" );
                    $template->setVariable( "TEXT_PARAM_NAME", $paramName  );
                    $template->setVariable( "TEXT_PARAM_NAME_L2", $paramName."_L2"  );
                    $template->setVariable( "TEXT_DISPLAY_VALUE", $paramValue["Value"]  );
					$template->setVariable( "TEXT_DISPLAY_VALUE_L2", $paramL2Value["Value"]  );
                    $template->parseCurrentBlock();
                    break;
                default:
                    break;
            }
            $template->setCurrentBlock( "FORM_ENTRY" );
            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "NGT_FORM" );

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
