#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.grd.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the greeter day parts definition form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    grd_checkTimes
    ** Parameters:      numDayParts [in] number of dayparts to check
    **                  requestData [in] posted data from browser
    **                  errors [in/out] error information as an array of strings
    ** Returns:         true if update occurred, false otherwise
    **
    ** Local helper function to confirm whether the start and end times are
    ** in the correct ascending sequence.
    **
    */
    function grd_checkTimes( $dayPartIDs, $requestData, &$errors )
    {
        $success = true;

        $timeNames = array(
            "StartTime",
            "EndTime" );

        foreach( $dayPartIDs as $ID )
        {
            if ( !isset( $requestData[ $ID ] ) )
            {
                $success = false;
                $errors[] = "Unable to find form data for day part row {$ID}.";
                continue;
            }

            $validatedTimes = array();

            // Make sure that we have valid times entered into the
            // form and obtain the timestamps of each entry.
            foreach ( $timeNames as $timeName )
            {
                if ( !VenusValidateTime( $requestData[$ID][$timeName], $validatedTimes[$timeName ], $errors, true ) )
                {
                    $errors[] = "Invalid time for day part row {$ID} and {$timeName}";
                    $success = false;
                }
            }
            
            if ( $success )
            {
                // Check special case where start and end times are 00:00
                $zeroCount = 0;
                foreach ( $timeNames as $timeName )
                {
                    $hours = 0; $mins = 0;
                    $converted = sscanf( $requestData[$ID][$timeName], "%02d:%02d", $hours, $mins );
                    if ( ($converted == 2 ) && ( $hours == 0 ) && ( $mins == 0 ) )
                    {
                        ++$zeroCount;
                    }
                }
                
                if ( count( $timeNames ) != $zeroCount )
                {
                    // one or both times are confirmed as 00:00, so
                    // Check the differences
                    // between the times to ensure that the sequence is OK
                    foreach ( $timeNames as $timeName )
                    {
                        $diffSecs = $validatedTimes[ "EndTime" ]
                            - $validatedTimes[ "StartTime" ];
                        if ( $diffSecs <= 59  )
                        {
                            $errors[] = "Start time must preceed end time for day part row {$ID}. ";
                            $success = false;
                            break;
                        }
                    }
                }
            }
        }
        return $success;
    }


    /******************************************************************************
    ** Function:    grd_update
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
    function grd_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = false;

        if (!isset( $requestData["dayPart"] ) )
        {
            $errors[] = "No day parts have been specified. Nothing to do.";
            return false;
        }
        else
        {
            // Determine number of day parts to process
            if ( !$result = @mysqli_query( $connection,
                    "SELECT ID
                    from {$writeTables["GRD"]}
                    order by ID;" ) )
            {
                $errors[] = "Unable to update due to an internal database issue - day part ID query.";
                VenusShowError($connection);
            }
            else
            {
                $dayPartIDs = array();
                while ( ($row = @mysqli_fetch_array( $result, MYSQLI_ASSOC ) ) != null )
                {
                    if ( !isset( $row[ "ID" ] ) )
                    {
                        continue;
                    }
                    $dayPartIDs[] = $row[ "ID" ];
                }

                if ( count( $dayPartIDs ) != count( $requestData["dayPart"] ) )
                {
                    $errors[] = "Mismatch between number of day parts submitted and number allowed in database.";
                }
                else
                {
                    if ( grd_checkTimes( $dayPartIDs, $requestData["dayPart"], $errors ) )
                    {
                         $success = true;
                        foreach( $dayPartIDs as $ID )
                        {
                            if ( !mysqli_query( $connection,
                                    "UPDATE {$writeTables["GRD"]}
                                    SET Name='{$requestData["dayPart"][$ID]["Name"]}',
                                        StartTime='{$requestData["dayPart"][$ID]["StartTime"]}',
                                        EndTime='{$requestData["dayPart"][$ID]["EndTime"]}'
                                    WHERE ID='{$ID}';" ) )
                            {
                                VenusShowError($connection);
                                $success = false;
                            }
                        }
                    }
                }
                mysqli_free_result( $result );
            }
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
        $writeTables = array( "GRD"=>"GRD" );
        $readTables = array( "LangGRD"=>"LangGRD");

        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "grd", "grd_update", $warnings ) )
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
