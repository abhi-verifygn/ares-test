#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.cf_upgrade_poller.php - Venus web-site upgrade support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted data from the tarball upgrade form.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2014
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
        exit;
    }

    if ( VenusSessionAuthenticate() == false )
    {
        exit;
    }

    $_SESSION[ SESS_ERROR ] = "";
    $_SESSION[ SESS_MESSAGE ] = "";

    if ( is_readable( PROGRESS_CHECK_SCRIPT ) )
    {
        $cmdOutput = array();
        exec( PROGRESS_CHECK_SCRIPT, $cmdOutput, $result );
        
        # If PROCESS_CHECK script returns non-zero then display progress text on webpage, otherwise
        # assume successful update.
        if ( $result != 0 )
        {
            # The archive is assummed as being unzipped if PROCESS_CHECK script returns non-zero & no output
            if ( count( $cmdOutput ) == 0 )
            {
                $refreshCount = 0;
                if ( isset( $_COOKIE[ SESS_UPGRADE_REFRESH_COUNT ] ) )
                {
                    $refreshCount = intval( $_COOKIE[ SESS_UPGRADE_REFRESH_COUNT ] );
                }
                $expectedUnzipTime = PROGRESS_UNZIP_TIMEOUT - (PROGRESS_REFRESH_PERIOD * $refreshCount);
                ++$refreshCount;
                setcookie( SESS_UPGRADE_REFRESH_COUNT, strval( $refreshCount ) );
                $expectedUTStr = ( $expectedUnzipTime > 0 ) ? "in ${expectedUnzipTime} seconds" : "soon";
                $cmdOutput[] = "Unzipping upgrade file. Expected to complete unzip ${expectedUTStr}."; 
            }
            # Put the time the upgrade started at the beginning of the output
            array_unshift( $cmdOutput, "Upgrade started at: ${_SESSION[ SESS_UPGRADE_START_TIME ]}:" );
            
            $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
            $template->loadTemplatefile( VenusGetTemplateName( "cf_upgrade_poller" ), true, true );

            $template->setCurrentBlock( "CF_UPGRADE_POLLER_HEADER" );
            $template->setVariable( "REFRESH", '<meta http-equiv="refresh" content="'.PROGRESS_REFRESH_PERIOD.'">' );
            $template->parseCurrentBlock();

            $template->setCurrentBlock( "CF_UPGRADE_POLLER_TABLE" );
            $template->setVariable( "TITLE", "Upgrade Progress" );

            foreach( $cmdOutput as $cmdLine )
            {
                $template->setCurrentBlock( "CF_UPGRADE_POLLER_ROW" );        
                $template->setVariable( "CMDLINE", "${cmdLine}" );
                $template->parseCurrentBlock();
            }

            $template->setCurrentBlock( "CF_UPGRADE_POLLER_TABLE" );
            $template->parseCurrentBlock();
            $template->show( );
        }
        else
        {
            # Upgrade completed - system is rebooting
            $_SESSION[SESS_MESSAGE] = "System update has been applied successfully - system is rebooting.";
            header(
                "location: logout.php",
                true, // replace any existing location header
                303   // HTTP "303 see other" response code
                );
        }
    }
    else
    {
            # Upgrade is running but status cannot be checked
            $_SESSION[SESS_MESSAGE] = "System update is being applied. Please five minutes for upgrade to complete.";
            header(
                "location: logout.php",
                true, // replace any existing location header
                303   // HTTP "303 see other" response code
                );
    }
?>
