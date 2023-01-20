#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.lca.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the site location information form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";
    require_once "dbsync_helper.php";

    /******************************************************************************
    ** Function:    lca_update
    ** Parameters:      connection [in] database handle
    **                  writeTables[in] array of table names locked for writing
    **                  readTables [in] array of table names locked for reading
    **                  requestData [in] PHP object array of name-value pairs
    **                  processedData [out] processed data
    **                  errors [in/out] error information as concatenated strings
    ** Returns:         true if update occurred, false otherwise
    **
    ** This function is called by the VenusPerformFormMultiTableUpdate helper function when
    ** requestData us ready to be written to the write locked table.
    **
    */
    function lca_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        $success = true;

        // Perform validation here,

        foreach ( $requestData as $varID => $varDetails )
        {
            $varID = VenusMySqlVarClean( $varID, 20, $connection );
            $varDetails = VenusMySqlVarClean( $varDetails, 20, $connection );

            if ( $varID == null ||
                ! isset($varDetails) ||
                $varID == AJAX_TIMESTAMP ||
                $varID == AJAX_SESSION_ID )
            {
                continue;
            }

            if ( !mysqli_query( $connection,
                    "UPDATE {$writeTables["LocationDetails"]} SET Value='{$varDetails}'
                    WHERE ID='{$varID}';" ) )
            {
                VenusShowError( $connection );
                $success = false;
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
        $table = "LocationDetails";
        $processedData = array();

        if ( VenusPerformFormMultiTableUpdate(
            $_POST, array("LocationDetails"=>"LocationDetails"), array(), "lca", "lca_update", $processedData, $warning ) )
        {
            #error_log( "Calling notifyDBSync()\n", 3, "error_log.txt" );
            #notifyDBSync( implode( ", ", $_POST ) );
        }
        else
        {
            #error_log( "Skipping notifyDBSync()\n", 3, "error_log.txt" );
        }

        $_SESSION[ SESS_ERROR ] = $warning;
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
