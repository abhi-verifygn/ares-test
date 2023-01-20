#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.act.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Receives ACT request from browser and sends appropriate response
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "HTML/Template/ITX.php";
    require_once "venus_helper.php";

    /******************************************************************************
    **  Script entry point
    **
    */

    if ( session_start() == false )
    {
        die( "Unable to start session. Serious. Terminating script processing");
    }
    if ( VenusSessionAuthenticate( false ) )
    {

        $_SESSION[ SESS_ERROR ] = "";
        $_SESSION[ SESS_MESSAGE ] = "";

        $con = VenusDBConnect();

        if (!mysqli_query( $con,
                    VenusGenerateSQLLockingCommand( array(), array() ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            if ( isset( $_POST["timestamp"] ) && isset( $_POST[ "sessionID" ] ) )
            {
                $warnings = array();

                if (isset( $_POST[ "BASE_OPEN" ] ) )
                {
                
                    $cleanParamValue = VenusMySqlVarClean( $_POST[ "BASE_OPEN" ], 20, $con );
                    if (
                        ( $cleanParamValue == "OPENED" )
                        || ($cleanParamValue == "CLOSED" ))
                    {
                        /* Base open/closed messages understood by MMI task (ID=149):
                         *   MSG_MMI_WEB_OPENBASE_REQ - 0x40
                         *   MSG_MMI_WEB_CLOSEBASE_REQ- 0x41
                         */
                        $msgID = ($cleanParamValue == "OPENED" ) ? "40" : "41";
                        exec( "/usr/bin/send_tmk_message -t 149 -m {$msgID}", $output, $returnVal );
                        
                        if ( intval( $returnVal ) != 0 )
                        {
                            echo "Base open/close command failed.";
                        }
                        else if ( $cleanParamValue == "OPENED" )
                        {
                            echo "Base open for registrations.";
                        }
                        // Update the database
                        if ( !mysqli_query( $con,
                                "UPDATE ".UPDATE_MGT_TABLE."
                                SET Value='{$cleanParamValue}'
                                WHERE Name='".UPDATEMGT_BaseOpen."';" ) )
                        {
                            VenusShowError( $con );
                        }
                    }
                    else
                    {
                        echo "BASE_OPEN received but parameters not understood.";
                    }
                }
                else if (isset( $_POST[ "GREETER_OPERATION" ] ) && isset( $_POST[ "msgID" ] ) )
                {
                    $cleanOperationValue = VenusMySqlVarClean( $_POST[ "GREETER_OPERATION" ], 20, $con );
                    $cleanClipIDValue = VenusMySqlVarClean( $_POST[ "msgID" ], 3, $con );
                    
                    unset( $greeterOperation );
                    
                    switch ( $cleanOperationValue )
                    {
                        case "PLAY":
                        $greeterOperation = 1;
                        $greeterTextOperation = "playing back";
                        break;
                        
                        case "RECORD":
                        $greeterOperation = 2;
                        $greeterTextOperation = "recording";
                        break;
                        
                        case "STOP":
                        $greeterOperation = 0;
                        $greeterTextOperation = "stopping";
                        break;
                        
                        default:
                        echo "GREETER_OPERATION received but parameters not understood.";
                    }
                    
                    if ( isset( $greeterOperation ) )
                    {
                        exec( "/usr/bin/send_greeter_ctrl_message -c {$cleanClipIDValue} -o {$greeterOperation}", 
                                $output, $returnVal );
                        
                        if ( intval( $returnVal ) == 0 )  // Request completed successfully
                        {
                            echo "Greeter is {$greeterTextOperation} clip {$cleanClipIDValue}.";
                        }
                        else 
                        {   // Request failed
                            if ( $cleanOperationValue == "PLAY" )
                            {
                                echo "Cannot play clip {$cleanClipIDValue}. Greeter currently busy playing or recording.";
                            }
                            else if ( $cleanOperationValue == "RECORD" )
                            {
                                echo "Cannot record clip {$cleanClipIDValue}. Greeter currently busy playing or recording.";
                            }
                            else if ( $cleanOperationValue == "STOP" )
                            {
                                echo "Cannot stop playback or recording of clip {$cleanClipIDValue}. Playback or recording may have already stopped.";
                            }
                        }
                    }
                }
                else
                {
                    echo "Command received but not implemented.";
                }
            }
            else
            {
               echo "You are not allowed to access this resource directly.";
            }
            if ( ! @mysqli_query( $con, "UNLOCK TABLES;" ) )
            {
                VenusShowError( $con );
            }
        }
    }
    else
    {
        echo "Cannot accept non-authorised direct request. Please log-in first.";
    }
?>
