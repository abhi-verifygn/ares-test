#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          msc.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the network settings form
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "HTML/Template/ITX.php";
    require_once "venus_helper.php";

    /******************************************************************************/
    /*    Macro Definitions                                                       */
    /******************************************************************************/
    define( "SYS_NET_IPADDR",  "SYS_NET_IPADDR"  );
    define( "SYS_NET_SUBNET",  "SYS_NET_SUBNET"  );
    define( "SYS_NET_GATEWAY", "SYS_NET_GATEWAY" );
    define( "SYS_NET_MAC",     "SYS_NET_MAC"     );
    define( "SYS_WEB_PORT",    "SYS_WEB_PORT"    );
    define( "SYS_WEB_ENABLED", "SYS_WEB_ENABLED" );
    define( "NET_ADDR_LEN",    20                );
    define( "WEB_SETTING_LEN", 10                );

    /******************************************************************************
    ** Function:    GetSysVariable
    ** Parameters:      sysVarName [in] name of "system" variable to be retrieved
    **                  value [out] current value of "system" variable
    **                  valueLen [in] Maximum expected string length
    ** Returns:         true if  variable
    **
    ** Reads up to valueLength characters from file named sysVarName from system
    ** tmp folder and returns the string as value.
    ** 
    ** Any failure to read the value causes the function to return false
    */
    function GetSysVariable( $sysVarName, &$value, $valueLen )
    {
        $success = false;
        $value = '';
        
        $fileName = "/tmp/" . $sysVarName;
        
        if ( file_exists( $fileName ) )
        {
            $result = file_get_contents( $fileName, false, NULL, 0, $valueLen );
            if( is_string( $result ) )
            {
                $value = $result;
                $success = true;
            }
        }
        
        return $success;
    }

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

    $readTables = array( "LangNetworkSettings"=>"LangNetworkSettings");

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "msc", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangNetworkSettings"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "msc" ), true, true );

        $template->setCurrentBlock( "NET_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );

        /*
         * Rather than extract value data from database, load values from file system variables
         * and construct a parameter array suitable for the generic page processing structure
         * used on other pages. Note that the language database table is still read and
         * therefore labels used in systemData array must match those in the language table.
         */
        $systemData = array();
        
        GetSysVariable( SYS_NET_MAC,     $systemData['MACAddress']['Value'], NET_ADDR_LEN );
        $systemData['MACAddress']['Type'] = DATA_ENTRY_DISPLAY_ONLY;

        GetSysVariable( SYS_NET_IPADDR,  $systemData['IPAddress']['Value'],  NET_ADDR_LEN );
        $systemData['IPAddress']['Type'] = DATA_ENTRY_TEXT;
        
        GetSysVariable( SYS_NET_SUBNET,  $systemData['SubnetMask']['Value'],     NET_ADDR_LEN );
        $systemData['SubnetMask']['Type'] = DATA_ENTRY_TEXT;

        GetSysVariable( SYS_NET_GATEWAY, $systemData['DefaultGateway']['Value'],    NET_ADDR_LEN );
        $systemData['DefaultGateway']['Type'] = DATA_ENTRY_TEXT;

        $systemData['WebServerEnabled']['Value'] = DATA_ENTRY_YES;
        $systemData['WebServerEnabled']['Type'] = DATA_ENTRY_YESNO_RADIO;
        $systemData['WebServerEnabled']['Options'] = array( DATA_ENTRY_YES => "1", DATA_ENTRY_NO => "0" );

        GetSysVariable( SYS_WEB_PORT,    $systemData['WebServerPort']['Value'],    NET_ADDR_LEN );
        $systemData['WebServerPort']['Type'] = DATA_ENTRY_TEXT;

        $systemData['StaticDHCP']['Value'] = DATA_ENTRY_YES;
        $systemData['StaticDHCP']['Type'] = DATA_ENTRY_YESNO_RADIO;
        $systemData['StaticDHCP']['Options'] = array( DATA_ENTRY_YES => "1", DATA_ENTRY_NO => "0" );

        $entries = 0;
        foreach ( $systemData as $paramName => $paramValue )
        {
            $template->setCurrentBlock( "FORM_ENTRY" );
            $template->setVariable( "PARAM_DISPLAY_NAME", $labelArray[ $paramName ]  );
            $template->setVariable( "PARAM_NAME", $paramName  );
            $template->setVariable( "ENTRY_NO", ++$entries );

            switch( $paramValue["Type"] )
            {
                case DATA_ENTRY_DISPLAY_ONLY:
                    $template->setVariable( "PARAM_DISPLAY_VALUE",  $paramValue["Value"] );
                    break;
                case DATA_ENTRY_DISABLED_TEXT:
                    $template->setVariable( "TEXT_DISABLED", "disabled"  );
                case DATA_ENTRY_TEXT:
                    $template->setVariable( "PARAM_DISPLAY_VALUE", $paramValue["Value"] );
                    $template->setCurrentBlock( "FORM_TEXT" );
                    $template->setVariable( "TEXT_PARAM_NAME", $paramName  );
                    $template->setVariable( "TEXT_DISPLAY_VALUE", $paramValue["Value"]  );
                    $template->parseCurrentBlock();
                    break;
                case DATA_ENTRY_YESNO_RADIO_DISABLED:
                case DATA_ENTRY_YESNO_RADIO:
                case DATA_ENTRY_RADIO:
                    $template->setVariable( "PARAM_DISPLAY_VALUE", $labelArray[ $paramValue["Value"]] );
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
                            if ($paramValue["Value"]== $Name )
                            {
                                $template->setVariable( "RADIO_CHECKED", "CHECKED" );
                            }
                            else
                            {
                                if ( $paramValue["Type"] == DATA_ENTRY_YESNO_RADIO_DISABLED )
                                {
                                   $template->setVariable( "RADIO_DISABLED", "disabled" );
                                }
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

                case DATA_ENTRY_SELECT:
                    $template->setVariable( "PARAM_DISPLAY_VALUE", $labelArray[ $paramValue["Value"]] );
                    $template->setCurrentBlock( "FORM_SELECT" );
                    $template->setVariable( "SELECT_PARAM_NAME", $paramName );
                    $template->setVariable( "SELECT_HERE", $labelArray["SelectHere"] );

                    if ( isset( $paramValue[ "Options" ] ) )
                    {
                        foreach( $paramValue[ "Options" ] as $Name => $Value )
                        {
                            $template->setCurrentBlock( "FORM_OPTION_SELECT" );
                            $template->setVariable( "OPTION_ID", $Name );
                            $template->setVariable( "OPTION_DISPLAY_VALUE", $labelArray[$Name] );
                            $template->parseCurrentBlock();
                        }
                    }
                    break;
                default:
                    break;
            }
            $template->setCurrentBlock( "FORM_ENTRY" );
            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "NET_FORM" );

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
