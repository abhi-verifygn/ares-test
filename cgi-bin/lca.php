#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          lca.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the site location information form.
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

    $timeNow = time();

    VenusSessionAuthenticate();

    $con = VenusDBConnect();
    $table = "LocationDetails";
    $updateTable = "UpdateManagement";

    $disableSubmit = True;

    if (!mysqli_query( $con, "LOCK TABLE {$table} WRITE, {$updateTable} WRITE;" ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "lca", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "lca" ), true, true );

        $template->setCurrentBlock( "LCA_FORM" );
        $template->setVariable( "TITLE", "Site Information" );

        if ( !($queryResult = @mysqli_query( $con, "select * from {$table};" ) ) )
        {
            VenusShowError( $con );
        }
        $rowNo = 0;
        while ( $rowResult = mysqli_fetch_array( $queryResult ) )
        {
            $ID = $rowResult[ "ID" ];

            // Session and Timestamp ID's are not displayed
            if ( ( $ID === SESSION_ID ) || ( $ID === TIMESTAMP_ID ) )
            {
                continue;
            }

            $rowResult = stripslashes_deep($rowResult);              // Get rid of any \ quoted characters

            $rowNo++;
            $template->setCurrentBlock( "LCA_ROW" );
            $template->setVariable( "PARAM_NAME", $rowResult["Name"] );
            $template->setVariable( "PARAM_CURRENT_VALUE", $rowResult["Value"] );
            $template->setVariable( "ROW_NO", "{$rowNo}." );
            $template->setVariable( "PARAM_VALUE_MAX_LENGTH",$rowResult["Length"] );
            $template->setVariable( "PARAM_ID", $ID );
            $template->setVariable( "PARAM_UPDATED_VALUE", $rowResult["Value"] );
            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "LCA_FORM" );

        $template->setVariable( "ERROR_ID", AJAX_ERROR );
        if ( isset($_SESSION[ SESS_ERROR ]) )
        {
            $template->setVariable( "SESSION_ERROR_MESSAGE", $_SESSION[ SESS_ERROR ] );
        }

        $submitEntry = "Not permitted";
        if ( $updateable == True )
        {
            $submitEntry = '<input id="submitFormButton" type="submit" value="Apply Changes">';
        }
        $template->setVariable( "SUBMIT_ENTRY", $submitEntry );

        $template->setVariable( "HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "HIDDEN_SESSION", session_id() );

        $template->parseCurrentBlock();
        $template->show( );

        mysqli_free_result( $queryResult );

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
