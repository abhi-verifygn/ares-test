#!/usr/bin/php-cgi -q
<?php
/******************************************************************************
**
**  COMPONENT:          do.tme.ajax - processes the tme AJAX sent data (location)
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
    require_once "tme.helper.php";

    /******************************************************************************
    ** Function:    tme_ajax_update
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
    function tme_ajax_update( $connection, $writeTables, $readTables, $requestData, &$response, &$errors )
    {
        $success = false;

        # Process zero, or more updates
        if ( count( $requestData ) > 0 )
        {
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
                $timeData = array();
                foreach ( $requestData as $object )
                {
                    if ( $object->name == AJAX_TIMESTAMP || $object->name == AJAX_SESSION_ID )
                    {
                        // Skip timestamp and session information from the update
                        continue;
                    }
                    $dayName = explode( "_", $object->name, 2 );

                        if ( count( $dayName ) != 2 )
                        {
                            continue;
                        }
                    $timeData[ $dayName[0]][$dayName[1]] =
                        VenusMySqlVarClean( $object->value, 5, $connection );
                }

                if ( tme_checkTimes( $daysOfWeek, $timeData, $errors ) )
                {
                    # Go update the database with validated values
                    $success = true;

                    foreach( $daysOfWeek as $day )
                    {
                        if ( !@mysqli_query(
                            $connection,
                            "UPDATE {$writeTables["WorkingHours"]} SET
                                OpenTimeValue = '{$timeData[$day]["OpenTimeValue"]}',
                                DayTimeValue = '{$timeData[$day]["DayTimeValue"]}',
                                NightTimeValue = '{$timeData[$day]["NightTimeValue"]}',
                                CloseTimeValue = '{$timeData[$day]["CloseTimeValue"]}'
                            WHERE DayNameID='{$day}';" )
                            )
                        {
                            $success = false;
                        }
                    }
                }
                mysqli_free_result( $result );
            }
        }

        if ( $success )
        {
            # Done with the update phase, now build the response
            # spin through the table building an array, then pass
            # these back to the caller
            if ( $queryResult = @mysqli_query(
                        $connection,
                        "select DayNameID,
                                OpenTimeNameID,OpenTimeValue,
                                CloseTimeNameID, CloseTimeValue,
                                DayTimeNameID, DayTimeValue,
                                NightTimeNameID, NightTimeValue
                        from {$writeTables["WorkingHours"]};" ) )
            {
                while( $row = @mysqli_fetch_object( $queryResult ) )
                {
                    // Session and Timestamp ID's are not updated
                    if ( ( $row->ID === SESSION_ID )  || ( $row->ID === TIMESTAMP_ID ) )
                    {
                        continue;
                    }
                    $dayName = $row->DayNameID;
                    $response[] = array(
                        "ID"=>$dayName . "_" . $row->OpenTimeNameID,
                        "Value" => $row->OpenTimeValue  );
                    $response[] = array(
                        "ID"=>$dayName . "_" . $row->CloseTimeNameID,
                        "Value"=> $row->CloseTimeValue  );
                    $response[] = array(
                        "ID"=>$dayName . "_" . $row->DayTimeNameID,
                        "Value" => $row->DayTimeValue  );
                    $response[] = array(
                        "ID"=>$dayName . "_" . $row->NightTimeNameID,
                        "Value" => $row->NightTimeValue  );
                }
                mysqli_free_result( $queryResult );
            }
            else
            {
                $success = false;
            }
        }
        return $success;
    }

    /******************************************************************************
    **  Script entry point
    **
    */
    VenusPerformAJAXMultiTableUpdate( $_POST[ AJAX_DATA ],
        array("WorkingHours"=>"WorkingHours"), array(), "tme", "tme_ajax_update", $JSONResponse );
    echo $JSONResponse;
?>
