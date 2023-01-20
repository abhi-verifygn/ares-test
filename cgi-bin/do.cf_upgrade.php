#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.cf_upgrade.php - Venus web-site upgrade support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the tarball upgrade form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    cf_upgrade_update
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
    function cf_upgrade_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = true;
        
        /* There is nothing in $_POST related to the upgrade so simply return true. */

        return $success;
    }
    
    /******************************************************************************
    ** Function:    cf_processUpdate
    ** Parameters:      uploadPath [in] path to the archive
    **                  uploadPath [in] filename of archive
    **                  warnings [in/out] warnings as concatenated strings
    ** Returns:         true if script ran OK, false otherwise
    **
    ** 
    **
    */
    function cf_processUpdate( $uploadPath, $uploadName, &$warnings )
    {
        $success = false;
        
        if ( is_file( UPGRADE_SCRIPT ) )
        {
            // Run the upgrade helper script, then pause a little to allow
            // the installation to get underway before returning
            system( UPGRADE_SCRIPT . ' ' 
                . escapeshellarg( $uploadPath ) . ' ' 
                . escapeshellarg( $uploadName ) . ' > /dev/null 2>/dev/null &' );
            
            sleep( 1 );
            $warnings = "Upgrade script is executing. Wait a few minutes before accessing the web-site again";
            
            # Note the time the upgrade started and reset the page refresh count used by the progress page
            $_SESSION[ SESS_UPGRADE_START_TIME ] = date('M d H:i:s');
            if ( isset( $_COOKIE[ SESS_UPGRADE_REFRESH_COUNT ] ) )
            {
                setcookie( SESS_UPGRADE_REFRESH_COUNT, strval( 0 ) );
            }
            
            $success = true;
        }
        else
        {
            $warnings = "Upgrade failed. " 
                        . UPGRADE_SCRIPT . " file missing.";
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
        $writeTables = array( );
        $readTables = array( );

        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                array(), array(), "cf", "cf_upgrade_update", $warnings ) )
        {
            $_SESSION[ SESS_ERROR ] = $warnings;
        }
        else
        {
           // Determine whether the system is currently updating
           system( "ps | grep tar | grep -v grep > /dev/null 2>/dev/null", $returnValueExtracting );
           system( "ps | grep install | grep -v grep > /dev/null 2>/dev/null", $returnValueInstalling );
            
           if ( ( $returnValueExtracting == 1 ) && ( $returnValueInstalling == 1 ) )
           {
                // Ready to process the uploaded file
                if ( $_FILES[UPGRADE_TB_KEY]["error"] == UPLOAD_ERR_OK )
                {
                    $tmp_name = $_FILES[UPGRADE_TB_KEY]["tmp_name"];
                    $name = UPGRADE_TB_FILENAME;
                    
                    if ( @is_dir( UPGRADE_TB_UPLOAD_EXTRACT_FLASH_DIR_ROOT ) )
                    {
                        $upgradeDir = UPGRADE_TB_UPLOAD_EXTRACT_FLASH_DIR_ROOT . "/" . 
                            UPGRADE_TB_UPLOAD_EXTRACT_DIR_NAME;
                    }
                    else
                    {
                        $upgradeDir = UPGRADE_TB_UPLOAD_EXTRACT_DIR_ROOT . "/" . 
                            UPGRADE_TB_UPLOAD_EXTRACT_DIR_NAME;
                    }
                    
                    // Remove the upgrade directory and contents
                    if ( @is_dir( $upgradeDir ) )
                    {
                        system( '/bin/rm -rf ' . escapeshellarg( $upgradeDir ) . REDIRECT_OUTPUT_TO_NULL );
                    }
                    
                    // Create upgrade directory
                    if (  @mkdir( $upgradeDir ) )
                    {
                        $uploadFile =  $upgradeDir . "/" . UPGRADE_TB_FILENAME;
                        move_uploaded_file(
                            $tmp_name, 
                            $uploadFile );
                        
                        if ( cf_processUpdate( $upgradeDir, UPGRADE_TB_FILENAME, $warnings ) == true )
                        {
                            // Redirect to refreshing page
                            header(
                                "Location: do.cf_upgrade_poller.php",
                                true, // replace any existing location header
                                303   // HTTP "303 see other" response code
                                );
                            exit;
                        }
                        else
                        {
                            $_SESSION[ SESS_ERROR ] = $warnings;
                        }
                    }
                    else
                    {
                        $_SESSION[ SESS_ERROR ] = "Unsuccessful upload. Unable to write (code 4)";
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
                $_SESSION[ SESS_ERROR ] = "Update already in progress. Please wait.";
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
