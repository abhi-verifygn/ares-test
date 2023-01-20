#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.hsm.php - Venus web-site login support
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

    /******************************************************************************
    ** Function:    hsm_update
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
    function hsm_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        // Assume success with de-register headset causing a failure until it is
        // fully implemented
        $success = true;

        if ( isset($_POST ) )
        {
            if ( isset( $_POST["headset"]) )
            {
                // No prevention of duplicate names (IDs) would give uniqueness.
                foreach ( $_POST["headset"] as $ID => $headset )
                {
                    if ( isset ( $headset["Name"] ) )
                    {
                         $cleanValue = VenusMySqlVarClean( $headset["Name"] , 25, $connection );
                        if ( !mysqli_query( $connection,
                                "UPDATE {$writeTables["Headsets"]}
                                SET Name='{$cleanValue}'
                                WHERE ID ='{$ID}';" ) )
                        {
                            VenusShowError( $connection );
                            $success = false;
                        }

                    }
                    if ( isset ( $headset["Clear"] ) )
                    {
                        $cleanValue = VenusMySqlVarClean( $headset["Clear"] , 20, $connection );
                        if ( strcmp( $cleanValue, "true" ) == 0 )
                        {
                            if ( !mysqli_query( $connection,
                                    "UPDATE {$writeTables["Headsets"]}
                                    SET InactiveDays='{$cleanValue}'
                                    WHERE ID ='{$ID}';" ) )
                            {
                                VenusShowError( $connection );
                                $success = false;
                            }
                        }
                    }
                }
            }
            if ( isset( $_POST["deregisterHeadset"]) )
            {
                $cleanValue = VenusMySqlVarClean( $_POST["deregisterHeadset"] , 2, $connection );
                $headsetID = intval( $cleanValue );
                if ( $headsetID > 0 )
                {
                    // Delete headset from "headsets"
                    exec( "/usr/bin/send_clr_hs_reg_msg -i {$headsetID}", $output, $returnVal );
                    $success = true;
                }
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

    if ( isset( $_POST["timestamp"] ) && isset( $_POST[ "sessionID" ] ) )
    {
        $warnings = array();

        if ( !VenusPerformFormMultiTableUpdate( $_POST, array("Headsets"=>"Headsets"), array(), "hsm", "hsm_update", $warnings ) )
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
