#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.ltm.php - Venus web-site login support
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

    /******************************************************************************
    ** Function:    update_date_time
    ** Parameters:      errors [in/out] error information as concatenated strings
    ** Returns:         true if reset occurred, false otherwise
    **
    ** Changes the date/time on the remote system.
    **
    */
    function update_date_time( $newDate, $newTime, &$errors )
    {
        $success = false;
        
        // Call script to update date and time
        $result = system( LTM_DATE_TIME_SCRIPT . " ${newDate} ${newTime} > /dev/null 2>&1", $updateSuccess );
        if (  (!is_bool( $result ) ) && ( $updateSuccess == 0 ) )
        {
            $errors[] = "Date/Time update successful";
            $success = true;
        }
        else
        {
            $errors[] = "Unable to change date/time - remote update request failed.";
        }
        
        return $success;
    }

    /******************************************************************************
    ** Function:    ltm_update
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
    function ltm_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        if (!isset( $requestData["params"] ) )
        {
            $errors[] = "No global parameters have been specified. Nothing to do.";
            return false;
        }

        $specialParamsUpdateOK = true;
        if ( isset( $requestData["specialParams"] ) )
        {
            // Process date/time change
            if (
                   isset( $_POST["sysDate"] ) 
                && isset( $_POST["sysTime"] ) 
                && isset( $requestData["specialParams"]["date"] )
                && isset( $requestData["specialParams"]["time"] ) )
            {
                $cleanOldDateValue = VenusMySqlVarClean( $_POST["sysDate"], 10, $connection );
                $cleanOldTimeValue = VenusMySqlVarClean( $_POST["sysTime"], 10, $connection );

                $cleanDateValue = VenusMySqlVarClean( $requestData["specialParams"]["date"], 10, $connection );
                $cleanTimeValue = VenusMySqlVarClean( $requestData["specialParams"]["time"], 8, $connection );
                
                // No need to process date or time if no change has been made
                if (    ( strcmp( $cleanOldDateValue, $cleanDateValue ) != 0 )
                     || ( strcmp( $cleanOldTimeValue, $cleanTimeValue ) != 0 ) )
                {
                    // Date and/or time change made
                    if ( !VenusValidateFullDate( $cleanDateValue, $errors ) )
                    {
                        $specialParamsUpdateOK = false;
                        $errors[] = "Invalid date entered. Please re-enter changes";
                    }
                    else
                    {
                        if ( !VenusValidateFullTime( $cleanTimeValue, $errors ) )
                        {
                            $specialParamsUpdateOK = false;
                            $errors[] = "Invalid time entered. Please re-enter changes";
                        }
                        else
                        {
                            // Call script with to set date and time, remember to use cleaned variables
                            $specialParamsUpdateOK = update_date_time( $cleanDateValue, $cleanTimeValue, $errors );
                        }
                    }
                }
            }
            
            // Process time zone change
            if ( isset( $requestData["specialParams"]["timezone"] ) 
                 && ( strcmp( $requestData["specialParams"]["timezone"], IGNORE_SELECTION ) != 0 ) )
            {
                $cleanTZValue = VenusMySqlVarClean( $requestData["specialParams"]["timezone"], 20, $connection );

                $intTZValue = intval( $cleanTZValue );

                if ( ( $intTZValue < 0) || ( $intTZValue >= NO_OF_TIME_ZONES ) )
                {
                   $intTZValue = 0;   
                }
                // Update the database
                if ( !mysqli_query( $connection,
                        "UPDATE ".UPDATE_MGT_TABLE."
                        SET Value='{$intTZValue}'
                        WHERE Name='".UPDATEMGT_TZ."';" ) )
                {
                    VenusShowError( $connection );
                    $specialParamsUpdateOK = false;
                }
            }
        }

        // Process remaining changes.
        $successfulUpdates = 0;
        foreach( $requestData["params"] as $paramName => $paramValueName )
        {
            // Make sure that the data is clean and sane.
            $cleanParamName = VenusMySqlVarClean( $paramName, 40, $connection );
            $cleanParamValue = VenusMySqlVarClean( $paramValueName, 20, $connection );

            // Check the contents of the parameter is valid
            if (VenusValidateParam( $connection, $cleanParamName, $cleanParamValue,
                                    $writeTables["LTM"], $readTables["LTMParams"], $errors ))
            {
                // Update the database
                if ( !mysqli_query( $connection,
                        "UPDATE {$writeTables["LTM"]}
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
       return ($successfulUpdates == count($requestData["params"]))
            && $specialParamsUpdateOK;
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
        $writeTables = array( "LTM"=>"LTM" );
        $readTables = array( "LangLTM"=>"LangLTM",
                             "LTMParams"=>"LTMParams" );

        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "ltm", "ltm_update", $warnings ) )
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
