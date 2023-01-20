#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.msc.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the global settings form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";
    
    /******************************************************************************/
    /*    Macro Definitions                                                       */
    /******************************************************************************/
    define( "NETWORK_CHECK_SCRIPT","/usr/bin/venus_validate_ip_change.sh" );
    define( "NETWORK_SETUP_SCRIPT","/usr/bin/venus_change_ip.sh" );
    define( "WEB_SETTINGS_SETUP_SCRIPT", "/usr/bin/venus_reconfigure_web_server.sh" );
    
    define( "WEB_PORT_VAL_MIN", 80               );
    define( "WEB_PORT_VAL_MAX", 65535            );
    
    
    /******************************************************************************
    ** Function:    msc_update
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
    function msc_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = false;

        if (!isset( $requestData["params"] ) )
        {
            $errors[] = "No network parameters have been specified. Nothing to do.";
        }
        else
        {
            $params = $requestData["params"]; 
            
            foreach( $params as $paramName => $paramValueName )
            {
                // Make sure that the data is clean and sane.
                $cleanParamName = VenusMySqlVarClean( $paramName, 40, $connection );
                $cleanParamValue = VenusMySqlVarClean( $paramValueName, 20, $connection );
            }
            
            if ( ( isset( $params['IPAddress'] ) ) 
              && ( isset( $params['SubnetMask'] ) ) 
              && ( isset( $params['DefaultGateway'] ) ) 
              && ( isset( $params['WebServerEnabled'] ) )
              && ( isset( $params['WebServerPort'] ) ) )
            {
                /*
                 *  Check network parameters
                 */
                $commandLineParams = " {$params['IPAddress']} {$params['SubnetMask']} {$params['DefaultGateway']}";
                $commandLineParams = escapeshellcmd( $commandLineParams );

                @exec( NETWORK_CHECK_SCRIPT . "${commandLineParams}", $output, $returnVal );
               
                if ( $returnVal != 0 )
                {
                    $errors[] = "One or more invalid IP v4 addresses entered. Values submitted:";
                    $errors[] = " IP: {$params['IPAddress']} ";
                    $errors[] = " Subnet: {$params['SubnetMask']} ";
                    $errors[] = " G/W: {$params['DefaultGateway']} ";
                }
                else
                {
                    /*
                     * Check web-server parameters
                     */
                    $WSport = intval( $params['WebServerPort'] );
                    
                    if ( ( $WSport < WEB_PORT_VAL_MIN ) || ( $WSport > WEB_PORT_VAL_MAX ) )
                    {
                        $errors[] = " Invalid web-port: {$params['WebServerPort']} ";
                    }
                    else
                    {
                        if ( strcmp( $params['WebServerEnabled'], "RADIO_YES" ) == 0 
                          || strcmp( $params['WebServerEnabled'], "RADIO_NO"  ) == 0 )
                        {
                            $success = true;
                        }
                        else
                        {
                            $errors[] = " Invalid web-server enabled value: {$params['WebServerEnabled']} ";
                        }
                    }
                }
            }
            else
            {
                $errors[] = "Incomplete or missing parameters.";
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
        $writeTables = array();
        $readTables = array( "LangNetworkSettings"=>"LangNetworkSettings");


        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "msc", "msc_update", $warnings ) )
        {
            $_SESSION[ SESS_ERROR ] = $warnings;
            header(
                "Location: {$_SERVER["HTTP_REFERER"]}",
                true, // replace any existing location header
                303   // HTTP "303 see other" response code
                );
        }
        else
        {
            $params = $_POST["params"];

            $WSEnabled = ( strcmp( $params['WebServerEnabled'], "RADIO_YES" ) == 0 ) ? 1 : 0;
            $WSPort = intval( $params['WebServerPort'] );

             // IP address or other addressing change - assume log out is best next step
            $_SESSION[SESS_MESSAGE] = "Rebooting to change " .
                                      "IP: {$params['IPAddress']} " .
                                      "subnet: {$params['SubnetMask']} " . 
                                      "gateway: {$params['DefaultGateway']} " .
                                      "web enable: {$WSEnabled} " . 
                                      "web-port: {$WSPort}";
            header(
                "location: logout.php",
                true, // replace any existing location header
                303   // HTTP "303 see other" response code
                );
        
           /*
            * Request platform to update web-server settings then
            * to execute network address change (forces reboot) all
            * in background so page can update
            */
           $WScommandLineParams = " {$WSEnabled} {$WSPort} fromweb";
           $WScommandLineParams = escapeshellcmd( $WScommandLineParams );
           
           $NScommandLineParams = " {$params['IPAddress']} {$params['SubnetMask']} {$params['DefaultGateway']} reboot";
           $NScommandLineParams = escapeshellcmd( $NScommandLineParams );
           
           /*
            * Build up command sequence of form "( cmd1; cmd2; cmd3 )"
           */
           $commandLine  = "( sleep 3; " . WEB_SETTINGS_SETUP_SCRIPT . " ${WScommandLineParams}; ";
           $commandLine .= NETWORK_SETUP_SCRIPT . " ${NScommandLineParams} )";

           /*
            * Run command sequence in background so logout page can be displayed. Note web-server
            * must remain running so logout page can be displayed - hence "fromweb" hint appended
            * earlier to WScommandLineParams. 
            */
           @exec( "${commandLine} > /dev/null 2>&1 &" );
        }
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
