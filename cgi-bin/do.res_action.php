#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.res_action.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the reboot (actions) form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";


    /******************************************************************************
    ** Function:    res_reboot
    ** Parameters:      errors [in/out] error information as concatenated strings
    ** Returns:         true if reset occurred, false otherwise
    **
    ** Initates a factory reset on the remote system.
    **
    */
    function res_reboot( &$errors )
    {
        $success = false;
        
        // Request that the system reboot
        $result = is_executable ( RES_REBOOT_SCRIPT );
        if ( $result == true )  
        {
            exec( RES_REBOOT_SCRIPT . " > /dev/null 2>/dev/null &" );
            $errors[] = "Reboot initiated";
            $success = true;
        }
        else
        {
            $errors[] = "Request to reboot failed - retry later.";
        }
        return $success;
    }


    /******************************************************************************
    ** Function:    res_action_update
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
    function res_action_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = true;

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
        $writeTables = array( );
        $readTables = array( );

        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                array(), array(), "res", "res_action_update", $warnings ) )
        {
            $_SESSION[ SESS_ERROR ] = $warnings;
        }
        else
        {
            $success = false;

            if ( !isset( $_POST[ "baseReboot" ] ) )
            {
                $warnings[] = "Reboot request ignored. To confirm reboot choose reboot option and resubmit";
            }
            else
            {
                switch( $_POST["baseReboot"] )
                {
                    case "REBOOT":
                        $success = res_reboot( $warnings );
                        break;
                    default:
                        $warnings = "Reboot command received but command parameter not recognised. Ignored";
                        $success = false;
                        break;
                }
            }
            $_SESSION[ SESS_ERROR ] = is_array( $warnings ) ? implode( ", ", $warnings ) : $warnings;
            
            if ( $success == true )
            {
                header(
                    "location: logout.php",
                    true, // replace any existing location header
                    303   // HTTP "303 see other" response code
                    );
                exit;
            }
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
