#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.device.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the Monitoring settings form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    define( "RESTART_DEVICE_SCRIPT","/usr/bin/do_device_restart.sh" );

    /******************************************************************************
    ** Function:    vlm_update
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
    function device_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = false;

        #error_log("starting device_update\n", 3, "device_log.txt");

        if (!isset( $requestData["params"] ) )
        {
            $errors[] = "No volume parameters have been specified. Nothing to do.";
            return false;
        }
        else
        {
            #error_log("write=".$writeTables."\n", 3, "device_log.txt");
            #error_log("read=".$readTables."\n", 3, "device_log.txt");

            $successfulUpdates = 0;
			$writePtr = $writeTables["LaneDeviceSettings"];
			$paramPtr = $readTables["LaneDeviceSettings"];
            foreach( $requestData["params"] as $paramName => $paramValueName )
            {
                // Make sure that the data is clean and sane.
                $cleanParamName = VenusMySqlVarClean( $paramName, 40, $connection );
                $cleanParamValue = VenusMySqlVarClean( $paramValueName, 80, $connection );

                #error_log("parm=".$cleanParamName."\n", 3, "device_log.txt");
                #error_log("value=".$cleanParamValue."\n", 3, "device_log.txt");

				if($cleanParamValue != "N/A")
				{
					// Check the contents of the parameter is valid
                    if ( !($paramNamesQuery = @mysqli_query( $connection,
                    "select *
                    from {$writePtr} where textID = '{$cleanParamName}';" ) ) )
                    {
                        VenusShowError( $connection );
                    }
                    else
                    {
						// Update the database
						if ( !mysqli_query( $connection,
								"UPDATE {$writePtr}
								SET dataValue='{$cleanParamValue}'
								WHERE textID='{$cleanParamName}';" ) )
						{
							VenusShowError( $connection );
						}
						else
						{
							++$successfulUpdates;
						}
                    }
				}
				else
				{
				    ++$successfulUpdates;
				}
            }

            @exec( RESTART_DEVICE_SCRIPT . "", $output, $returnVal );

            return $successfulUpdates == count($requestData["params"]);
        }
    }

    /******************************************************************************
    **  Script entry point
    **
    */

    #error_log( "Starting do.device.php\n", 3, "device_log.txt" );

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

    #error_log( "isset\n", 3, "device_log.txt" );

    if ( isset( $_POST["timestamp"] ) && isset( $_POST[ "sessionID" ] ) )
    {
        $warnings = array(  );
        $writeTables = array( "LaneDeviceSettings"=>"LaneDeviceSettings" );
//        $readTables = array( "LaneDeviceSettings"=>"LaneDeviceSettings" );

        #error_log( "VenusPerformFormMultiTableUpdate\n", 3, "device_log.txt" );
//        error_log( $_POST, 3, "device_log.txt");

        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "device", "device_update", $warnings ) )
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
