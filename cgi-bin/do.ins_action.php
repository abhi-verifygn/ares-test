#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.ins_action.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the installer options (actions) form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";


    /******************************************************************************
    ** Function:    ins_factory_reset
    ** Parameters:      errors [in/out] error information as concatenated strings
    ** Returns:         true if reset occurred, false otherwise
    **
    ** Initates a factory reset on the remote system.
    **
    */
    function ins_factory_reset( &$errors )
    {
        $success = false;

        // Request that the system goes to factory settings
        $result = is_executable ( INS_FACTORY_SCRIPT );
        if ( $result == true )  
        {
            exec( INS_FACTORY_SCRIPT . " > /dev/null 2>/dev/null &" );
            $errors[] = "Factory reset initiated";
            $success = true;
        }
        else
        {
            $errors[] = "Unable to load factory settings (and clear headsets) - retry later.";
        }
        
        return $success;
    }

    /******************************************************************************
    ** Function:    ins_load_settings
    ** Parameters:      errors [in/out] error information as concatenated strings
    ** Returns:         true if reset occurred, false otherwise
    **
    ** Initates an installer settings load on the remote system.
    **
    */
    function ins_load_settings( &$errors )
    {
        $success = false;
        
        // Determine whether the system is currently using the user database, 
        // e.g either loading or saving it
        $result = system( INS_DB_LOAD_SCRIPT . " > /dev/null 2>&1", $restoreSuccess );
        
        if (  (!is_bool( $result ) ) && ( $restoreSuccess == 0 ) )
        {
            $errors[] = "System loaded installer settings. Reboot initiated";
        }
        else
        {
            $errors[] = "Database back-up or restore in progress, or load request failed. Unable to load settings - retry later.";
        }
        return $success;
    }

    /******************************************************************************
    ** Function:    ins_save_settings
    ** Parameters:      errors [in/out] error information as concatenated strings
    ** Returns:         true if reset occurred, false otherwise
    **
    ** Initates an installer settings save on the remote system.
    **
    */
    function ins_save_settings( &$errors )
    {
        $success = false;
        
        // Initate save
        $result = system( INS_DB_SAVE_SCRIPT . " > /dev/null 2>&1", $backupSuccess );
        
        if (  (!is_bool( $result ) ) && ( $backupSuccess == 0 ) )
        {
            $errors[] = "Current installer settings saved";
        }
        else
        {
            $errors[] = "Database back-up or restore in progress, or save request failed. Unable to save settings - retry later.";
        }
        return $success;
    }

    /******************************************************************************
    ** Function:    ins_action_update
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
    function ins_action_update( $connection, $writeTables, $readTables, $requestData, &$errors )
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
                array(), array(), "ins", "ins_action_update", $warnings ) )
        {
            $_SESSION[ SESS_ERROR ] = $warnings;
        }
        else
        {
            $success = false;
            $factoryReset = false;

            if ( !isset( $_POST[ "baseRestart" ] ) )
            {
                $warnings[] = "Unknown request. Ignored";
            }
            else
            {
                switch( $_POST["baseRestart"] )
                {
                    case "FACTORY RESET":
                        $success = ins_factory_reset( $warnings );
                        $factoryReset = $success;
                        break;
                    case "LOAD SETTINGS":
                        $success = ins_load_settings( $warnings );
                        break;
                    case "SAVE SETTINGS":
                        $success = ins_save_settings( $warnings );
                        break;
                    default:
                        $warnings = "Base restart received but command parameter not recognised. Ignored";
                        $success = false;
                        break;
                }
            }
            $_SESSION[ SESS_ERROR ] = is_array( $warnings ) ? implode( ", ", $warnings ) : $warnings;
        }
        if ( $factoryReset == true )
        {
            header(
                "location: logout.php",
                true, // replace any existing location header
                303   // HTTP "303 see other" response code
                );
            exit;
        }
        else
        {
            header(
                "Location: {$_SERVER["HTTP_REFERER"]}",
                true, // replace any existing location header
                303   // HTTP "303 see other" response code
                );
            exit;
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
