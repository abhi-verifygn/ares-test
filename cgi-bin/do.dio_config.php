#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.dio_config.php - Venus web-site dio settings support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the digital IO settings form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2015
    **
    *******************************************************************************/

    require_once "venus_helper.php";


    /******************************************************************************
    ** Function:    dio_update
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
    function dio_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        if (   ( !isset( $requestData["params"]["sources"] ) )
            || ( !isset( $requestData["pinID"] ) )
            || ( !isset( $requestData["direction"] ) ) )
        {
            $errors[] = "No global parameters have been specified. Nothing to do.";
            return false;
        }
        
        // Make sure that the data is clean and sane.
        $cleanSource = VenusMySqlVarClean( $requestData["params"]["sources"], 20, $connection );
        $cleanPinID = VenusMySqlVarClean( $requestData["pinID"], 5, $connection );
        $cleanDirection = VenusMySqlVarClean( $requestData["direction"], 5, $connection );
        
        $pinID = intval( $cleanPinID ); 
        if ( ( $pinID < 1 ) || ( $pinID > 18 ) )
        {
            $errors[] = "Pin/Relay ID out of range.";
            return false;
        }
        
        $direction = intval( $cleanDirection );
        if ( ( $direction != DIO_DIR_INPUT ) && ( $direction != DIO_DIR_OUTPUT ) )
        {
            $errors[] = "Invalid direction specified.";
            return false;
        }
        
        # Read in the list of valid sources
        $sources = array();
        
        if ( !($queryResult = @mysqli_query( $connection,
                    "select * from  {$readTables["AdvIOPinSources"]}" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                 $sources[$rowResult["SourceID"]]= $rowResult["PinID"];
            }
            mysqli_free_result( $queryResult );
        }
        
        # Check the source type is valid 
        if ( in_array( $cleanSource, array_keys( $sources ) ) == false )
        {
            $errors[] = "Invalid source.";
            return false;
        }
        
        # If the pin is set as an output, it might have previously been an input
        # and therefore been used to drive outputs. Iterate through all the outputs
        # setting any output associated with the pin's ID and set that output to unused.
        if ( $direction == DIO_DIR_OUTPUT )
        {
            # Determine what source would be associated with the pin ID (relays don't
            # have an associated pinID in the sources list so the search would fail
            $sourceID = array_search( $pinID, $sources );
            
            if ( $sourceID != False )
            {   # Not a relay, so check if this pin is being used to drive other
                # outputs

                $outputsUsingPin = array();
                
                if ( !($queryResult = @mysqli_query( $connection,
                            "select PinID from {$writeTables["AdvIO"]}
                             where PinSourceID = '$sourceID'" ) ) )
                {
                    VenusShowError( $con );
                }
                else
                {
                    while ( $rowResult = mysqli_fetch_array( $queryResult ) )
                    {
                         $outputsUsingPin[] = $rowResult["PinID"];
                    }
                    mysqli_free_result( $queryResult );
                }
                
                # update any other pins referring to the updated pin
                foreach( $outputsUsingPin as $outputPinID )
                {
                    if ( !mysqli_query( $connection,
                            "UPDATE {$writeTables["AdvIO"]}
                            SET PinSourceID='UNUSED'
                            WHERE PinID='{$outputPinID}';" ) )
                    {
                        VenusShowError( $connection );
                    }
                }
            }
        } 

        // Finally update the database for the changed pin 
        if ( !mysqli_query( $connection,
                "UPDATE {$writeTables["AdvIO"]}
                SET PinMode='{$cleanDirection}',
                    PinSourceID='{$cleanSource}'
                WHERE PinID='{$cleanPinID}';" ) )
        {
            VenusShowError( $connection );
        }

        return true;
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
        $writeTables = array( "AdvIO"=>"AdvIO" );
        $readTables = array( "LangAdvIO"=>"LangAdvIO",
                             "AdvIOPinSources"=>"AdvIOPinSources" );


        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "dio", "dio_update", $warnings ) )
        {
            $_SESSION[ SESS_ERROR ] = $warnings;
        }
        
        $modifiedReferer = str_replace( "dio_config", "dio", "{$_SERVER["HTTP_REFERER"]}" );

        header(
            "Location: {$modifiedReferer}",
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
