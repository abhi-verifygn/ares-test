#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          dio_config.php - Venus web-site DIO settings support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the pin sources attributable to a I/O pin
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2015
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
    
    if ( isset( $_POST["timestamp"] ) && isset( $_POST[ "sessionID" ] ) 
         && isset( $_POST["IOPinOrRelay"] ) && isset( $_POST[ "ioDirections" ]) )
    {
        $con = VenusDBConnect();

        $writeTables = array( "AdvIO"=>"AdvIO" );
        $readTables = array( "LangAdvIO"=>"LangAdvIO",
                             "Messages"=>"Messages",
                             "AdvIOPinSources"=>"AdvIOPinSources" );

        $updateable = False;

        if (!mysqli_query( $con,
                    VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            if (VenusIsUpdatableCheck( $con, "dio", $timeNow, session_id() ) === True  )
            {
                $updateable = True;
            }

            # Retrieve the IO pin directions specifed in the form
            $ioDirections = $_POST[ "ioDirections" ];

            # Retrive the IO pin/ Relay being modified
            $ioRelayToChange = intval( $_POST["IOPinOrRelay"] );
            
            # Calculate the pin direction
            if ( $ioRelayToChange <= 16 )
            {   # Pin has a configurable direction
                $ioRequestedPinDirection = $ioDirections[ $ioRelayToChange ];
            }
            else
            {   # Relay does not have a configurable direction
                $ioRequestedPinDirection = DIO_DIR_OUTPUT;
            }

            $labelArray = VenusGetLabels( $con,
                    $readTables["LangAdvIO"], $_SESSION[ SESS_LANGUAGE ] );

            $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
            $template->loadTemplatefile( VenusGetTemplateName( "dio_config" ), true, true );

            $template->setCurrentBlock( "DIO_CFG_FORM" );
            $template->setVariable( "TITLE", $labelArray["ConfigPageTitle"] );
            $template->setVariable( "CURRENT_SETTING_HEADING", $labelArray["ConfigCurrentSettingHeading"] );

            $oldPinDetails = array();
            if ( !($queryResult = @mysqli_query( $con,
                        "select *
                        from {$writeTables["AdvIO"]} 
                        where PinID='{$ioRelayToChange}';" ) ) )
            {
                VenusShowError( $con );
            }
            else
            { # Really only expect one match, the pin/relay being modified
                while ( $rowResult = mysqli_fetch_array( $queryResult ) )
                {
                    $oldPinDetails[$rowResult["PinID"]] = array(
                        "ValueDir" => $rowResult["PinMode"],
                        "Source" => $rowResult["PinSourceID"],
                        "MessageID" => $rowResult["PinSourceID"] );
                }
                mysqli_free_result( $queryResult );
            }

            # Obtain list of user audio clip names and clip types
            $messages = array();
            if ( !($queryResult = @mysqli_query( $con,
                        "select *
                        from {$readTables["Messages"]} order by MsgID;" ) ) )
            {
                VenusShowError( $con );
            }
            else
            {
                while ( $rowResult = mysqli_fetch_array( $queryResult ) )
                {
                    $messages[$rowResult["MsgID"]] = array(
                        "MessageName" => $rowResult["Name"],
                        "Type" => $rowResult["Type"]);
                }
                mysqli_free_result( $queryResult );

                $messages = stripslashes_deep($messages);
            }
            
            # Append Message Name (if applicable)
            if ( !($queryResult = @mysqli_query( $con,
                        "select {$writeTables["AdvIO"]}.PinID, MsgID from 
                            (select * from {$readTables["AdvIOPinSources"]} 
                        where MsgID != 255) as t1 
                        inner join {$writeTables["AdvIO"]} on 
                            {$writeTables["AdvIO"]}.PinSourceID = t1.SourceID;" ) ) )
            {
                VenusShowError( $con );
            }
            else
            {
                while ( $rowResult = mysqli_fetch_array( $queryResult ) )
                {
                    if (isset( $oldPinDetails[$rowResult["PinID"]]) )
                    {
                        $oldPinDetails[$rowResult["PinID"]]["MessageName"]=$messages[$rowResult["MsgID"]]["MessageName"];
                    }
                }
                mysqli_free_result( $queryResult );
            }
            
            #####################################
            # Display the current pin/replay setting value
            $pinName = key( $oldPinDetails );
            $oldPinValue = $oldPinDetails["{$pinName}"];

            $ioOriginalPinDirection = intval( $oldPinValue["ValueDir"] );
            $ioOriginalSource = $oldPinValue[ "Source" ];

            $template->setCurrentBlock( "HEADING_OLD_ENTRY" );

            # Determine prefix to use "IO" or "Relay"
            $IONumber=intval( $pinName );
            if ( ( $IONumber >= 1 ) &&  ( $IONumber <= 16 ) )
            {
                $paramDisplayName = "{$labelArray[ "IOPrefix" ]} {$pinName}";
            }
            else if ( ( $IONumber >= 17 ) &&  ( $IONumber <= 18 ) )
            {
                $paramDisplayName = "{$labelArray[ "RelayPrefix" ]} ". ($IONumber - 16);
            }
            else
            {
                die( "Only IO/Relay values from 1 through 18 are valid.");
            }

            $template->setVariable( "PARAM_DISPLAY_NAME", $paramDisplayName );
            $template->setVariable( "PARAM_DISPLAY_VALUE", $labelArray[ $ioOriginalPinDirection ] );
            

            # For message source use message name rather than source name 
            if ( isset( $oldPinValue["MessageName"]) )
            {
                $paramDisplaySourceValueName = $oldPinValue["MessageName"];
            }
            else
            {
                $paramDisplaySourceValueName = $labelArray[ $ioOriginalSource ];
            }
            
            $template->setVariable( "PARAM_DISPLAY_SOURCE_VALUE",  $paramDisplaySourceValueName ); 

            $template->parseCurrentBlock();

            #####################################
            # Display the, potentially, new pin direction value

            $template->setCurrentBlock( "HEADING_NEW_ENTRY" );

            $template->setVariable( "PARAM_DISPLAY_NAME", $paramDisplayName );
            
            $template->setVariable( 
                "PARAM_DISPLAY_VALUE", 
                $labelArray[ $ioDirections[$ioRelayToChange]] 
                );

            $template->parseCurrentBlock();

            ##################################### 
            # Now collect all possible settings for this input/output pin or relay
            
            $settings = array();
            if ( !($queryResult = @mysqli_query( $con,
                        "select *
                        from {$readTables["AdvIOPinSources"]} 
                        where PinID = '0' AND 
                            (AllowedInPinMode='{$ioRequestedPinDirection}' OR
                              AllowedInPinMode='2');" 
                        ) ) )
            {
                VenusShowError( $con );
            }
            else
            {
                while ( $rowResult = mysqli_fetch_array( $queryResult ) )
                {
                    $msgID = intval( $rowResult["MsgID"] );
                    if ( ( $msgID >= 1 ) && ( $msgID <=16 ) )
                    {
                        if ( strcmp( $messages[$rowResult["MsgID"]]["Type"], "type_alert" ) == 0 )
                        {
                            $settings[$rowResult["SourceID"]] = array(
                                "Value" => $rowResult["SourceID"],
                                "Type" =>  DATA_ENTRY_RADIO, # explicitly set to custom radio
                                "MsgID" => $rowResult["MsgID"],
                                "Name" => $messages[$rowResult["MsgID"]]["MessageName"]
                                );
                        }
                        else
                        {
                            continue;
                        }
                    }
                    else
                    {
                        $settings[$rowResult["SourceID"]] = array(
                            "Value" => $rowResult["SourceID"],
                            "Type" =>  DATA_ENTRY_RADIO, # explicitly set to custom radio
                            "Name" => $labelArray[ $rowResult["SourceID"] ]
                            );
                    }
                }
                mysqli_free_result( $queryResult );
            }

            # Since an output can be triggered by an input, append any pins set to input
            if ( $ioRequestedPinDirection == DIO_DIR_OUTPUT )
            {   # Pin is is an output so append input pins                
                if ( !($queryResult = @mysqli_query( $con,
                            "select PinID,SourceID from 
                            (select t1.SourceID, t1.PinID, AdvIO.PinMode from 
                                (select * from AdvIOPinSources where PinID != 0 
                                    and PinID != '{$ioRelayToChange}') as t1 
                                inner join AdvIO on AdvIO.PinID = t1.PinID) as t2 
                            where PinMode = '0';" 
                            ) ) )
                {
                    VenusShowError( $con );
                }
                else
                {
                    while ( $rowResult = mysqli_fetch_array( $queryResult ) )
                    {
                        $settings[$rowResult["SourceID"]] = array(
                            "Value" => $rowResult["SourceID"],
                            "Type" =>  DATA_ENTRY_RADIO, # explicitly set to custom radio
                            "Name" => $labelArray[ $rowResult["SourceID"] ]
                            );
                    }
                    
                    mysqli_free_result( $queryResult );
                }
            }

            ##################################### 
            # Now show all possible settings for this input/output pin or relay

            $template->setCurrentBlock( "DIO_CFG_FORM" );
            $template->setVariable( "NEW_SETTING_HEADING", $labelArray[ "ConfigNewSettingHeading" ] ); 

            foreach ( $settings as $settingsName => $settingsValue )
            {
                $template->setCurrentBlock( "NEW_SETTING_ENTRY" );
                
                $template->setVariable( "SETTING_DISPLAY_NAME", $labelArray[ $settingsName ] );

                switch( $settingsValue["Type"] )
                {   
                    case DATA_ENTRY_RADIO:
                    {    
                        $template->setVariable( "RADIO_SETTING_NAME", "sources" ); # Radio group name
                        
                        $template->setVariable( "RADIO_SETTING_VALUE", $settingsName );
                        $template->setVariable( "RADIO_VALUE_DISPLAY", $settingsValue["Name"] );
                        
                        if ( isset( $settingsValue["disabled"] ) )
                        {
                            $template->setVariable( "RADIO_DISABLED", "disabled" );
                        }
                        
                        # If the pin direction has changed then check the unused entry
                        if ( $ioOriginalPinDirection != $ioRequestedPinDirection )
                        {
                            if ( strcmp( "{$settingsValue["Value"]}", "UNUSED" ) == 0 )
                            {
                                $template->setVariable( "RADIO_CHECKED", "CHECKED" );
                            }
                        } 
                        else
                        { # Pin direction hasn't changed so check the current source
                            if ($settingsValue["Value"] == $ioOriginalSource )
                            {
                                $template->setVariable( "RADIO_CHECKED", "CHECKED" );
                            }
                        }
                    }
                    break;

                    default:
                    break;
                }
                
                $template->parseCurrentBlock();
                
            }
            $template->setCurrentBlock( "DIO_CFG_FORM" );

            $cancelEntry ='<input id="cancelFormButton" type="button" value="'
                    . $labelArray[ "ConfigCancelChanges" ].'" onClick="window.location=\'dio.php\'">';
            $template->setVariable( "CANCEL_ENTRY", $cancelEntry );


            $submitEntry = "Not permitted";
            if ( $updateable == True )
            {
                $submitEntry ='<input id="submitFormButton" type="submit" value="'
                    . $labelArray[ "ApplyChanges" ].'">';
            }
            $template->setVariable( "SUBMIT_ENTRY", $submitEntry );

            $template->setVariable( "HIDDEN_TIMENOW", $timeNow );
            $template->setVariable( "HIDDEN_SESSION", session_id() );
            $template->setVariable( "HIDDEN_PIN_ID", $ioRelayToChange );
            $template->setVariable( "HIDDEN_DIRECTION", $ioRequestedPinDirection );

            $template->setVariable( "ERROR_ID", AJAX_ERROR );

            if ( isset( $_SESSION[ SESS_ERROR ] ))
            {
                $template->setVariable( "SESSION_ERROR_MESSAGE", $_SESSION[ SESS_ERROR ] );
            }

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
