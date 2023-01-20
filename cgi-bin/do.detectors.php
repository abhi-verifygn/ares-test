#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.detectors.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the detector settings form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    det_update
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
    function det_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = false;

        if (!isset( $requestData["params"] ) )
        {
            $errors[] = "No global parameters have been specified. Nothing to do.";
            return false;
        }
        else
        {
            $successfulUpdates = 0;
            foreach( $requestData["params"] as $paramName => $paramValueName )
            {
                // Make sure that the data is clean and sane.
                $cleanParamName = VenusMySqlVarClean( $paramName, 40, $connection );
                $cleanParamValue = VenusMySqlVarClean( $paramValueName, 20, $connection );

                // Check the contents of the parameter is valid
                if (VenusValidateParam( $connection, $cleanParamName, $cleanParamValue,
                                        $writeTables["Detectors"], $readTables["DetectorsParams"], $errors ))
                {
                    // Skip any selector where there has been no change - indicated by empty string
                    if ( $cleanParamName == "SelectedMode"  )
                    {
                        if ( empty( $cleanParamValue ) )
                        {
                            continue;
                        }
                    }
                    // Update the database
                    if ( !mysqli_query( $connection,
                            "UPDATE {$writeTables["Detectors"]}
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
        $writeTables = array( "Detectors"=>"Detectors" );
        $readTables = array( "LangDetectors"=>"LangDetectors",
                             "DetectorsParams"=>"DetectorsParams");


        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "detectors", "det_update", $warnings ) )
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
