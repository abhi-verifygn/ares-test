#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.tme.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the opening, etc, times form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";
    require_once "tme.helper.php";

    /******************************************************************************
    ** Function:    tme_update
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
    function tme_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = false;

        if ( !$result = @mysqli_query( $connection, "SELECT DayNameID from {$writeTables["WorkingHours"]};" ) )
        {
            $errors[] = "Unable to update due to an internal database issue - day name query.";
        }
        else
        {
            $daysOfWeek = array();
            while ( ($row = @mysqli_fetch_array( $result, MYSQLI_ASSOC ) ) != null )
            {
                if ( !isset( $row[ "DayNameID" ] ) )
                {
                    continue;
                }
                $daysOfWeek[] = $row[ "DayNameID" ];
            }

            if ( tme_checkTimes( $daysOfWeek, $requestData, $errors ) )
            {
                $queriesOK = true;
                foreach( $daysOfWeek as $day )
                {
                    if ( !mysqli_query( $connection,
                            "UPDATE {$writeTables["WorkingHours"]}
                            SET OpenTimeValue='{$requestData[$day]['OpenTimeValue']}',
                                CloseTimeValue='{$requestData[$day]['CloseTimeValue']}',
                                DayTimeValue='{$requestData[$day]['DayTimeValue']}',
                                NightTimeValue='{$requestData[$day]['NightTimeValue']}'
                            WHERE DayNameID='{$day}';" ) )
                    {
                        VenusShowError( $connection );
                        $queriesOK = false;
                    }
                }
                $success = (count($daysOfWeek) > 0) && $queriesOK;
            }
            mysqli_free_result( $result );
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

    $sess_prev_data = VenusGetSessPrevDataName( "tme" );

    if ( isset( $_SESSION[ $sess_prev_data ] ) )
    {
        unset( $_SESSION[ $sess_prev_data ] );
    }

    if ( isset( $_POST["timestamp"] ) && isset( $_POST[ "sessionID" ] ) )
    {
        $warnings = array();

        if ( !VenusPerformFormMultiTableUpdate( $_POST, array("WorkingHours"=>"WorkingHours"), array(), "tme", "tme_update", $warnings ) )
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
