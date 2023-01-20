#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.vlm.php - Venus web-site login support
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
    function vlm_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = false;

        if (!isset( $requestData["params"] ) )
        {
            $errors[] = "No volume parameters have been specified. Nothing to do.";
            return false;
        }
        else
        {
            $successfulUpdates = 0;
			$writePtr = $writeTables["Volume"];
			$paramPtr = $readTables["VolumeParams"];
            foreach( $requestData["params"] as $paramName => $paramValueName )
            {
                // Make sure that the data is clean and sane.
				if($writePtr == $writeTables["Volume"])
				{
                    $cleanParamName = VenusMySqlVarClean( $paramName, 40, $connection );
				}
                $cleanParamValue = VenusMySqlVarClean( $paramValueName, 20, $connection );

				if($cleanParamValue != "N/A")
				{
					// Check the contents of the parameter is valid
					if (VenusValidateParam( $connection, $cleanParamName, $cleanParamValue,
											$writePtr, $paramPtr, $errors ))
					{
						// Update the database
						if ( !mysqli_query( $connection,
								"UPDATE {$writePtr}
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
				else
				{
				    ++$successfulUpdates;
				}
					
                /* Switch to the opposite lane data */
                if($writePtr == $writeTables["Volume"])
				{
				    /* Switch to lane 2 */
                    $writePtr = $writeTables["DL2Volume"];
                    $paramPtr = $readTables["DL2VolumeParams"];
				}
				else
				{
				    /* Switch to lane 1 */
                    $writePtr = $writeTables["Volume"];
                    $paramPtr = $readTables["VolumeParams"];
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
        $warnings = array(  );
        $writeTables = array( "Volume"=>"Volume",
						      "DL2Volume"=>"DL2Volume" );
        $readTables = array( "VolumeParams"=>"VolumeParams",
                             "LangVolume"=>"LangVolume",
						     "DL2VolumeParams"=>"DL2VolumeParams" );


        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "vlm", "vlm_update", $warnings ) )
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
