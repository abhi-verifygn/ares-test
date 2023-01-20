#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          ord.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the order takers form
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

    $writeTables = array( "OrderTaking"=>"OrderTaking" );
    $readTables = array( "LangOrderTaking"=>"LangOrderTaking",
                         "OrderTakingParams"=>"OrderTakingParams");

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "ord", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangOrderTaking"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "ord" ), true, true );

        $template->setCurrentBlock( "ORD_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );

        $params = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$writeTables["OrderTaking"]} order by ID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $params[$rowResult["ParamNameID"]] = array(
                    "Value" => $rowResult["ParamValueID"],
                    "Type" => $rowResult["DataEntryType"] );
            }
            mysqli_free_result( $queryResult );
        }
        foreach ( $params as $paramName => $param )
        {
            $sqlQuery = "";
            switch ( $param["Type"] )
            {
                case DATA_ENTRY_SELECT:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["OrderTakingParams"]}
                                where Name = '{$paramName}'
                                order by DisplayOrder;";
                    break;

                case DATA_ENTRY_YESNO_RADIO:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["OrderTakingParams"]}
                                where Name = 'GenericRadioYesNo'
                                order by DisplayOrder;";
                    break;
                case DATA_ENTRY_RADIO:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["OrderTakingParams"]}
                                where Name = '{$paramName}'
                                order by DisplayOrder;";
                    break;

                default:
                    break;
            }
            if ( !empty( $sqlQuery ) )
            {
                $options = array();
                if ( !($queryResult = @mysqli_query( $con, $sqlQuery ) ) )
                {
                    VenusShowError( $con );
                }
                else
                {
                    while ( $rowResult = mysqli_fetch_array( $queryResult ) )
                    {
                        $options[$rowResult["ValueName"]] = $rowResult["Value"];
                    }
                    mysqli_free_result( $queryResult );
                }
                $params[$paramName]["Options"] = $options;
            }
        }

        // Remove any OT modes from selector that are not currently enabled
        
        if ( isset( $params["SelectedMode"]["Options"] ) && is_array( $params["SelectedMode"]["Options"] ) )
        {
            foreach( $params["SelectedMode"]["Options"] as $key => $value )
            {
                if (     ( isset( $params["$key"] ) )
                     &&  ( isset( $params["$key"]["Value"] ) )
                     &&  ( $params["$key"]["Value"] == "RADIO_YES" ) )
                {
                    continue;
                }
                else
                {
                    // Remove this option - not available
                    unset( $params["SelectedMode"]["Options"]["$key"] );
                }
            } 
        }

        // Populate form
        
        $entries = 0;
        foreach ( $params as $paramName => $paramValue )
        {
            $template->setCurrentBlock( "FORM_ENTRY" );
            $template->setVariable( "PARAM_DISPLAY_NAME", $labelArray[ $paramName ]  );
            $template->setVariable( "PARAM_NAME", $paramName  );
            $template->setVariable( "ENTRY_NO", ++$entries );

            switch( $paramValue["Type"] )
            {
                case DATA_ENTRY_TEXT:
                    $template->setVariable( "PARAM_DISPLAY_VALUE", $paramValue["Value"] );
                    $template->setCurrentBlock( "FORM_TEXT" );
                    $template->setVariable( "TEXT_PARAM_NAME", $paramName  );
                    $template->setVariable( "TEXT_DISPLAY_VALUE", $paramValue["Value"]  );
                    $template->parseCurrentBlock();
                    break;
                case DATA_ENTRY_YESNO_RADIO:
                case DATA_ENTRY_RADIO:
                    $template->setVariable( "PARAM_DISPLAY_VALUE", $labelArray[ $paramValue["Value"]] );
                    if ( isset( $paramValue[ "Options" ] ) )
                    {
                        $numOptions = count( $paramValue[ "Options" ] );
                        $displayedOptions = 0;
                        foreach( $paramValue[ "Options" ] as $Name => $Value )
                        {
                            $template->setCurrentBlock( "FORM_RADIO" );
                            $template->setVariable( "RADIO_PARAM_NAME", $paramName );
                            $template->setVariable( "RADIO_VALUE", $Name );
                            $template->setVariable( "RADIO_VALUE_DISPLAY", $labelArray[$Name] );
                            if ($paramValue["Value"]== $Name )
                            {
                                $template->setVariable( "RADIO_CHECKED", "CHECKED" );
                            }
                            ++$displayedOptions;
                            if ( $displayedOptions < $numOptions )
                            {
                                // Seperator between radio buttons only
                                $template->touchBlock( "FORM_RADIO_SEPARATOR" );
                            }
                            $template->parseCurrentBlock();
                        }
                    }
                    break;

                case DATA_ENTRY_SELECT:
                    $template->setVariable( "PARAM_DISPLAY_VALUE", $labelArray[ $paramValue["Value"]] );
                    $template->setCurrentBlock( "FORM_SELECT" );
                    $template->setVariable( "SELECT_PARAM_NAME", $paramName );
                    $template->setVariable( "SELECT_HERE", $labelArray["SelectHere"] );

                    if ( isset( $paramValue[ "Options" ] ) )
                    {
                        foreach( $paramValue[ "Options" ] as $Name => $Value )
                        {
                            $template->setCurrentBlock( "FORM_OPTION_SELECT" );
                            $template->setVariable( "OPTION_ID", $Name );
                            $template->setVariable( "OPTION_DISPLAY_VALUE", $labelArray[$Name] );
                            $template->parseCurrentBlock();
                        }
                    }
                    break;
                default:
                    break;
            }
            $template->setCurrentBlock( "FORM_ENTRY" );
            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "ORD_FORM" );

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
