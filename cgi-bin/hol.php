#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          hol.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents holiday and exceptions form.
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
    $table = "Holidays";
    $langTable = "LangHolidays";
    $updateTable = "UpdateManagement";

    $disableSubmit = True;

    if (!mysqli_query( $con,
            "LOCK TABLE {$table} WRITE, {$updateTable} WRITE, {$langTable} READ;" ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "hol", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con, $langTable, $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "hol" ), true, true );

        $template->setCurrentBlock( "HOL_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );
        $template->setVariable( "DATE_NAME", $labelArray["DateName"] );
        $template->setVariable( "OPEN_NAME", $labelArray["OpenName"] );
        $template->setVariable( "CLOSE_NAME", $labelArray["CloseName"] );

        // Either re-display previously entered data, or pull fresh data from
        // database (previously entered data is used when an data entry error
        // was detected
        $formData = array();
        $sess_prev_data = VenusGetSessPrevDataName( "hol" );

        if ( isset( $_SESSION[ $sess_prev_data ] ) &&
            !empty( $_SESSION[ $sess_prev_data ] ) )
        {
            $formData = $_SESSION[ $sess_prev_data ];
        }
        else
        {
            if ( !($queryResult = @mysqli_query( $con,
                        "select HolDayID,
                            DayValue,
                            OpenTimeValue,
                            CloseTimeValue
                        from {$table} order by HolDayID;" ) ) )
            {
                VenusShowError( $con );
            }
            else
            {
                while ( $rowResult = mysqli_fetch_array( $queryResult ) )
                {
                    $formData[$rowResult["HolDayID"]] = $rowResult;
                }
                mysqli_free_result( $queryResult );
            }
        }

        $entries = 0;

        foreach ( $formData as $holiday )
        {
            $template->setCurrentBlock( "HOL_ROW" );
            $template->setVariable( "HOL_DAY_ID", $holiday["HolDayID"] ) ;
            $template->setVariable( "DAY_VALUE", $holiday[ "DayValue" ] );
            $template->setVariable( "OPEN_TIME_VALUE", $holiday[ "OpenTimeValue" ] );
            $template->setVariable( "CLOSE_TIME_VALUE", $holiday[ "CloseTimeValue" ] );
            $template->setVariable( "ENTRY_A", ++$entries );
            $template->setVariable( "ENTRY_B", ++$entries );
            $template->setVariable( "ENTRY_C", ++$entries );

            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "HOL_FORM" );

        $template->setVariable( "ERROR_ID", AJAX_ERROR );
        if ( isset( $_SESSION[ SESS_ERROR ] ))
        {
            $template->setVariable( "SESSION_ERROR_MESSAGE", $_SESSION[ SESS_ERROR ] );
        }

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
