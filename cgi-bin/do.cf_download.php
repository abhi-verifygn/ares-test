#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.cf_download.php - Venus web-site installer settings support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the installer settings download form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2014
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    cf_download_update
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
    function cf_download_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = true;
        
        /* There is nothing in $_POST related to the upgrade so simply return true. */

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
                array(), array(), "cf", "cf_download_update", $warnings ) )
        {
            $_SESSION[ SESS_ERROR ] = $warnings;
        }
        else
        {
            if ( is_readable( CONFIG_LOCAL_PATH_FILENAME ) )
            {
               // Determine whether the system is currently using the user database, 
               // e.g either loading or saving it
               $result = system( ACCESS_DB_ALLOWED_SCRIPT . " /dev/null 2>/dev/null", $accessDBAllowed );
                
               if (  (!is_bool( $result ) ) && ( $accessDBAllowed == 0 ) )
               {
                    // Initiate compression
                    $gzFile = CONFIG_LOCAL_ROOT."/".CONFIG_REMOTE_FILENAME;
                    $tarCmdLine = "tar -cz -C ".CONFIG_LOCAL_ROOT." -f ${gzFile} ".UPLOAD_DB_FILENAME;
                    $sysRetValue = @system( $tarCmdLine, $tarCmdReturnValue );
                    
                    if ( !is_bool( $sysRetValue ) && ($tarCmdReturnValue == 0 ) )
                    {
                        // Initate download
                        header("Content-type:application/gzip");
                        header('Content-Disposition: attachment; filename="'.CONFIG_REMOTE_FILENAME.'"');
                        readfile( $gzFile );
                        exit;
                    }
                    else
                    {
                        $_SESSION[ SESS_ERROR ] = "Unable to compress settings database. Unable to upload.";
                    }
                }
                else
                {
                    $_SESSION[ SESS_ERROR ] = "Database back-up or restore in progress. Unable to upload - retry later.";
                }
            }
            else
            {
                $_SESSION[ SESS_ERROR ] = "No installer setting database available - use MMI to save settings and try again";
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
