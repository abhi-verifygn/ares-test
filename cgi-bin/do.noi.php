#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.noi.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the external triggers form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    noi_update
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
    function noi_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        if (!isset( $requestData["params"] ) )
        {
            $errors[] = "No noise reduction parameters have been specified. Nothing to do.";
            return false;
        }
        else
        {
            $successfulUpdates = 0;
            
            foreach( $requestData["params"] as $paramName => $paramValueName )
            {
                // Make sure that the data is clean and sane.
                $cleanParamName = VenusMySqlVarClean( $paramName, 20, $connection );
                $cleanParamValue = VenusMySqlVarClean( $paramValueName, 20, $connection );

                // Form appends _L2 onto all paramters that are related to lane 2. This
                // needs to be stripped off when updating the noise reduction settings for
                // lane 2
                $lane2SuffixStart = strpos( $cleanParamName, "_L2" );
                $cleanTableParamName = ($lane2SuffixStart > 0) ?
                substr( $cleanParamName, 0, $lane2SuffixStart ) : $cleanParamName;

                // Switch to the appropiate database table pair for the lane
                if ( $lane2SuffixStart > 0 )
                {
                    // Lane 2
                    $writePtr = $writeTables["DL2NoiseReduction"];
                    $paramPtr = $readTables["DL2NoiseReductionParams"];
                }
                else
                {
                    // Lane 1
                    $writePtr = $writeTables["NoiseReduction"];
                    $paramPtr = $readTables["NoiseReductionParams"];
                }
                
                // Check the contents of the parameter is valid
                if (VenusValidateParam( $connection, $cleanTableParamName, $cleanParamValue,
                                        $writePtr, $paramPtr, $errors ))
                {
                    // Skip any selector where there has been no change - indicated by empty string
                    if ( ( $cleanTableParamName == "IMNRL" ) 
                        || ( $cleanTableParamName == "AEC" ) )
                    {
                        if ( empty( $cleanParamValue ) )
                        {
                            continue;
                        }
                    }
                    // Update the database
                    if ( !mysqli_query( $connection,
                            "UPDATE {$writePtr}
                            SET ParamValueID='{$cleanParamValue}'
                            WHERE ParamNameID='{$cleanTableParamName}';" ) )
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
        $writeTables = array("NoiseReduction"=>"NoiseReduction",
                             "DL2NoiseReduction"=>"DL2NoiseReduction");
        $readTables = array(
                        "LangNoiseReduction"=>"LangNoiseReduction",
                        "NoiseReductionParams"=>"NoiseReductionParams",
                        "DL2NoiseReductionParams"=>"DL2NoiseReductionParams" );

        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "noi", "noi_update", $warnings ) )
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
