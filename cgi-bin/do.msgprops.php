#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.mtr.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the Monitoring settings form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    msgprops_update
    ** Parameters:      connection [in] database handle
    **                  writeTables[in] array of table names locked for writing
    **                  readTables [in] array of table names locked for reading
    **                  requestData [in] data orginating from form
    **                  errors [in/out] error information as concatenated strings
    ** Returns:         true if update occurred, false otherwise
    **
    ** This function is called by the VenusPerformFormMultiTableUpdate helper function when
    ** requestData is ready to be written to the write locked table.
    **
    */
    function msgprops_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        // Update the messages's parameters
        if ( !isset($requestData["message"] ) )
        {
            $errors[] = "No message data has been specified. Nothing to do.";
            return false;        
        } 
        
        if (count( $requestData["message"] ) != 1 )
        {
            $errors[] = "Processor designed to process a _single_ message's properies. Aborted.";
            return false;        
        }
        
        if ( ( !isset($requestData["headsets"]) ) || ( !isset($requestData["dayParts"]) ) )
        {
            $errors[] = "Processor designed to process headset and dayparts updates. Missing. Aborted.";
            return false;        
        }
        
        // Extract message ID and sanitize
        $messageID = intval( VenusMySqlVarClean( key($requestData["message"]), 2, $connection ) );
        
        if (!isset( $requestData["headsets"][$messageID] ) )
        {
            $error[] = "No headset data for message with ID '{$messageID}'.";
            return false;
        }
        
        if (!isset( $requestData["dayParts"][$messageID] ) )
        {
            $error[] = "No day-part data for message with ID '{$messageID}'.";
            return false;
        }

        // Check message attributes
        $message = $requestData["message"][$messageID];
        
        $cleanName = VenusMySqlVarClean( $message["name"], 16, $connection );
        if ( empty( $cleanName ) )
        {
            $errors[] = "Message name cannot be empty.";
            return false;
        }
        
        $cleanType = VenusMySqlVarClean( $message["type"], 16, $connection );
        $validMatch = false;
        $validTypes = array( 
            "type_greeter"=>"GREETER", 
            "type_alert"=>"ALERT", 
            "type_reminder"=>"REMINDER",
            "type_closed"=>"CLOSED",
            "type_forward"=> "FORWARD",
            "type_null"=>"NULL"  );
            
        foreach ( $validTypes as $type=>$typeText )
        {
            if ( strcmp( $cleanType, $typeText ) == 0 )
            {
                $validMatch = true;
                $cleanType = $type;
                break;
            }
        }
        if ( !$validMatch )
        {
            $errors[] = "Message type not recognised.";
            return false;
        }
        
        if ( strcmp( $cleanType, "type_null") == 0)
        {
            $errors[] = $cleanType . " Cannot change a message of type NULL.";
            return false;
        }
        
        $cleanEnabled = intval( VenusMySqlVarClean( $message["enabled"], 1, $connection ) );
        $cleanEnabled &= 1;
        $cleanMonitor = intval( VenusMySqlVarClean( $message["monitor"], 1, $connection ) );
        $cleanMonitor &= 1;
        $cleanPriority = intval( VenusMySqlVarClean( $message["priority"], 1, $connection ) );
        $cleanPriority &= 1;
        
        $cleanRepeatCount = intval( VenusMySqlVarClean( $message["repeatCount"], 3, $connection ) );
        if ( ( $cleanRepeatCount < MIN_REPEAT_COUNT ) || ($cleanRepeatCount > MAX_REPEAT_COUNT ) )
        {
            $errors[] = "Repeat count - out of bounds - ".MIN_REPEAT_COUNT." to ".MAX_REPEAT_COUNT." valid" ;
            return false;
        }
        
        $cleanDelay = VenusMySqlVarClean( $message["delay"], 5, $connection );
        
        $delayDateTime = date_create_from_format( "i:s", $cleanDelay );
        
        if ( $delayDateTime == false )
        {
            $errors[] = "Delay must be in the format mm:ss. Delay entered {$cleanDelay}.";
            return false;
        }
        if ( strcmp( date_format( $delayDateTime, "i:s" ), $cleanDelay ) != 0 )
        {
            $errors[] = "Time formatting is not recognised. Delay entered {$cleanDelay}.";
            return false;
        }
        
        $cleanRepeatInterval = VenusMySqlVarClean( $message["repeatInterval"], 8, $connection );
        
        $repeatIntervalDateTime = date_create_from_format( "H:i:s", $cleanRepeatInterval );
        
        if ( $delayDateTime == false )
        {
            $errors[] = "Interval must be in the format mm:ss. Interval entered {$cleanRepeatInterval}.";
            return false;
        }
        if ( strcmp( date_format( $repeatIntervalDateTime, "H:i:s" ), $cleanRepeatInterval ) != 0 )
        {
            $errors[] = "Time formatting is not recognised. Interval entered {$cleanRepeatInterval}.";
            return false;
        }

        $headsetsEnable = 0;
        for( $headsetID = NO_OF_HEADSETS; $headsetID >= 1; $headsetID-- )
        {
            $headsetEnabled = $requestData["headsets"][$messageID][ "$headsetID" ];
            $cleanHeadSetEnabled = intval( VenusMySqlVarClean( $headsetEnabled, 1, $connection ) );
            $cleanHeadSetEnabled &= $cleanHeadSetEnabled;

            $headsetsEnable = $headsetsEnable  << 1;
            if ( $cleanHeadSetEnabled )
            {
                $headsetsEnable = $headsetsEnable | 0x1;
            }
        }

        $daysOfWeek = array( "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" );
        $dayPartNames = array( "MonDayParts", "TueDayParts", "WedDayParts", "ThuDayParts", "FriDayParts", "SatDayParts", "SunDayParts" );
        
        $msgPlaysOnDays = array();
        for ( $dayNo = 0; $dayNo < NO_OF_DAYS; $dayNo++ )
        {
            $dayPartEnable = 0;
            for ( $dayPartID = NO_OF_DAYPARTS; $dayPartID >= 1; $dayPartID-- )
            {
                $dayPartEnabled = $requestData["dayParts"][$messageID][ $daysOfWeek[ $dayNo ] ][$dayPartID ];
                $cleanDayPartEnabled = intval( VenusMySqlVarClean( $dayPartEnabled, 1, $connection ) );
                $cleanDayPartEnabled &= $cleanDayPartEnabled;

                $dayPartEnable = $dayPartEnable  << 1;
                if ( $cleanDayPartEnabled )
                {
                    $dayPartEnable = $dayPartEnable | 0x1;
                }
            }
            $msgPlaysOnDays["{$dayPartNames[ $dayNo ]}"] = $dayPartEnable;
        }

        // Update the message table with validated content
        if ( !mysqli_query( $connection,
                "UPDATE {$writeTables["Messages"]}
                SET Name ='{$cleanName}',
                    Type ='{$cleanType}',
                    Enabled ='{$cleanEnabled}',
                    PlayToMonitor ='{$cleanMonitor}',
                    Priority ='{$cleanPriority}',
                    RepeatInterval ='{$cleanRepeatInterval}',
                    Delay ='{$cleanDelay}',
                    RepeatCount ='{$cleanRepeatCount}',
                    HeadsetEnable ='{$headsetsEnable}',
                    MonDayParts = '{$msgPlaysOnDays['MonDayParts']}',
                    TueDayParts = '{$msgPlaysOnDays['TueDayParts']}',
                    WedDayParts = '{$msgPlaysOnDays['WedDayParts']}',
                    ThuDayParts = '{$msgPlaysOnDays['ThuDayParts']}',
                    FriDayParts = '{$msgPlaysOnDays['FriDayParts']}',
                    SatDayParts = '{$msgPlaysOnDays['SatDayParts']}',
                    SunDayParts = '{$msgPlaysOnDays['SunDayParts']}'
                WHERE MsgID='{$messageID}';" ) )
        {
            VenusShowError( $connection );
            return false;
        }
        
        return true;
    }

    /******************************************************************************
    **  Script entry point
    **
    */
    if ( session_start() == false )
    {
        exit;
    }

    if ( VenusSessionAuthenticate() == false )
    {
        exit;
    }

    $_SESSION[ SESS_ERROR ] = "";
    $_SESSION[ SESS_MESSAGE ] = "";

    if ( isset( $_POST["timestamp"] ) && isset( $_POST[ "sessionID" ] ) )
    {
        $warnings = array();
        $writeTables = array( "Messages"=>"Messages" );
        $readTables = array( );
                             



        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "msgprops", "msgprops_update", $warnings ) )
        {
            $_SESSION[ SESS_ERROR ] = $warnings;
        }

        header(
            "Location: {$_SERVER["HTTP_REFERER"]}",
            true, // replace any existing location header
            303   // HTTP "303 see other" response code
            );
        exit;
    }
    else
    {
         // Authenticated user, but trying to directly access a form processor
        $_SESSION[SESS_MESSAGE] = "You are not allowed to access this resource directly.";
        header(
            "location: logout.php",
            true, // replace any existing location header
            303   // HTTP "303 see other" response code
            );
        exit;
    }
?>
