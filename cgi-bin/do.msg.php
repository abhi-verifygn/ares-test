#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.msg.php - Venus web-site login support
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
    ** Function:    msg_update
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
    function msg_update( $connection, $writeTables, $readTables, $requestData, &$errors )
    {
        if (!isset( $requestData["msg"] ) )
        {
            $errors[] = "No message parameters have been specified. Nothing to do.";
            return false;
        }
        else
        {
            $msg = $requestData["msg"];
            $cleanPlayDelay = intval( VenusMySqlVarClean( $msg["playbackDelay"], 2, $connection ) );
            if ( ( $cleanPlayDelay < 0 ) || ($cleanPlayDelay > 25 ) )
            {
                $errors[] = "Playback delay - out of bounds - 0 to 25 valid" ;
                return false;
            }
            if ( !mysqli_query( $connection,
                    "UPDATE {$writeTables["MSG"]}
                    SET ParamValueID ='{$cleanPlayDelay}'
                    WHERE ParamNameID = 'PlaybackDelay';" ) )
            {
                VenusShowError( $connection );
                return false;
            }

            $cleanPlayToHeadsets = intval( VenusMySqlVarClean( $msg["playbackToHeadsets"], 1, $connection ) );
            $cleanPlayToHeadsets &= 1;
            if ( !mysqli_query( $connection,
                    "UPDATE {$writeTables["MSG"]}
                    SET ParamValueID ='{$cleanPlayToHeadsets}'
                    WHERE ParamNameID = 'PlaybackToHeadsets';" ) )
            {
                VenusShowError( $connection );
                return false;
            }

            $cleanPlayThruMonitor = intval( VenusMySqlVarClean( $msg["playbackThruMonitor"], 1, $connection ) );
            $cleanPlayThruMonitor &= 1;
            if ( !mysqli_query( $connection,
                    "UPDATE {$writeTables["MSG"]}
                    SET ParamValueID ='{$cleanPlayThruMonitor}'
                    WHERE ParamNameID = 'PlaybackThruMonitor';" ) )
            {
                VenusShowError( $connection );
                return false;
            }

            $cleanToneDuringPlayback = intval( VenusMySqlVarClean( $msg["toneDuringPlayback"], 1, $connection ) );
            $cleanToneDuringPlayback &= 1;
            if ( !mysqli_query( $connection,
                    "UPDATE {$writeTables["MSG"]}
                    SET ParamValueID ='{$cleanToneDuringPlayback}'
                    WHERE ParamNameID = 'PlaybackToneDuringPlayback';" ) )
            {
                VenusShowError( $connection );
                return false;
            }

            $cleanPlayClosedMsg = intval( VenusMySqlVarClean( $msg["playClosedMsg"], 1, $connection ) );
            $cleanPlayClosedMsg &= 1;
            if ( !mysqli_query( $connection,
                    "UPDATE {$writeTables["MSG"]}
                    SET ParamValueID ='{$cleanPlayClosedMsg}'
                    WHERE ParamNameID = 'PlayRestaurantClosedMsg';" ) )
            {
                VenusShowError( $connection );
                return false;
            }

            $cleanTandemPullHead = intval( VenusMySqlVarClean( $msg["tandemPullHead"], 1, $connection ) );
            $cleanTandemPullHead &= 1;
            if ( !mysqli_query( $connection,
                    "UPDATE {$writeTables["MSG"]}
                    SET ParamValueID ='{$cleanTandemPullHead}'
                    WHERE ParamNameID = 'TandemPullAheadMessage';" ) )
            {
                VenusShowError( $connection );
                return false;
            }

            if ( strlen( $msg["playbackMode"] ) != 0 )
            {
                $cleanPlaybackMode = intval( VenusMySqlVarClean( $msg["playbackMode"], 1, $connection ) );
                $cleanPlaybackMode &= 1;

                if ( !mysqli_query( $connection,
                        "UPDATE {$writeTables["MSG"]}
                        SET ParamValueID ='{$cleanPlaybackMode}'
                        WHERE ParamNameID = 'PlaybackMode';" ) )
                {
                    VenusShowError( $connection );
                    return false;
                }
            }

            // Determine range of valid message IDs
            $messageIDs = array();
            if ( !($queryResult = @mysqli_query( $connection,
                        "select MsgID
                        from {$writeTables["Messages"]};" ) ) )
            {
                VenusShowError( $con );
            }
            else
            {
                while ( $rowResult = mysqli_fetch_array( $queryResult ) )
                {
                    $messageIDs[] = $rowResult["MsgID"];
                }
                mysqli_free_result( $queryResult );
            }

            $cleanExtDetMsg = intval( VenusMySqlVarClean( $msg["playExtDetMsg"], 3, $connection ) );
            if ( !in_array( $cleanExtDetMsg, $messageIDs ) )
            {
                $cleanExtDetMsg = 0;
            }

            if ( !mysqli_query( $connection,
                    "UPDATE {$writeTables["MSG"]}
                    SET ParamValueID ='{$cleanExtDetMsg}'
                    WHERE ParamNameID = 'PlayExtDetectorMessage';" ) )
            {
                VenusShowError( $connection );
                return false;
            }

            // Enable/Disable messages
            if (isset( $requestData["msg"]["enabled" ] ) )
            {
                foreach ( $requestData["msg"]["enabled" ] as $MsgID => $enabled )
                {
                    $cleanMsgID = VenusMySqlVarClean( $MsgID, 3, $connection );
                    $cleanEnabled = VenusMySqlVarClean( $enabled, 1, $connection );
                    $cleanEnabled &= $cleanEnabled;

                    if ( !mysqli_query( $connection,
                        "UPDATE {$writeTables["Messages"]}
                         SET Enabled = '{$cleanEnabled}'
                         WHERE MsgID = '{$cleanMsgID}';" ) )
                    {
                        VenusShowError( $connection );
                        return false;
                    }
                }
            }

            return $true;
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
        $warnings = array();
        $writeTables = array( "MSG"=>"MSG",
                              "Messages"=>"Messages"  );
        $readTables = array( );


        if ( !VenusPerformFormMultiTableUpdate( $_POST,
                $writeTables, $readTables, "msg", "msg_update", $warnings ) )
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
