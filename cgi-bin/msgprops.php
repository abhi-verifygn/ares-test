#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          msgprops.php - Venus web-site login support
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
    $readTables = array( "Messages"=>"Messages",
                         "LangMSGPROPS"=>"LangMSGPROPS",
                         "Headsets"=>"Headsets",
                         "GRD"=>"GRD");


    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        $formData = array();

        // Determine the message ID
        $messageID = 0;
        if ( isset( $_GET ) && isset( $_GET[ "msgprops" ] ) )
        {
            $messageID = intval( substr( $_GET[ "msgprops" ], 0, 2 ) );

            if ( $messageID > 0 )
            {
                if ( !($queryResult = @mysqli_query( $con,
                            "select *
                            from {$readTables["Messages"]} 
                            where MsgId = '{$messageID}' 
                            order by MsgID;" ) ) )
                {
                    VenusShowError( $con );
                }
                else
                {
                    while ( $rowResult = mysqli_fetch_array( $queryResult ) )
                    {
                        $rowResult = stripslashes_deep($rowResult);

                        $formData[$rowResult["MsgID"]] = array(
                            "Name" => $rowResult["Name"],
                            "Type" => $rowResult["Type"],
                            "Enabled" => $rowResult["Enabled"],
                            "PlayToMonitor" => $rowResult["PlayToMonitor"],
                            "Priority" => $rowResult["Priority"],
                            "Delay" => $rowResult["Delay"],
                            "RepeatCount" => $rowResult["RepeatCount"],
                            "RepeatInterval" => $rowResult["RepeatInterval"],
                            "Duration" => $rowResult["Duration"],
                            "HeadsetEnable" => $rowResult["HeadsetEnable"],
                            "MonDayParts" => $rowResult["MonDayParts"],
                            "TueDayParts" => $rowResult["TueDayParts"],
                            "WedDayParts" => $rowResult["WedDayParts"],
                            "ThuDayParts" => $rowResult["ThuDayParts"],
                            "FriDayParts" => $rowResult["FriDayParts"],
                            "SatDayParts" => $rowResult["SatDayParts"],
                            "SunDayParts" => $rowResult["SunDayParts"] );
                    }
                    if ( !isset( $formData[ strval( $messageID ) ] ) )
                    {
                        unset( $messageID );
                    }
                    mysqli_free_result( $queryResult );
                }
            }
        }

        // Determine the message ID (and whether it is valid)
        if ( !isset( $messageID ) || (isset( $messageID ) && empty( $messageID ) ) )
        {
             // Authenticated user, but trying to access the form processor without properly
             // formed message ID request.
            $_SESSION[SESS_MESSAGE] = "Requested message properties for unknown message - logging out.";
            header(
                "location: logout.php",
                true, // replace any existing location header
                303   // HTTP "303 see other" response code
                );
            exit;
        }

        // MessageID is a valid message within the system, continue
        $messageID = strval( $messageID );



        $headsets = array();
        // Determine the list of headsets defined
        if ( !($queryResult = @mysqli_query( $con,
                    "SELECT ID, Name
                    FROM {$readTables["Headsets"]}
                    order by ID;"  ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $headsets[] = array( "ID"=>$rowResult["ID"], "Name"=>$rowResult["Name"] );
            }
            mysqli_free_result( $queryResult );
        }

        // Determine which headsets have this message enabled
        $msgPlaysOnHeadsets = array();
        $headsetsEnable = $formData[$messageID][ "HeadsetEnable" ];

        for ( $headsetID = 1; $headsetID <= NO_OF_HEADSETS; $headsetID++ )
        {
            if ( ( $headsetsEnable & 0x1 ) == 0x1 )
            {
                $msgPlaysOnHeadsets[] = $headsetID;
            }
            $headsetsEnable = $headsetsEnable >> 1; 
        }

        // Determine the list of dayparts defined
        $dayParts = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "SELECT ID, Name
                    FROM {$readTables["GRD"]}
                    order by ID;"  ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $dayParts[] = array( "ID"=>$rowResult["ID"], "Name"=>$rowResult["Name"] );
            }
            mysqli_free_result( $queryResult );
        }

        // Determine on which day(s) each day's dayparts play this message
        $daysOfWeek = array( "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" );
        $dayPartNames = array( "MonDayParts", "TueDayParts", "WedDayParts", "ThuDayParts", "FriDayParts", "SatDayParts", "SunDayParts" );
        
        $msgPlaysOnDays = array();
        for ( $dayNo = 0; $dayNo < NO_OF_DAYS; $dayNo++ )
        {
            $messageEnable = $formData[ $messageID ][ $dayPartNames[ $dayNo ] ];

            for ( $dayPartID = 1; $dayPartID <= NO_OF_DAYPARTS; $dayPartID++ )
            {
                if ( ( $messageEnable & 0x1 ) == 0x1 )
                {
                    $msgPlaysOnDays[ $daysOfWeek[ $dayNo ] ][] = $dayPartID;
                }
                $messageEnable = $messageEnable >> 1; 
            }
        }

        if (VenusIsUpdatableCheck( $con, "msgprops", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangMSGPROPS"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "msgprops" ), true, true );

        $template->setCurrentBlock( "MSGPROPS_BODY" );
        $template->setVariable( "BDY_TIMENOW", $timeNow );
        $template->setVariable( "BDY_SESSION", session_id() );
        $template->setVariable( "BDY_MSGID", $messageID );
        $template->parseCurrentBlock();

        $template->setCurrentBlock( "MSGPROPS_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );
        $template->setVariable( "MSGID", $messageID );
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

        $entries = 0;
        // Message properties table headings
        $template->setVariable( "LABEL_MESSAGE", $labelArray["MessageLabel"] );
        $template->setVariable( "LABEL_NAME", $labelArray["NameLabel"] );
        $template->setVariable( "ENTRY_A", ++$entries );
        $template->setVariable( "LABEL_TYPE", $labelArray["TypeLabel"] );
        $template->setVariable( "ENTRY_B", ++$entries );
        $template->setVariable( "LABEL_ENABLED", $labelArray["EnabledLabel"] );
        $template->setVariable( "ENTRY_C", ++$entries );
        $template->setVariable( "LABEL_PLAY_TO_MONITOR", $labelArray["PlayToMonitorLabel"] );
        $template->setVariable( "ENTRY_D", ++$entries );
        $template->setVariable( "LABEL_PRIORITY", $labelArray["PriorityLabel"] );
        $template->setVariable( "ENTRY_E", ++$entries );
        $template->setVariable( "LABEL_DELAY", $labelArray["DelayLabel"] );
        $template->setVariable( "ENTRY_F", ++$entries );
        $template->setVariable( "LABEL_REPEAT_INTERVAL", $labelArray["RepeatIntervalLabel"] );
        $template->setVariable( "ENTRY_G", ++$entries );
        $template->setVariable( "LABEL_REPEAT_COUNT", $labelArray["RepeatCountLabel"] );
        $template->setVariable( "ENTRY_H", ++$entries );
        $template->setVariable( "LABEL_DURATION", $labelArray["DurationLabel"] );
        $template->setVariable( "ENTRY_I", ++$entries );
        $template->setVariable( "LABEL_RECORD_PLAY_ACTION", $labelArray["PlayRecordActionLabel"] );
        $template->setVariable( "LABEL_RECORD_PLAY_CAPTION", $labelArray["OpenPlayRecordControlCaption"] );
        $template->setVariable( "LABEL_HEADSETS", $labelArray["PlayToHeadsetsLabel"] );
        $template->setVariable( "LABEL_HEADSET_NAME", $labelArray["HeadsetLabel"] );
        $template->setVariable( "LABEL_PLAY_TO_HEADSET", $labelArray["PlayToHeadsetLabel"] );
        $template->setVariable( "MSG_TYPE_ALERT", $labelArray["type_alert"] );
        $template->setVariable( "MSG_TYPE_REMINDER", $labelArray["type_reminder"] );
        $template->setVariable( "MSG_TYPE_GREETER", $labelArray["type_greeter"] );
        $template->setVariable( "MSG_TYPE_CLOSED", $labelArray["type_closed"] );
        $template->setVariable( "MSG_TYPE_FORWARD", $labelArray["type_forward"] );
        $template->setVariable( "MSG_TYPE_NULL", $labelArray["type_null"] );
        $template->setVariable( "RADIO_YES", $labelArray["RADIO_YES"] );
        $template->setVariable( "RADIO_NO", $labelArray["RADIO_NO"] );


        $template->setVariable( "MESSAGE_NAME", $formData[$messageID]["Name"] );

        $template->setVariable( "MESSAGE_TYPE", $labelArray[ $formData[$messageID]["Type"] ] );

        switch( $formData[$messageID]["Type"] )
        {
            case "type_alert":
                $template->setVariable( "TYPE_ALERT_SELECTED", "SELECTED" );
                break;
            case "type_reminder":
                $template->setVariable( "TYPE_RMD_SELECTED", "SELECTED" );
                break;
            case "type_closed":
                $template->setVariable( "TYPE_CLOSED_SELECTED", "SELECTED" );
                break;
            case "type_forward":
                $template->setVariable( "TYPE_FWD_SELECTED", "SELECTED" );
                break;
            case "type_null":
                $template->setVariable( "TYPE_NULL_SELECTED", "SELECTED" );
                break;

            case "type_greeter":
            default:
                $template->setVariable( "TYPE_GRT_SELECTED", "SELECTED" );
            break;
        }

        // Message enabled
        if ( $formData[$messageID]["Enabled"] == 1 )
        {
            $template->setVariable( "MESSAGE_ENABLED", $labelArray["RADIO_YES"] );
            $template->setVariable( "MESSAGE_ENABLED_YES", "CHECKED" );
        }
        else
        {
            $template->setVariable( "MESSAGE_ENABLED", $labelArray["RADIO_NO"] );
            $template->setVariable( "MESSAGE_ENABLED_NO", "CHECKED" );
        }

        // Play to monitor
        if ( $formData[$messageID]["PlayToMonitor"] == 1 )
        {
            $template->setVariable( "MESSAGE_MONITOR", $labelArray["RADIO_YES"] );
            $template->setVariable( "MESSAGE_MONITOR_YES", "CHECKED" );
        }
        else
        {
            $template->setVariable( "MESSAGE_MONITOR", $labelArray["RADIO_NO"] );
            $template->setVariable( "MESSAGE_MONITOR_NO", "CHECKED" );
        }

        // Priority
        if ( $formData[$messageID]["Priority"] == 1 )
        {
            $template->setVariable( "MESSAGE_PRIORITY", $labelArray["RADIO_YES"] );
            $template->setVariable( "MESSAGE_PRIORITY_YES", "CHECKED" );
        }
        else
        {
            $template->setVariable( "MESSAGE_PRIORITY", $labelArray["RADIO_NO"] );
            $template->setVariable( "MESSAGE_PRIORITY_NO", "CHECKED" );
        }

        $template->setVariable( "MESSAGE_DELAY", $formData[$messageID]["Delay"] );
        $template->setVariable( "MESSAGE_REPEAT_COUNT", $formData[$messageID]["RepeatCount"] );
        $template->setVariable( "MESSAGE_REPEAT_INTERVAL", $formData[$messageID]["RepeatInterval"] );
        $template->setVariable( "MESSAGE_DURATION", $formData[$messageID]["Duration"] );

        // Present the headsets available to allow user to mark which should receive this message
        for ( $i = 0; $i < count( $headsets ); $i += 2 )
        {
            $template->setCurrentBlock( "P2H_ROW" );
            for ( $j = 0; $j <= 1 ; $j++ )
            {
                if ( isset( $headsets[$i + $j] ) )
                {
                    $headset = $headsets[$i + $j];
                    $template->setCurrentBlock( "P2H_ENTRY" );

                    $template->setVariable( "P2H_HEADSET_NAME", $headset["Name" ] );
                    $template->setVariable( "P2H_HEADSET_ENTRY_NO", ++$entries );
                    $template->setVariable( "P2H_MSG_ID", $messageID );
                    $template->setVariable( "HEADSET_ID", $headset[ "ID" ] );
                    $template->setVariable( "P2H_RADIO_YES", $labelArray["RADIO_YES"] );
                    $template->setVariable( "P2H_RADIO_NO", $labelArray["RADIO_NO"] );
                    if ( in_array( $headset[ "ID" ], $msgPlaysOnHeadsets ) )
                    {
                        $template->setVariable( "P2H_HEADSET_ENABLED_VALUE",
                            $labelArray["RADIO_YES"] );
                        $template->setVariable( "P2H_HEADSET_ENABLED_YES", "CHECKED" );
                    }
                    else
                    {
                        $template->setVariable( "P2H_HEADSET_ENABLED_VALUE",
                            $labelArray["RADIO_NO"] );
                        $template->setVariable( "P2H_HEADSET_ENABLED_NO", "CHECKED" );
                    }

                    $template->parseCurrentBlock();
                }
            }
            $template->setCurrentBlock( "P2H_ROW" );
            $template->parseCurrentBlock();
        }
        $template->setCurrentBlock( "MSGPROPS_FORM" );

        // Progresses through days of the week, presenting the day-parts for each
        foreach ( $daysOfWeek as $day )
        {
            $template->setCurrentBlock( "DAY_DAYPART" );
            $template->setVariable( "LABEL_DAY_DAYPARTS", $labelArray[$day."DayPartsLabel"] );
            $template->setVariable( "LABEL_DAY",  $labelArray[$day."Label"] );
            $template->setVariable( "LABEL_MSG_PLAYS", $labelArray["MessagePlaysLabel"] );

            for ( $i = 0; $i < count( $dayParts ); $i += 2 )
            {
                $template->setCurrentBlock( "DAY_DAYPARTS_ROW" );
                for ( $j = 0; $j <= 1 ; $j++ )
                {
                    if ( isset( $dayParts[$i + $j] ) )
                    {
                        $dayPart = $dayParts[$i + $j];

                        $template->setCurrentBlock( "DAY_DAYPARTS_CELL" );

                        $template->setVariable( "DDC_DAY_PART_NAME", $dayPart["Name" ] );
                        $template->setVariable( "DDC_ENTRY_NO", ++$entries );
                        $template->setVariable( "DDC_MSG_ID", $messageID );
                        $template->setVariable( "DDC_ID", $dayPart[ "ID" ] );
                        $template->setVariable( "DDC_LABEL_DAY", $day );
                        $template->setVariable( "DDC_RADIO_YES", $labelArray["RADIO_YES"] );
                        $template->setVariable( "DDC_RADIO_NO", $labelArray["RADIO_NO"] );

                        // Assume that no day part for this day has been enabled
                        $template->setVariable( "DDC_ENABLED_VALUE", $labelArray["RADIO_NO"] );
                        $template->setVariable( "DDC_ENABLED_NO", "CHECKED" );

                        if ( isset($msgPlaysOnDays[$day]) && is_array( $msgPlaysOnDays[$day] ) )
                        {
                            if ( in_array( $dayPart[ "ID" ], $msgPlaysOnDays[$day] ) )
                            {
                                $template->setVariable( "DDC_ENABLED_VALUE",
                                    $labelArray["RADIO_YES"] );
                                $template->setVariable( "DDC_ENABLED_NO", "" );
                                $template->setVariable( "DDC_ENABLED_YES", "CHECKED" );
                            }
                        }

                        $template->parseCurrentBlock();
                    }
                }
                $template->setCurrentBlock( "DAY_DAYPARTS_ROW" );
                $template->parseCurrentBlock();
            }
            $template->setCurrentBlock( "DAY_DAYPART" );
            $template->parseCurrentBlock();
        }
        $template->setCurrentBlock( "MSGPROPS_FORM" );

        $template->setCurrentBlock( "MSGPROPS_FORM" );

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
