#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          dio.php - Venus web-site DIO settings support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the digitial I/O settings
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

        $labelArray = VenusGetLabels( $con,
                $readTables["LangAdvIO"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "dio" ), true, true );

        $template->setCurrentBlock( "DIO_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );


        $params = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$writeTables["AdvIO"]} order by PinID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $params[$rowResult["PinID"]] = array(
                    "ValueDir" => $rowResult["PinMode"],
                    "Type" =>  DATA_ENTRY_RADIO, # explicitly set to custom radio
                    "Source" => $rowResult["PinSourceID"],
                    "MessageID" => $rowResult["PinSourceID"] );
            }
            mysqli_free_result( $queryResult );
        }
        # Set-up the custom radio fields explicitly rather than
        # reading from a parameters table.
        foreach ( $params as $paramName => $param )
        {
            $params[$paramName]["Options"]["0"] = "0";
            $params[$paramName]["Options"]["1"] = "1";
        
            if ( intval($paramName) > 16 )
            { # Assume pin is a relay, so disable radio buttons for this pin
                $params[$paramName]["disabled"] = "disabled";
            }
        }
        
        # Obtain list of message names
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
                    "MessageName" => $rowResult["Name"]);
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
                $params[$rowResult["PinID"]]["MessageName"]=$messages[$rowResult["MsgID"]]["MessageName"];
            }
            mysqli_free_result( $queryResult );
        }

        $entries = 0;

        foreach ( $params as $paramName => $paramValue )
        {
            $template->setCurrentBlock( "FORM_ENTRY" );
            
            $IONumber=intval( $paramName );
            
            if ( ( $IONumber >= 1 ) &&  ( $IONumber <= 16 ) )
            {
                $paramDisplayName = "{$labelArray[ "IOPrefix" ]} {$paramName}";
            }
            else if ( ( $IONumber >= 17 ) &&  ( $IONumber <= 18 ) )
            {
                $paramDisplayName = "{$labelArray[ "RelayPrefix" ]} ". ($IONumber - 16);
            }
            else
            {
                # Ignore this entry - we only deal with IO 1-16 and Relays 1 & 2
                continue;
            }
            $template->setVariable( "PARAM_DISPLAY_NAME", $paramDisplayName );
            $template->setVariable( "PARAM_NAME", $paramName  );
            $template->setVariable( "ENTRY_NO", ++$entries );

            switch( $paramValue["Type"] )
            {
                case DATA_ENTRY_RADIO:
                    $template->setVariable( "PARAM_DISPLAY_VALUE", $labelArray[ $paramValue["ValueDir"]] );
                    if ( isset( $paramValue[ "Options" ] ) )
                    {
                        $numOptions = count( $paramValue[ "Options" ] );
                        $displayedOptions = 0;
                        foreach( $paramValue[ "Options" ] as $Name => $Value )
                        {
                            $template->setCurrentBlock( "FORM_RADIO" );
                            $template->setVariable( "RADIO_PARAM_NAME", $paramName );
                            $template->setVariable( "RADIO_VALUE", $Name );
                            $template->setVariable( "RADIO_VALUE_DISPLAY", $labelArray[$Name] );
                            if ( isset( $paramValue["disabled"] ) )
                            {
                                $template->setVariable( "RADIO_DISABLED", "disabled" );
                            }
                            if ($paramValue["ValueDir"]== $Name )
                            {
                                $template->setVariable( "RADIO_CHECKED", "CHECKED" );
                            }
                            ++$displayedOptions;
                            if ( $displayedOptions < $numOptions )
                            {
                                // Seperator between radio buttons only
                                $template->touchBlock( "FORM_RADIO_SEPARATOR" );
                            }
                            $template->parseCurrentBlock();
                        }
                    }
                    break;

                default:
                    break;
            }
            
            $template->setCurrentBlock( "FORM_ENTRY" );

            if ( isset( $paramValue["MessageName"]) )
            {
                $paramDisplaySourceValueName = $paramValue["MessageName"];
            }
            else
            {
                $paramDisplaySourceValueName = $labelArray[ $paramValue[ "Source" ] ];
            }

            $template->setVariable( "PARAM_DISPLAY_SOURCE_VALUE",  $paramDisplaySourceValueName ); 

            $configButton ='<button name="IOPinOrRelay" type="submit" value="'
                . $paramName . '"' 
                . ( ($updateable == False) ? ' disabled ' : '' )
                . '>'
                . $labelArray[ "CONFIGURE_BUTTON_TEXT" ]
                . '</button>';

            $template->setVariable( "CONFIGURE_BUTTON", $configButton );
            
            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "DIO_FORM" );

        $template->setVariable( "HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "HIDDEN_SESSION", session_id() );

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
?>
