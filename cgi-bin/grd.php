#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          grd.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the greeter day parts definition form
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

    $writeTables = array(  );
    $readTables = array( "GRD"=>"GRD",
                         "LangGRD"=>"LangGRD");

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "grd", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangGRD"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "grd" ), true, true );

        $template->setCurrentBlock( "GRD_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );
        $template->setVariable( "DAY_PART_NAME", $labelArray["DayPartName"] );
        $template->setVariable( "START_TIME", $labelArray["StartTime"] );
        $template->setVariable( "END_TIME", $labelArray["EndTime"] );
        
        $formData = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$readTables["GRD"]} order by ID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $formData[$rowResult["ID"]] = array(
                    "Name" => $rowResult["Name"],
                    "StartTime" => $rowResult["StartTime"],
                    "EndTime" => $rowResult["EndTime"] );
            }
        }
        
        $entries = 0;
        $rows = 0;
        foreach ( $formData as $ID => $dayPart )
        {
            $template->setCurrentBlock( "GRD_ENTRY" );

            $template->setVariable( "ROW_NO", ++$rows );
            $template->setVariable( "ROW_DAY_PART_ID", $ID );
            
            $template->setVariable( "ROW_DAY_PART_NAME", $dayPart["Name"] );
            $template->setVariable( "ROW_DAY_PART_START_TIME", $dayPart["StartTime"] );
            $template->setVariable( "ROW_DAY_PART_END_TIME", $dayPart["EndTime"] );

            $template->setVariable( "ENTRY_A", ++$entries );
            $template->setVariable( "ENTRY_B", ++$entries );
            $template->setVariable( "ENTRY_C", ++$entries );

            $template->parseCurrentBlock();
        }
        
        $template->setCurrentBlock( "GRD_FORM" );

        $template->setVariable( "ERROR_ID", AJAX_ERROR );
        $template->setVariable( "SESSION_ERROR_MESSAGE", $_SESSION[ SESS_ERROR ] );

        $submitEntry = "Not permitted";
        if ( $updateable == True )
        {
            $submitEntry ='<input id="submitFormButton" type="submit" value="'
                . $labelArray[ "ApplyChanges" ].'">';
        }
        $template->setVariable( "SUBMIT_ENTRY", $submitEntry );

        $template->setVariable( "HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "HIDDEN_SESSION", session_id() );

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
