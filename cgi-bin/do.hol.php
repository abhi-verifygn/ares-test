#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.hol.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the holidays form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";
    require_once "hol.helper.php";

    /******************************************************************************
    ** Function:    hol_update
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
    function hol_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = false;

        // Check that no holiday dates are duplicated
        $zeroDatesCount = 0;
        $dates = array();
        for ( $i = 0; $i < count( $requestData ); ++$i )
        {
            if ( isset( $requestData[ $i ] ) && isset( $requestData[ $i ]["DayValue" ] ) )
            {
                // Check for 0-0 special case
                $day = 0; $month = 0;
                $converted = sscanf( $requestData[ $i ]["DayValue" ], "%d-%d", $day, $month );
                if ( ( $converted == 2 ) && ( $day == 0 ) && ( $month == 0 ) )
                {
                    ++$zeroDatesCount;
                }
                else
                {
                    $dates[] = $requestData[ $i ]["DayValue" ];
                }
            }
        }

        $datesSubmitted = count( $dates );
        /*
        $uniqueDates = array_unique( $dates );

        if ( ( $datesSubmitted == 0 ) || ( count( $uniqueDates ) != $datesSubmitted ) )
        {
            $errors[] = "Duplicate dates detected. Please correct.";
        }
        else*/
        {
            // Determine number of holidays to process
            if ( !$result = @mysqli_query( $connection, "SELECT HolDayID from {$writeTables["Holidays"]} order by HolDayID;" ) )
            {
                $errors[] = "Unable to update due to an internal database issue - holiday ID query.";
                VenusShowError($connection);
            }
            else
            {
                $holDayIDs = array();
                while ( ($row = @mysqli_fetch_array( $result, MYSQLI_ASSOC ) ) != null )
                {
                    if ( !isset( $row[ "HolDayID" ] ) )
                    {
                        continue;
                    }
                    $holDayIDs[] = $row[ "HolDayID" ];
                }

                if ( count( $holDayIDs ) != ( $datesSubmitted + $zeroDatesCount ) )
                {
                    $errors[] = "Mismatch between number of holidays submitted and number allowed in database.";
                }
                else
                {
                    $validatedTimes = array(array());
                    if ( hol_checkDateTimes( $holDayIDs, $requestData, $errors, $validatedTimes ) )
                    {
                        $success = true;
                        foreach( $holDayIDs as $dayID )
                        {
                            if ( !mysqli_query( $connection,
                                    "UPDATE {$writeTables["Holidays"]}
                                    SET DayValue='{$requestData[$dayID]["DayValue"]}',
                                        OpenTimeValue='{$validatedTimes[$dayID]["OpenTimeValue"]}',
                                        CloseTimeValue='{$validatedTimes[$dayID]["CloseTimeValue"]}'
                                    WHERE HolDayID='{$dayID}';" ) )
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

    $sess_prev_data = VenusGetSessPrevDataName( "hol" );

    if ( isset( $_SESSION[ $sess_prev_data ] ) )
    {
        unset( $_SESSION[ $sess_prev_data ] );
    }

    if ( isset( $_POST["timestamp"] ) && isset( $_POST[ "sessionID" ] ) )
    {
        $warnings = array();

        if ( !VenusPerformFormMultiTableUpdate( $_POST, array("Holidays"=>"Holidays"), array(), "hol", "hol_update", $warnings ) )
        {
            $_SESSION[ SESS_ERROR ] = $warnings;
            $_SESSION[ $sess_prev_data ] = $_POST;

            // Remove any irrelevant data
            if ( isset( $_SESSION[ $sess_prev_data ][ SESS_PREV_DATA_TS ] ) )
            {
                unset( $_SESSION[ $sess_prev_data ][ SESS_PREV_DATA_TS ] );
            }
            if ( isset( $_SESSION[ $sess_prev_data ][ SESS_PREV_DATA_SID ] ) )
            {
                unset( $_SESSION[ $sess_prev_data ][ SESS_PREV_DATA_SID ] );
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
