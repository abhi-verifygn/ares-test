#!/usr/bin/php-cgi -q
<?php
/******************************************************************************
**
**  COMPONENT:          do.hol.ajax - processes the tme AJAX sent data (hols)
**
**  REVISION:           $Revision:  $
**  LAST MODIFIED BY:   $Author:  $
**  DATE:               $Date:  $
**
**
*******************************************************************************
**
**  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
**
*******************************************************************************/

    require_once "venus_helper.php";
    require_once "hol.helper.php";

    /******************************************************************************
    ** Function:    hol_ajax_update
    ** Parameters:      connection [in] database handle
    **                  writeTables[in] array of table names locked for writing
    **                  readTables [in] array of table names locked for reading
    **                  requestData [in] PHP object array of name-value pairs
    **                  response [in/out] PHP object array of name-value pairs
    **                  errors [in/out] error information as concatenated strings
    ** Returns:         true if update and re-read was OK, false otherwise
    **
    ** This function is called by the VenusPerformAJAXMultiTableUpdate helper function when
    ** requestData us ready to be written to the write locked table. The function
    ** re-reads the updated data from the table and place the result in response.
    **
    */
    function hol_ajax_update( $connection, $writeTables, $readTables, $requestData, &$response, &$errors )
    {
        $success = false;

        // Prepare data ready for use, sanitize as required.
        foreach ( $requestData as $object )
        {
            if ( $object->name == AJAX_TIMESTAMP || $object->name == AJAX_SESSION_ID )
            {
                // Skip timestamp and session information from the update
                continue;
            }
            $holidayFormField = explode( "_", $object->name, 2 );

            if ( count( $holidayFormField ) != 2 )
            {
                continue;
            }
            $holidayData[ $holidayFormField[0]][$holidayFormField[1]] =
                VenusMySqlVarClean( $object->value, 5, $connection );
        }

        // Check that no holiday dates are duplicated
        $dates = array();
        foreach( $holidayData as $holiday )
        {
            if ( isset( $holiday[ "DayValue" ] ) )
            {
                $dates[] = $holiday[ "DayValue" ];
            }
        }

        $datesSubmitted = count( $dates );
        $uniqueDates = array_unique( $dates );

        if ( ( $datesSubmitted == 0 ) || ( count( $uniqueDates ) != $datesSubmitted ) )
        {
            $errors[] = "Duplicate dates detected. Please correct.";
        }
        else
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

                if ( count( $holDayIDs ) != $datesSubmitted )
                {
                    $errors[] = "Mismatch between number of holidays submitted and number allowed in database.";
                }
                else
                {
                    if ( hol_checkDateTimes( $holDayIDs, $holidayData, $errors ) )
                    {

                        $success = true;
                        foreach( $holDayIDs as $dayID )
                        {
                            if ( !mysqli_query( $connection,
                                    "UPDATE {$writeTables["Holidays"]}
                                    SET DayValue='{$holidayData[$dayID]["DayValue"]}',
                                        OpenTimeValue='{$holidayData[$dayID]["OpenTimeValue"]}',
                                        CloseTimeValue='{$holidayData[$dayID]["CloseTimeValue"]}'
                                    WHERE HolDayID='{$dayID}';" ) )
                            {
                                VenusShowError($connection);
                                $success = false;
                            }
                        }
                    }
                }
                mysqli_free_result( $result );

                if ( $success )
                {
                    # Done with the update phase, now build the response
                    # spin through the table building an array, then pass
                    # these back to the caller
                    if ( $queryResult = @mysqli_query(
                                $connection,
                                "select HolDayID,
                                        DayValue,
                                        OpenTimeValue,
                                        CloseTimeValue
                                from {$writeTables["Holidays"]};" ) )
                    {
                        while( $row = @mysqli_fetch_object( $queryResult ) )
                        {
                            // Session and Timestamp ID's are not updated
                            if ( ( $row->ID === SESSION_ID )  || ( $row->ID === TIMESTAMP_ID ) )
                            {
                                continue;
                            }
                            $HolDayID = $row->HolDayID;
                            $response[] = array(
                                "ID"=>$HolDayID . "_HolDayID",
                                "Value" => $row->HolDayID  );
                            $response[] = array(
                                "ID"=>$HolDayID . "_DayValue",
                                "Value" => $row->DayValue  );
                            $response[] = array(
                                "ID"=>$HolDayID . "_OpenTimeValue",
                                "Value"=> $row->OpenTimeValue  );
                            $response[] = array(
                                "ID"=>$HolDayID . "_CloseTimeValue",
                                "Value" => $row->CloseTimeValue  );
                        }

                        mysqli_free_result( $queryResult );
                    }
                    else
                    {
                        VenusShowError( $connection );
                        $success = false;
                    }
                }
            }
        }
        return $success;
    }

    /******************************************************************************
    **  Script entry point
    **
    */

    VenusPerformAJAXMultiTableUpdate( $_POST[ AJAX_DATA ],
        array("Holidays"=>"Holidays"), array(), "hol", "hol_ajax_update", $JSONResponse );
    echo $JSONResponse;
?>
