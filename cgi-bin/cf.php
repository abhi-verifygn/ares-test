#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          cf.php - Venus web-site configuration file support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the configuration load/save and upgrade form
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
        die( "Unable to start session. Serious. Terminating script processing");
    }

    $timeNow = time();

    VenusSessionAuthenticate();

	if (VenusInstallerAccess() == false) /* Check for installer access */
    {
		/* Not allowed to access this page - redirect to the Installer-only warning page */
        header(
            "location: ino.php",
            true, // replace any existing location header
            303   // HTTP "303 see other" response code
            );
	}

    $con = VenusDBConnect();

    $writeTables = array( );
    $readTables = array(  "LangCf"=>"LangCf");

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "cf", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangCf"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "cf" ), true, true );


        $template->setCurrentBlock( "CF_BODY" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );

        // Now render the send config form on this page
        
        $template->setCurrentBlock( "CF_SEND_FORM" );
        $template->setVariable( "LabelSendConfig", $labelArray["LabelSendConfig"] );
        $template->setVariable( "LabelSelectFile", $labelArray["LabelSelectFile"] );
        $template->setVariable( "DBUploadKey", UPLOAD_DB_KEY );

        // Determine available disk space in tmp file system used for upload, reserving some space
        // for internal system use
        $freeSpaceInBytes = disk_free_space( CONFIG_LOCAL_ROOT );
        $freeSpaceInBytes = max(  ( intval( $freeSpaceInBytes ) - UPLOAD_DB_REQUIRED_SPACE ), 0 ); 
        
        // Aim to restrict max upload size (same as size of available unreserved space)
        $template->setVariable( "CF_DB_UPLOAD_MAX_FILESIZE", $freeSpaceInBytes );

        $sendConfigSubmit = "Not permitted";
        if ( $updateable == True )
        {
            $sendConfigSubmit ='<input type="submit" onclick="show_popup(\"loading_popup\")" value="'
               . $labelArray[ "SendFileButton" ].'" >';
        }
        $template->setVariable( "SendConfigSubmit", $sendConfigSubmit );

        $template->setVariable( "CF_SEND_CF_HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "CF_SEND_CF_HIDDEN_SESSION", session_id() );

        $template->parseCurrentBlock();

        // Now render the receive config form on this page

        $template->setCurrentBlock( "CF_RECEIVE_FORM" );
        $template->setVariable( "LabelReceiveConfig", $labelArray["LabelReceiveConfig"] );
        $template->setVariable( "LabelObtainCurrentSetup", $labelArray["LabelObtainCurrentSetup"] );

        $receiveConfigSubmit = "Not permitted";
        if ( $updateable == True )
        {
            $receiveConfigSubmit ='<input type="submit" value="'
                . $labelArray[ "ReceiveFileButton" ].'"  >';
        }
        $template->setVariable( "ReceiveConfigSubmit", $receiveConfigSubmit );

        $template->setVariable( "CF_RECEIVE_CF_HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "CF_RECEIVE_CF_HIDDEN_SESSION", session_id() );

        $template->parseCurrentBlock();

        // Now render the upgrade form on this page

        $template->setCurrentBlock( "TB_UPGRADE_FORM" );
        $template->setVariable( "LabelTBUpgrade", $labelArray["LabelTBUpgrade"] );
        $template->setVariable( "LabelTBFile", $labelArray["LabelTBFile"] );
        $template->setVariable( "TBUpgradeKey", UPGRADE_TB_KEY );

        // Determine available disk space in tmp file system used for uploads, reserving some space
        // for internal system use
        $freeSpaceInBytes = disk_free_space( UPGRADE_TB_UPLOAD_STAGEDIR );
        $freeSpaceInBytes = max(  ( intval( $freeSpaceInBytes ) - UPGRADE_TB_RESERVED_SPACE ), 0 ); 
        
        // Aim to restrict max upload size (same as size of available unreserved space)
        $template->setVariable( "CF_TB_UPGRADE_MAX_FILESIZE", $freeSpaceInBytes );
        $availableStorage = $labelArray["LabelTBFreeSpace"] .  " " . number_format( $freeSpaceInBytes );

        $template->setVariable( "CF_TB_UPGRADE_FREE_SPACE", $availableStorage );

        $sendTBUpgradeSubmit = "Not permitted";
        if ( $updateable == True )
        {
            // Determine whether the system is currently updating
            system( "ps | grep tar | grep -v grep > /dev/null 2>/dev/null", $returnValueExtracting );
            system( "ps | grep install | grep -v grep > /dev/null 2>/dev/null", $returnValueInstalling );
            
            if ( ( $returnValueExtracting == 1 ) && ( $returnValueInstalling == 1 ) )
            {
                // Not currently updating - perform update
                $sendTBUpgradeSubmit ='<input type="submit" onclick="this.disabled=true;this.value=\'Please wait...\';this.form.submit();" value="'
                   . $labelArray[ "UpgradeFileButton" ].'">';
            }
            else
            {
                // Prevent starting update when already updating
                $sendTBUpgradeSubmit = $labelArray[ "UpgradeInProgress" ];
            }
        }
        $template->setVariable( "TBUpgradeSubmit", $sendTBUpgradeSubmit );

        $template->setVariable( "CF_TB_UPGRADE_HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "CF_TB_UPGRADE_HIDDEN_SESSION", session_id() );


        $template->parseCurrentBlock();

        // Finish off with the generic content

        $template->setCurrentBlock( "CF_BODY" );

        $template->setVariable( "SESSION_ERROR_MESSAGE", $_SESSION[ SESS_ERROR ] );

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
