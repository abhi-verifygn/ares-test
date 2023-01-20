#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.ins_setting.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the intstall options (settings) form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    ins_setting_update
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
    function ins_setting_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        if (!isset( $requestData["params"] ) )
        {
            $errors[] = "No installer setting parameters have been specified. Nothing to do.";
            return false;
        }
        else
        {
            $successfulUpdates = 0;
            foreach( $requestData["params"] as $paramName => $paramValueName )
            {
                // Make sure that the data is clean and sane.
                $cleanParamName = VenusMySqlVarClean( $paramName, 40, $connection );
                $cleanParamValue = VenusMySqlVarClean( $paramValueName, 50, $connection );

                // Check the contents of the parameter is valid
                if (VenusValidateParam( $connection, $cleanParamName, $cleanParamValue,
                                        $writeTables["InstallerOptions"], $readTables["InstallerOptionsParams"], $errors ))
                {
                    // Update the database
                    if ( !mysqli_query( $connection,
                            "UPDATE {$writeTables["InstallerOptions"]}
                            SET ParamValueID='{$cleanParamValue}'
                            WHERE ParamNameID='{$cleanParamName}';" ) )
                    {
                        VenusShowError( $connection );
                    }
                    else
                    {
                        ++$successfulUpdates;
                    }
                }
           }

           return $successfulUpdates == count($requestData["params"]);
        }
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
        $writeTables = array( "InstallerOptions"=>"InstallerOptions" );
        $readTables = array( "InstallerOptionsParams"=>"InstallerOptionsParams",
                             "LangInstallerOptions"=>"LangInstallerOptions");


        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "ins", "ins_setting_update", $warnings ) )
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
