#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.ngt.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the night volume settings form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    ** Function:    ngt_update
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
    function ngt_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = false;

        if (   !isset( $requestData[ "params" ] )
            || !isset( $requestData[ "TalkVol" ] )
            || !isset( $requestData[ "TalkVol_L2" ] ) )
        {
            $errors[] = "No night volume or talk volume parameters have been specified. Nothing to do.";
            return false;
        }
        else
        {
            $successfulUpdates = 0;
            
            // Get the outbound Talk Volumes for use in maximum reduction value validation
            $cleanOutBoundTalkVolL1 = VenusMySqlVarClean( $requestData[ "TalkVol" ], 2, $connection );
            $cleanOutBoundTalkVolL2 = VenusMySqlVarClean( $requestData[ "TalkVol_L2" ], 2, $connection );
            
			$writePtr = $writeTables["NightVolume"];
			$paramPtr = $readTables["NightVolumeParams"];
            foreach( $requestData["params"] as $paramName => $paramValueName )
            {
                // Make sure that the data is clean and sane.
                $cleanParamName = VenusMySqlVarClean( $paramName, 40, $connection );
                $cleanParamValue = VenusMySqlVarClean( $paramValueName, 20, $connection );
                
                // Form appends _L2 onto all paramters that are related to lane 2. This
                // needs to be stripped off when updating the night volumes settings for
                // lane 2
                $lane2SuffixStart = strpos( $cleanParamName, "_L" );
                $cleanTableParamName = ($lane2SuffixStart > 0) ?
                        substr( $cleanParamName, 0, $lane2SuffixStart ) : $cleanParamName;

                // Check the contents of the parameter is valid
                if (VenusValidateParam( $connection, $cleanTableParamName, $cleanParamValue,
                                        $writePtr, $paramPtr, $errors ))
                {
                    // Run appropriate lane dependent parameters
                    if ( $writePtr == $writeTables["NightVolume"] ) 
                    {
                        // Run appropriate validation for Lane 1 parameters
                        if ( $cleanParamName === "ReduceDriveThruVolBy" )
                        {
                            if ( $cleanParamValue >= $cleanOutBoundTalkVolL1 )
                            {
                                $cleanParamValue = ($cleanOutBoundTalkVolL1 > 0) ? $cleanOutBoundTalkVolL1 - 1 : 0;
                            }
                        }
                    }
                    else
                    {
                        // Run appropriate validation for Lane 2 parameters
                        if ( $cleanParamName === "ReduceDriveThruVolBy_L2" )
                        {
                            if ( $cleanParamValue >= $cleanOutBoundTalkVolL2 )
                            {
                                $cleanParamValue = ($cleanOutBoundTalkVolL2 > 0) ? $cleanOutBoundTalkVolL2 - 1 : 0;
                            }
                        }
                    }
                    
                    // Update the database
                    if ( !mysqli_query( $connection,
                            "UPDATE {$writePtr}
                            SET ParamValueID='{$cleanParamValue}'
                            WHERE ParamNameID='{$cleanTableParamName}';" ) )
                    {
                        VenusShowError( $connection );
                    }
                    else
                    {
                        ++$successfulUpdates;
                    }

					/* Switch to the opposite lane data */
					if($writePtr == $writeTables["NightVolume"])
					{
						/* Switch to lane 2 */
						$writePtr = $writeTables["DL2NightVolume"];
						$paramPtr = $readTables["DL2NightVolumeParams"];
					}
					else
					{
						/* Switch to lane 1 */
						$writePtr = $writeTables["NightVolume"];
						$paramPtr = $readTables["NightVolumeParams"];
					}
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
        $writeTables = array( "NightVolume"=>"NightVolume",
                              "DL2NightVolume"=>"DL2NightVolume", );
        $readTables = array( "NightVolumeParams"=>"NightVolumeParams",
                             "LangNightVolume"=>"LangNightVolume",
							 "DL2NightVolumeParams"=>"DL2NightVolumeParams", );

        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "ngt", "ngt_update", $warnings ) )
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
