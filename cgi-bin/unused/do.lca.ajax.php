#!/usr/bin/php-cgi -q
<?php
/******************************************************************************
**
**  COMPONENT:          do.lca.ajax - processes the lca AJAX sent data (location)
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

    /******************************************************************************
    ** Function:    lca_ajax_update
    ** Parameters:      connection [in] database handle
    **                  writeTables[in] array of table names locked for writing
    **                  readTables [in] array of table names locked for reading
    **                  requestData [in] PHP object array of name-value pairs
    **                  response [in/out] PHP object array of name-value pairs
    ** Returns:         true if update and re-read was OK, false otherwise
    **
    ** This function is called by the VenusPerformAJAXMultiTableUpdate helper function when
    ** requestData us ready to be written to the write locked table. The function
    ** re-reads the updated data from the table and place the result in response.
    **
    */
    function lca_ajax_update( $connection, $writeTables, $readTables, $requestData, &$response )
    {
        $success = true;

        # Process zero, or more updates
        if ( count( $requestData ) > 0 )
        {
            # Go update the database with any valid values
            foreach ( $requestData as $object )
            {
                if ( $object->name == AJAX_TIMESTAMP || $object->name == AJAX_SESSION_ID )
                {
                    // Skip timestamp and session information from the update
                    continue;
                }
                $name = VenusMySqlVarClean( $object->name, 20, $connection );
                $value = VenusMySqlVarClean( $object->value, 20, $connection );

                if ( !@mysqli_query(
                    $connection,
                    "UPDATE {$writeTables["LocationDetails"]} SET Value='{$value}'
                    WHERE ID='{$name}';" )
                    )
                {
                    $success = false;
                }
            }
        }

        # Done with the update phase, now build the response
        # spin through the table building an array, then pass
        # these back to the caller
        if ( $queryResult = @mysqli_query( $connection, "select ID, Value from {$writeTables["LocationDetails"]};" ) )
        {
            while( $row = @mysqli_fetch_object( $queryResult ) )
            {
                // Session and Timestamp ID's are not displayed
                if ( ( $row->ID === SESSION_ID )  || ( $row->ID === TIMESTAMP_ID ) )
                {
                    continue;
                }
                $response[] = $row;
            };
            mysqli_free_result( $queryResult );
        }
        else
        {
            $success = false;
        }

        return $success;
    }

    /******************************************************************************
    **  Script entry point
    **
    */
    VenusPerformAJAXMultiTableUpdate( $_POST[ AJAX_DATA ],
        array("LocationDetails"=>"LocationDetails"), array(), "lca", "lca_ajax_update", $JSONResponse );
    echo $JSONResponse;
?>
