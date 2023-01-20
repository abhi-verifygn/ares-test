#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.ord.php - Venus web-site login support
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

    $OTEntries = array( "MLPTT", "MLMLT", "ALTPTT", "ALMLT", "HandsFree", "Outside", "AlwaysOn" );

    /******************************************************************************
    ** Function:    ValidateOTModes
    ** Parameters:      requestData [in] data orginating from form
    ** Returns:         true if at least one OT mode is available, false otherwise
    **
    ** When changing OT modes available to the system, at least one mode must be 
    ** available for selection.
    **
    */
    function ValidateOTModes( $requestData )
    {
        global $OTEntries;
        $success = false;
        
        foreach  ( $OTEntries as $OTEntry )
        {
            if ( $requestData["params"][$OTEntry] == "RADIO_YES" )
            {
                $success = true;
                break;
            }
        } 
        
        return $success;
    }
    
    /******************************************************************************
    ** Function:    ValidateOTSelection
    ** Parameters:      requestData [in] data orginating from form
    ** Returns:         true if at selected OT mode is available, false otherwise
    **
    ** This function ensures that the selection made matches one of those available
    ** for selection.
    **
    */
    function ValidateOTSelection( $connection, $writeTables, $requestData )
    {
        global $OTEntries;
        $success = false;
        
        $selectedMode = VenusMySqlVarClean( $requestData["params"]["SelectedMode"], 20, $connection );
        if ( empty( $selectedMode ) )
        {
            // Need to query to find out what the current OT mode is so 
            // that we can check whether user has disabled the current
            // mode
            if ( !( $queryResult = @mysqli_query( $connection,
                        "select ParamValueID 
                        from {$writeTables["OrderTaking"]} 
                        where ParamNameID = 'SelectedMode';" ) ) )
            {
                $success = false;
            }
            else
            {
                if ( mysqli_num_rows( $queryResult ) == 1 )
                {
                    // Determine what selectedMode is set to
                    $rowResult = mysqli_fetch_array( $queryResult );
                    if ( $rowResult != NULL && isset( $rowResult[ "ParamValueID" ] ) )
                    {
                        // Check whether there is a form parameter with that mode
                        if ( isset( $requestData["params"][$rowResult[ "ParamValueID" ]] ) )
                        {
                            // Check whether the proposed mode allows means the selected mode isn't valid 
                            $modeSetting = VenusMySqlVarClean( $requestData["params"][$rowResult[ "ParamValueID" ]], 20, $connection );
                            
                            $success = ( $modeSetting == "RADIO_YES" ) ? true : false;
                        }
                    }
                }
                mysqli_free_result( $queryResult );
            }
        }
        else
        {
            foreach  ( $OTEntries as $OTEntry )
            {
                $modeSetting = VenusMySqlVarClean( $requestData["params"][$OTEntry], 20, $connection );
                if ( ( $selectedMode == $OTEntry ) && ( $modeSetting == "RADIO_YES" ) )
                {
                    $success = true;
                    break;
                }
            }
        }
        
        return $success;
    }


    /******************************************************************************
    ** Function:    ord_update
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
    function ord_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = false;

        if (!isset( $requestData["params"] ) )
        {
            $errors[] = "No global parameters have been specified. Nothing to do.";
            return false;
        }
        else
        {
            // Check that at least one of the order taking modes have been enabled
            if ( !ValidateOTModes( $requestData ) )
            {
                $errors[] = "At least one order taking modes must be available for selection. Try again.";
                return false;
            }

            // Check that selected order taking mode is one that has been enabled
            if ( !ValidateOTSelection( $connection, $writeTables, $requestData ) )
            {
                $errors[] = "Update failed. Attempt to disable the selected order taking mode. Select a different, enabled mode first.";
                return false;
            }

            $successfulUpdates = 0;
            foreach( $requestData["params"] as $paramName => $paramValueName )
            {
                // Make sure that the data is clean and sane.
                $cleanParamName = VenusMySqlVarClean( $paramName, 40, $connection );
                $cleanParamValue = VenusMySqlVarClean( $paramValueName, 20, $connection );

                // Check the contents of the parameter is valid
                if (VenusValidateParam( $connection, $cleanParamName, $cleanParamValue,
                                        $writeTables["OrderTaking"], $readTables["OrderTakingParams"], $errors ))
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
                            "UPDATE {$writeTables["OrderTaking"]}
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
        $writeTables = array( "OrderTaking"=>"OrderTaking" );
        $readTables = array( "LangOrderTaking"=>"LangOrderTaking",
                             "OrderTakingParams"=>"OrderTakingParams");


        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "ord", "ord_update", $warnings ) )
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
