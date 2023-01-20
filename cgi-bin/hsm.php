#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          hsm.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the headset hardware page.
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

    $writeTables = array();
    $readTables = array( "Headsets"=>"Headsets", "LangHeadsets"=>"LangHeadsets");

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "hsm", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangHeadsets"], $_SESSION[ SESS_LANGUAGE ] );

        // Pull in the headset data entries
        $formData = array();

        if ( !($queryResult = @mysqli_query( $con,
                    "select ID,
                        SerialNumber,
                        Name,
                        SoftwareVersion,
                        InactiveDays
                    from {$readTables["Headsets"]} order by ID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $formData[$rowResult["ID"]] = $rowResult;
            }
            mysqli_free_result( $queryResult );

            $formData = stripslashes_deep($formData);
        }

        if ( !($queryBOResult = @mysqli_query( $con,
                    "select Value
                    from ".UPDATE_MGT_TABLE
                    ." where Name = '".UPDATEMGT_BaseOpen."';" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            if ( ($rowBOResult = mysqli_fetch_array( $queryBOResult )) != null )
            {
                $baseOpen = ( $rowBOResult["Value"] == "OPENED" );
            }
            else
            {
                VenusShowError( $con );
            }
            mysqli_free_result( $queryBOResult );
        }


        // Start rendering the page
        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "hsm" ), true, true );

        $template->setCurrentBlock( "HSM_BODY" );
        $template->setVariable( "BDY_TIMENOW", $timeNow );
        $template->setVariable( "BDY_SESSION", session_id() );
        $template->parseCurrentBlock();

        $template->setCurrentBlock( "HSM_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );
        $template->setVariable( "APPLY_CHANGES", $labelArray["ApplyChanges"] );
        $template->setVariable( "SERIAL_NUMBER", $labelArray["SerialNumber"] );
        $template->setVariable( "NAME", $labelArray["Name"] );
        $template->setVariable( "SOFTWARE_VERSION", $labelArray["SoftwareVersion"] );
        $template->setVariable( "INACTIVE_DAYS", $labelArray["InactiveDays"] );
        $template->setVariable( "CLEAR", $labelArray["Clear"] );


        // Render the headset data
        foreach ( $formData as $headset )
        {
            $template->setCurrentBlock( "HSM_ROW" );
            $template->setVariable( "ID", $headset["ID"] ) ;
            $template->setVariable( "HEADSET_SERIAL", $headset[ "SerialNumber" ] );
            $template->setVariable( "HEADSET_NAME", $headset[ "Name" ] );
            $template->setVariable( "HEADSET_SW_VERSION", $headset[ "SoftwareVersion" ] );
            $template->setVariable( "HEADSET_DAYS_INACTIVE", $headset[ "InactiveDays" ] );

            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "HSM_FORM" );

        $template->setVariable( "HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "HIDDEN_SESSION", session_id() );

        // Render base state
        $template->setVariable( "BASE_STATUS_LABEL", $labelArray["BaseStatusLabel"] );
        $template->setVariable( "BASE_STATUS_CAPTION", $labelArray["BaseStatusCaption"] );
        if ( $baseOpen == "true" )
        {
            $template->setVariable( "BASE_IS_OPEN", $labelArray["BaseStationOpen"] );
        }
        else
        {
            $template->setVariable( "BASE_IS_OPEN", $labelArray["BaseStationClosed"] );
        }

        // Render the deregistration selector
        $template->setVariable( "DEREGISTER_HANDSET", $labelArray["DeRegisterHandsetLabel"] );
        $template->setVariable( "SELECT_HANDSET", $labelArray["SelectHandset"] );

        foreach ( $formData as $headset )
        {
            $template->setCurrentBlock( "HSM_OPTION" );
            $template->setVariable( "DEREGISTER_ID", $headset["ID"] ) ;

            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "HSM_FORM" );

        $template->setVariable( "ERROR_ID", AJAX_ERROR );
        if ( isset( $_SESSION[ SESS_ERROR ] ))
        {
            $template->setVariable( "SESSION_ERROR_MESSAGE", $_SESSION[ SESS_ERROR ] );
        }

        $submitEntry = "Not permitted";
        if ( $updateable == True )
        {
            $submitEntry =
                '<input id="submitFormButton" type="submit" value="'
                    . $labelArray[ "ApplyChanges" ]
                    .'" onclick="show_popup(\'loading_popup\')">';
        }
        $template->setVariable( "SUBMIT_ENTRY", $submitEntry );


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
