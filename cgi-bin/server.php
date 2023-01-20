#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          server.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the network settings form
    **
    *******************************************************************************
    **
    **  Copyright (c) Digital Acoustics, 2022
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

    $timeNow = time();

    VenusSessionAuthenticate();

    $con = VenusDBConnect();

    $readTables  = array( "LangLaneServerSettings"=>"LangLaneServerSettings" );
    $writeTables = array( "LaneServerSettings"=>"LaneServerSettings" );

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        $labelArray = VenusGetLabels( $con,
                $readTables["LangLaneServerSettings"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "server" ), true, true );

        $template->setCurrentBlock( "SERVER_PAGE" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );

        $template->parseCurrentBlock();
        $template->show( );

		if ( isset( $_SESSION[ SESS_ERROR ] ) )
        {
            unset( $_SESSION[ SESS_ERROR ] );
        }

        if ( !@mysqli_query( $con, "UNLOCK TABLES;" ) )
        {
            VenusShowError( $con );
        }
    }
?>
