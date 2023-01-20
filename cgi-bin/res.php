#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          res.php - Venus web-site reboot support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the reboot form
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

    $con = VenusDBConnect();

    $writeTables = array( );
    $readTables = array( "LangRes"=>"LangRes");

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "res", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangRes"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "res" ), true, true );


        $template->setCurrentBlock( "RES_BODY" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );

        $template->setCurrentBlock( "RES_ACTIONS_FORM" );
        $template->setVariable( "LABEL_WARNING", $labelArray["LabelWarning"] );
        $template->setVariable( "LABEL_REBOOT", $labelArray["LabelReboot"] );
        $template->setVariable( "EXECUTE_ENTRY", $labelArray["ExecuteButton"] );
        $template->setVariable( "RADIO_REBOOT", $labelArray["RADIO_REBOOT"] );

        $executeEntry = "Not permitted";
        if ( $updateable == True )
        {
            $executeEntry ='<input id="submitFormButton" type="submit" value="'
                . $labelArray[ "ExecuteButton" ]
                . '" onclick="this.disabled=true;this.value=\'Executing...\';this.form.submit();">';
        }
        $template->setVariable( "EXECUTE_ENTRY", $executeEntry );

        $template->setVariable( "RES_ACTIONS_HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "RES_ACTIONS_HIDDEN_SESSION", session_id() );

        $template->parseCurrentBlock();

        // Finish off with the generic content

        $template->setCurrentBlock( "RES_BODY" );

        $template->setVariable( "ERROR_ID", AJAX_ERROR );
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
