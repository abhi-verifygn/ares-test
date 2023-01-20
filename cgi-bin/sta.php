#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          sta.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the status/diagnostics web page.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2015
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

    $writeTables = array(  );
    $readTables = array(
                         "LangSTA"=>"LangSTA",
                       );

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        $labelArray = VenusGetLabels( $con,
                $readTables["LangSTA"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "sta" ), true, true );

        $template->setCurrentBlock( "STA_PAGE" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );
        
        $template->setVariable( "STATUS_FLAGS_HEADING", $labelArray["STATUS_FLAGS_HEADING"] );

        /* LANE STATUS ENTRIES */

        $noText = $labelArray["No"];
        $yesText = $labelArray["Yes"];
        $laneText[1] = $labelArray["Lane1"];
        $laneText[2] = $labelArray["Lane2"];

        $laneStatus = array( );
        
        if ( is_executable( STATUS_CHECK_APP ) )
        {
            $cmdOutput = array();
            exec( STATUS_CHECK_APP, $cmdOutput, $result );
            
            # If STATUS_CHECK_APP script returns zero then there are exactly
            # 3 entries (1-number of lanes, 2-lane 1 status, 3-lane 2 status,
            # otherwise the script failed.
            if ( ( $result == 0 ) && ( count( $cmdOutput ) == 3 ) )
            {
                $numLanes = $cmdOutput[ 0 ];
                $lanesStatus[1] = $cmdOutput[ 1 ];
                $lanesStatus[2] = $cmdOutput[ 2 ];
                
                for ( $lane = 1; $lane <= $numLanes; $lane++ )
                {
                    $det =  ( $lanesStatus[$lane] & MMI_STATUS_VEHICLE ) ? $yesText : $noText;
                    $page = ( $lanesStatus[$lane] & MMI_STATUS_PAGE )    ? $yesText : $noText;
                    $talk = ( $lanesStatus[$lane] & MMI_STATUS_TALK )    ? $yesText : $noText;
                    $list = ( $lanesStatus[$lane] & MMI_STATUS_LISTEN )  ? $yesText : $noText;
                    
                    $laneStatus["L{$lane}"] = array( 
                            "NAME"=>"{$laneText[$lane]}", 
                            "DET"=>"{$det}", 
                            "PAGE"=>"{$page}",
                            "TALK"=>"{$talk}", 
                            "LIS"=>"${list}" );
                }
            }
        }

        foreach ( $laneStatus as $laneStatusEntry )
        {
            $template->setCurrentBlock( "STA_LANE_ROW" );
            
            $template->setVariable( "DET_TEXT",  $labelArray["DET_TEXT"] );
            $template->setVariable( "PAGE_TEXT", $labelArray["PAGE_TEXT"] );
            $template->setVariable( "TALK_TEXT", $labelArray["TALK_TEXT"] );
            $template->setVariable( "LIS_TEXT",  $labelArray["LIS_TEXT"] );
            
            $template->setVariable( "LANE_NAME", $laneStatusEntry[ "NAME" ] );
            $template->setVariable( "DET_FLAG",  $laneStatusEntry[ "DET" ]  );
            $template->setVariable( "PAGE_FLAG", $laneStatusEntry[ "PAGE" ] );
            $template->setVariable( "TALK_FLAG", $laneStatusEntry[ "TALK" ] );
            $template->setVariable( "LIS_FLAG",  $laneStatusEntry[ "LIS" ]  );
            $template->parseCurrentBlock();
        }
        
        $template->setCurrentBlock( "STA_PAGE" );
        $template->setVariable( "UPTIME_HEADING", $labelArray["UPTIME_HEADING"] );
        
        /* UPTIME STATUS ENTRIES */
        $uptimeEntries = array( );        

        #if ( is_executable( UPTIME_CMD ) )
        {
            $cmdOutput = array();
            exec( UPTIME_CMD, $cmdOutput, $result );
            
            # If UPTIME_CMD script returns zero then there should be
            # at least one line of text and should contain the system
            # uptime, otherwise the script failed.
            if ( ( $result == 0 ) && ( count( $cmdOutput ) > 0 ) )
            {
                $uptimeEntries[] = $cmdOutput[ 0 ];
                
                # Ignore subsequent lines, we're interested in the
                # first line only
            }
        }

        foreach ( $uptimeEntries as $uptimeEntriesEntry )
        {
            $template->setCurrentBlock( "STA_UPTIME_ROW" );
            $template->setVariable( "UPTIME_ENTRY", $uptimeEntriesEntry );
            $template->setVariable( "ENTRY_NO", 0 );
            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "STA_PAGE" );
        $template->setVariable( "DIAG_MSGS_HEADING", $labelArray["DIAG_MSGS_HEADING"] );

        /* DIAGNOSTICS ENTRIES */
        $diagnostics = array ("1","2","3","4","5","6","7","8","9","10"); 
        
        if ( is_readable( DIAGNOSTICS_CHECK_SCRIPT ) )
        {
            $cmdOutput = array();
            exec( DIAGNOSTICS_CHECK_SCRIPT." ".MAX_DIAG_ENTRIES, $cmdOutput, $result );
            
            # If DIAGNOSTICS_CHECK_SCRIPT script returns zero then there are up to
            # MAX_DIAG_ENTRIES errors to display, otherwise the script failed.
            if ( $result == 0 )
            {
                $entriesRetrieved = count( $cmdOutput );
                if ( ( $entriesRetrieved > 0 ) && ($entriesRetrieved <= MAX_DIAG_ENTRIES ) )
                {
                    for ( $i = ($entriesRetrieved - 1 ); $i >= 0; --$i )
                    {
                        $diagnostics[ $i ] = $cmdOutput[ ($entriesRetrieved - 1) - $i ];
                    }
                }
            }
        }
        
        $entries = 0;
        foreach ( $diagnostics as $diagnosticEntry )
        {
            if ( $entries >= MAX_DIAG_ENTRIES )
            {
                break;
            }
            $template->setCurrentBlock( "STA_DIAG_ROW" );
            $template->setVariable( "DIAGNOSTIC_ENTRY", $diagnosticEntry );
            $template->setVariable( "ENTRY_NO", ++$entries );
            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "STA_PAGE" );
        $template->setVariable( "REFRESH_LABEL", $labelArray["REFRESH_LABEL"] );

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
