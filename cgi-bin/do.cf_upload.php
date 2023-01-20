#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.cf_upload.php - Venus web-site upgrade support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted upload DB request data from the tarball upgrade form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2014
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    cf_upload_update
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
    function cf_upload_update( $connection, $writeTables, $readTables, $requestData, &$errors )
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
                array(), array(), "cf", "cf_upload_update", $warnings ) )
        {
            $_SESSION[ SESS_ERROR ] = $warnings;
        }
        else
        {
           // Determine whether the system is currently using the user database, 
           // either loading or saving
           $result = system( ACCESS_DB_ALLOWED_SCRIPT . " skip_user_db_check > /dev/null 2>&1", $accessDBAllowed );
            
           if (  (!is_bool( $result ) ) && ( $accessDBAllowed == 0 ) )
           {
                // Ready to process the uploaded file
                if ( $_FILES[UPLOAD_DB_KEY]["error"] == UPLOAD_ERR_OK )
                {
                    $tmp_name = $_FILES[UPLOAD_DB_KEY]["tmp_name"];
                    $name = UPLOAD_DB_FILENAME;
                    
                    $userDB_path_file_name = CONFIG_LOCAL_ROOT . "/" . UPLOAD_DB_FILENAME;
                    $uploaded_gz_path_file_name = CONFIG_LOCAL_ROOT . "/" . CONFIG_REMOTE_FILENAME;
                    $temp_backup_path_file_name = CONFIG_LOCAL_ROOT . "/" . UPLOAD_DB_TMP_BACKUP;

                    // Remove any old download file
                    if ( @is_file( $uploaded_gz_path_file_name ) )
                    {
                        unlink( $uploaded_gz_path_file_name );
                    }

                    // Copy over compressed SQL database ready for decompression
                    if ( move_uploaded_file(
                        $tmp_name, 
                        $uploaded_gz_path_file_name ) == FALSE )
                    {
                        $_SESSION[ SESS_ERROR ] = "Unable to copy over new user database.";
                    }
                    else
                    {
                        // Make a back-up of the user settings (if it exists), to fall back on
                        $fileRenamed = FALSE;
                        if ( @is_file( $userDB_path_file_name ) )
                        {
                            $fileRenamed = @rename( $userDB_path_file_name, $temp_backup_path_file_name );
                        }
                        
                        // Decompress database, this will overwrite the current database if it exists
                        $tarCmdLine = "tar -x -C ".CONFIG_LOCAL_ROOT." -f ${uploaded_gz_path_file_name} ".UPLOAD_DB_FILENAME;
                        $sysRetValue = @system( $tarCmdLine, $tarCmdReturnValue );
                        
                        if ( is_bool( $sysRetValue ) || ($tarCmdReturnValue != 0 ) )
                        {
                            $_SESSION[ SESS_ERROR ] = "Unable to de-compress settings database. Unable to upload.";
                        }
                        else
                        {
                            // User database should have been overwritten. All done.
                            $_SESSION[ SESS_ERROR ] = "Installer settings uploaded - use \"Installer Options\" web-page to load";
                        }

                        /* AT this stage we should have a database, if we don't rename the fallback */
                        if ( (! @is_file( $userDB_path_file_name )) && ( $fileRenamed == TRUE ) )
                        {
                            @rename( $temp_backup_path_file_name, $userDB_path_file_name );
                            $_SESSION[ SESS_ERROR ] = "Reverting to original version of user database";
                        }
                    }
                }
                else
                {
                    $errorCodes = array( 
                            UPLOAD_ERR_INI_SIZE =>   "too large (code 1)", 
                            UPLOAD_ERR_FORM_SIZE =>  "too large (code 2)", 
                            UPLOAD_ERR_PARTIAL =>    "partial upload", 
                            UPLOAD_ERR_NO_FILE =>    "no file uploaded", 
                            UPLOAD_ERR_NO_TMP_DIR => "unable to write (code 1)",
                            UPLOAD_ERR_CANT_WRITE => "Unable to write (code 2)",
                            UPLOAD_ERR_EXTENSION =>  "Unable to write (code 3)"
                    ); 
                    $_SESSION[ SESS_ERROR ] = "Unsuccessful upload. " 
                        . $errorCodes[ $_FILES[UPGRADE_TB_KEY][ "error" ] ];
                }
            }
            else
            {
                $_SESSION[ SESS_ERROR ] = "Database back-up or restore in progress. Unable to upload - retry later.";
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
