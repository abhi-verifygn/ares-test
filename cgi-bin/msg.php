#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          msg.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the message properties generic form
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
    $readTables = array( "MSG"=>"MSG",
                         "LangMSG"=>"LangMSG",
                         "Messages"=>"Messages" );


    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "msg", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        // Read in the MSG table for settings related to global message properties
        $formData = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select ParamNameID, ParamValueID
                    from {$readTables["MSG"]} order by ID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $formData[$rowResult["ParamNameID"]] = $rowResult["ParamValueID"];
            }
            mysqli_free_result( $queryResult );
        }

        // Read in the messages
        $messages = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select MsgID, Name, Type, Duration, Enabled
                    from {$readTables["Messages"]} order by MsgID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $messages[$rowResult["MsgID"]] = array(
                    "Name" => $rowResult["Name"],
                    "Type" => $rowResult["Type"],
                    "Duration" => $rowResult["Duration"],
                    "Enabled" => $rowResult["Enabled"] );
            }
            mysqli_free_result( $queryResult );

            $messages = stripslashes_deep($messages);            
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangMSG"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "msg" ), true, true );

        $template->setCurrentBlock( "MSG_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );
        $template->setVariable( "LABEL_GREETER_INSTALLED", $labelArray["LabelGreeterInstalled"] );
        $template->setVariable( "LABEL_PLAYBACK_DELAY", $labelArray["LabelPlaybackDelay"] );
        $template->setVariable( "LABEL_PLAYBACK_TO_HEADSETS", $labelArray["LabelPlaybackToHeadsets"] );
        $template->setVariable( "LABEL_PLAYBACK_THRU_MONITOR", $labelArray["LabelPlaybackThruMonitor"] );
        $template->setVariable( "LABEL_TONE_DURING_PLAYBACK", $labelArray["LabelToneDuringPlayback"] );
        $template->setVariable( "LABEL_PLAY_RESTAURANT_CLOSED_MSG", $labelArray["LabelPlayRestaurantClosedMsg"] );
        $template->setVariable( "LABEL_PLAY_EXT_DET_MSG", $labelArray["LabelPlayExtDetectorMessage"] );
        $template->setVariable( "LABEL_TANDEM_PULL_AHEAD_MSG", $labelArray["LabelTandemPullAheadMessage"] );
        $template->setVariable( "LABEL_PLAYBACK_MODE", $labelArray["LabelPlaybackMode"] );
        $template->setVariable( "LABEL_ONE_STAR", $labelArray["LabelOneStar"] );
        $template->setVariable( "LABEL_TWO_STARS", $labelArray["LabelTwoStars"] );
        $template->setVariable( "LABEL_SELECT_HERE", $labelArray["LabelSelectHere"] );
        $template->setVariable( "PLAY_EXT_DET_MSG_OFF", $labelArray["PlayExtDetMsgOff"] );
        $template->setVariable( "PLAY_MODE_ALTERNATING", $labelArray["PlayModeAlternating"] );
        $template->setVariable( "PLAY_MODE_ONCE_EACH", $labelArray["PlayModeOnceEach"] );
        $template->setVariable( "RADIO_YES", $labelArray["RADIO_YES"] );
        $template->setVariable( "RADIO_NO", $labelArray["RADIO_NO"] );

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


        $template->setCurrentBlock( "MSG_FORM" );

        if ( isset( $formData["GreeterInstalled"] ) && ($formData["GreeterInstalled"] == 1 ) )
        {
            $template->setVariable( "GREETER_PRESENT", $labelArray["RADIO_YES"] );
        }
        else
        {
            $template->setVariable( "GREETER_PRESENT", $labelArray["RADIO_NO"] );
        }

        if ( isset( $formData["PlaybackDelay"] ) )
        {
            $template->setVariable( "PLAYBACK_DELAY_VALUE", $formData["PlaybackDelay"] );
        }

        if ( isset( $formData["PlaybackToHeadsets"] ) && ( $formData["PlaybackToHeadsets"] == 1 ) )
        {
            $template->setVariable( "PLAYBACK_TO_HEADSETS_VALUE", $labelArray["RADIO_YES"] );
            $template->setVariable( "PLAYBACK_TO_HEADSETS_YES", "CHECKED" );
        }
        else
        {
            $template->setVariable( "PLAYBACK_TO_HEADSETS_VALUE", $labelArray["RADIO_NO"] );
            $template->setVariable( "PLAYBACK_TO_HEADSETS_NO", "CHECKED" );
        }

        if ( isset( $formData["PlaybackThruMonitor"] ) && ( $formData["PlaybackThruMonitor"] == 1 ) )
        {
            $template->setVariable( "PLAYBACK_THRU_MONITOR_VALUE", $labelArray["RADIO_YES"] );
            $template->setVariable( "PLAYBACK_THRU_MONITOR_YES", "CHECKED" );
        }
        else
        {
            $template->setVariable( "PLAYBACK_THRU_MONITOR_VALUE", $labelArray["RADIO_NO"] );
            $template->setVariable( "PLAYBACK_THRU_MONITOR_NO", "CHECKED" );
        }
        if ( isset( $formData["PlaybackToneDuringPlayback"] ) && ( $formData["PlaybackToneDuringPlayback"] == 1 ) )
        {
            $template->setVariable( "TONE_DURING_PLAYBACK_VALUE", $labelArray["RADIO_YES"] );
            $template->setVariable( "TONE_DURING_PLAYBACK_YES", "CHECKED" );
        }
        else
        {
            $template->setVariable( "TONE_DURING_PLAYBACK_VALUE", $labelArray["RADIO_NO"] );
            $template->setVariable( "TONE_DURING_PLAYBACK_NO", "CHECKED" );
        }
        if ( isset( $formData["PlayRestaurantClosedMsg"] ) && ( $formData["PlayRestaurantClosedMsg"] == 1 ) )
        {
            $template->setVariable( "PLAY_RESTAURANT_CLOSED_MSG_VALUE", $labelArray["RADIO_YES"] );
            $template->setVariable( "PLAY_RESTAURANT_CLOSED_MSG_YES", "CHECKED" );
        }
        else
        {
            $template->setVariable( "PLAY_RESTAURANT_CLOSED_MSG_VALUE", $labelArray["RADIO_NO"] );
            $template->setVariable( "PLAY_RESTAURANT_CLOSED_MSG_NO", "CHECKED" );
        }
        if ( isset( $formData["TandemPullAheadMessage"] ) && ( $formData["TandemPullAheadMessage"] == 1 ) )
        {
            $template->setVariable( "TANDEM_PULL_AHEAD_MSG_VALUE", $labelArray["RADIO_YES"] );
            $template->setVariable( "TANDEM_PULL_AHEAD_MSG_YES", "CHECKED" );
        }
        else
        {
            $template->setVariable( "TANDEM_PULL_AHEAD_MSG_VALUE", $labelArray["RADIO_NO"] );
            $template->setVariable( "TANDEM_PULL_AHEAD_MSG_NO", "CHECKED" );
        }

        if ( isset( $formData[ "PlaybackMode" ] ) && ( $formData[ "PlaybackMode" ] == 0 ) )
        {
            $template->setVariable( "PLAYBACK_MODE_VALUE", $labelArray["PlayModeAlternating"] );
        }
        else
        {
            $template->setVariable( "PLAYBACK_MODE_VALUE", $labelArray["PlayModeOnceEach"] );
        }

        if ( isset( $formData[ "PlayExtDetectorMessage" ] ) )
        {
            if ( isset( $messages[  $formData[ "PlayExtDetectorMessage" ] ] ) )
            {
                $template->setVariable( "PLAY_EXT_DET_MSG_VALUE",
                      $messages[ $formData[ "PlayExtDetectorMessage" ] ]["Name"] );
            }
            else
            {
                $template->setVariable( "PLAY_EXT_DET_MSG_VALUE", $labelArray["PlayExtDetMsgOff"] );
            }
        }

        foreach( $messages as $ID => $message )
        {
            $template->setCurrentBlock( "PLAY_EXT_DET_MSG_OPTION" );
            $template->setVariable( "PEDM_MSG_ID", $ID );
            $template->setVariable( "PEDM_MSG_NAME", $message["Name"] );
            $template->parseCurrentBlock();

            $template->setCurrentBlock( "MSG_ROW" );
            $template->setVariable( "LABEL_MSG", $labelArray["LabelMessage"] );
            $template->setVariable( "LABEL_TYPE", $labelArray["LabelType"] );
            $template->setVariable( "LABEL_NAME", $labelArray["LabelName"] );
            $template->setVariable( "LABEL_DURATION", $labelArray["LabelDuration"] );
            $template->setVariable( "LABEL_ENABLED", $labelArray["LabelEnabled"] );
            $template->setVariable( "LABEL_SECONDS", $labelArray["LabelSeconds"] );
            $template->setVariable( "MSG_RADIO_YES", $labelArray["RADIO_YES"] );
            $template->setVariable( "MSG_RADIO_NO", $labelArray["RADIO_NO"] );


            $template->setVariable( "ROW_MSG_ID", $ID );
            $template->setVariable( "ROW_MSG_NAME", $message["Name"] );
            $template->setVariable( "ROW_MSG_TYPE", $labelArray[$message["Type"]] );
            $template->setVariable( "ROW_MSG_DURATION", $message["Duration"] );

            if ( $message["Enabled"] == 1 )
            {
                $template->setVariable( "ROW_MSG_ENABLED", $labelArray["RADIO_YES"] );
                $template->setVariable( "ROW_MSG_ENABLED_YES", "CHECKED" );
            }
            else
            {
                $template->setVariable( "ROW_MSG_ENABLED", $labelArray["RADIO_NO"] );
                $template->setVariable( "ROW_MSG_ENABLED_NO", "CHECKED" );
            }

            $template->parseCurrentBlock();
        }
        $template->setCurrentBlock( "MSG_FORM" );

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
