#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          tme.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the opening, etc, times form.
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
    $table = "WorkingHours";
    $langTable = "LangWorkingHours";
    $updateTable = "UpdateManagement";

    $disableSubmit = True;

    if (!mysqli_query( $con,
            "LOCK TABLE {$table} WRITE, {$updateTable} WRITE, {$langTable} READ;" ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "tme", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con, $langTable, $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "tme" ), true, true );

        $template->setCurrentBlock( "TME_FORM" );
        $template->setVariable( "TITLE", $labelArray["WorkingHours"] );
        $template->setVariable( "DAY_OF_WEEK", $labelArray["DayOfWeek"] );
        $template->setVariable( "OPEN_TIME", $labelArray["OpenTime"] );
        $template->setVariable( "DAY_TIME", $labelArray["DayTime"] );
        $template->setVariable( "NIGHT_TIME", $labelArray["NightTime"] );
        $template->setVariable( "CLOSE_TIME", $labelArray["CloseTime"] );

        // Pull in the keys representing the days-of-the-week
        if ( !$result = @mysqli_query( $con, "SELECT DayNameID from {$table} order by DayNo;" ) )
        {
            $_SESSION[ SESS_ERROR ]
                = "Unable to update due to an internal database issue - day name query.";
        }
        else
        {
            $daysOfWeek = array();
            while ( ($row = @mysqli_fetch_array( $result, MYSQLI_ASSOC ) ) != null )
            {
                if ( !isset( $row[ "DayNameID" ] ) )
                {
                    continue;
                }
                $daysOfWeek[] = $row[ "DayNameID" ];
            }
            mysqli_free_result( $result );
        }

        // Either re-display previously entered data, or pull fresh data from
        // database (previously entered data is used when an data entry error
        // was detected
        $formData = array();
        $sess_prev_data = VenusGetSessPrevDataName( "tme" );

        if ( isset( $_SESSION[ $sess_prev_data ] )
            && !empty( $_SESSION[ $sess_prev_data ] ) )
        {
            $formData = $_SESSION[ $sess_prev_data ];
        }
        else
        {
            if ( !($queryResult = @mysqli_query( $con,
                        "select DayNameID,
                            OpenTimeValue,
                            DayTimeValue,
                            NightTimeValue,
                            CloseTimeValue
                        from {$table};" ) ) )
            {
                VenusShowError( $con );
            }
            else
            {
                while ( $rowResult = mysqli_fetch_array( $queryResult ) )
                {
                    $formData[$rowResult["DayNameID"]] = $rowResult;
                }
                mysqli_free_result( $queryResult );
            }
        }
        $entryCount = 0;
        foreach ( $daysOfWeek as $day )
        {
            $dayNameID = $day;
            $template->setCurrentBlock( "TME_ROW" );
            $template->setVariable( "DAY_NAME_ID", $dayNameID ) ;
            $template->setVariable( "DAY_NAME", $labelArray[ $dayNameID ] ) ;
            $template->setVariable( "OPEN_TIME_VALUE", $formData[$day][ "OpenTimeValue" ] );
            $template->setVariable( "DAY_TIME_VALUE", $formData[$day][ "DayTimeValue" ] );
            $template->setVariable( "NIGHT_TIME_VALUE", $formData[$day][ "NightTimeValue" ] );
            $template->setVariable( "CLOSE_TIME_VALUE", $formData[$day][ "CloseTimeValue" ] );
            $template->setVariable( "ENTRY_A", strval( ++$entryCount ) );
            $template->setVariable( "ENTRY_B", strval( ++$entryCount ) );
            $template->setVariable( "ENTRY_C", strval( ++$entryCount ) );
            $template->setVariable( "ENTRY_D", strval( ++$entryCount ) );
            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "TME_FORM" );

        $template->setVariable( "ERROR_ID", AJAX_ERROR );
        if ( isset( $_SESSION[ SESS_ERROR ] ) )
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
