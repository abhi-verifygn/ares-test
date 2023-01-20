<?php
/******************************************************************************
**
**  COMPONENT:          dbsync_helper - support functions for Venus
**
**  REVISION:           $Revision:  $
**  LAST MODIFIED BY:   $Author:  $
**  DATE:               $Date:  $
**
**  Provides a common functionality providing support for the venus platform
**
*******************************************************************************
**
**  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
**
*******************************************************************************/


/******************************************************************************/
/*    Macro Definitions                                                       */
/******************************************************************************/
define( "REMOTE_SOCKET", "unix:///tmp/dbSync" );


/******************************************************************************
** Function:    VenusDBValFmID
** Parameters:      connection [in] database handle
**                  table [in] database table name
**                  ID [in] ID of parameter to extract
**                  returnOnly [in] output control flag
** Returns:         parameter value for row containing ID
**
** Gets the parameter value associated with the ID from the given table
**
*/

function notifyDBSync( $data )
{
    $resource =  @stream_socket_client( REMOTE_SOCKET, $errno, $errstr );
    if ( !$resource )
    {
        error_log( $errstr."\n", 3, "error_log.txt" );
    }
    else
    {
        error_log( "stream_socket_client call OK\n", 3, "error_log.txt" );
        $stripped = $data;
        $message =  "NOTIFY: {$stripped}";
        @stream_socket_sendto( $resource , $message );
        fclose( $resource );
    }
}

?>
