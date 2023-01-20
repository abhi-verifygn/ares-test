#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          ins.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the installer options form
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
    $readTables = array( "InstallerOptions"=>"InstallerOptions",
                         "InstallerOptionsParams"=>"InstallerOptionsParams",
                         "LangInstallerOptions"=>"LangInstallerOptions");

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "ins", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangInstallerOptions"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "ins" ), true, true );


        $template->setCurrentBlock( "INS_BODY" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );

        $template->setCurrentBlock( "INS_ACTIONS_FORM" );
        $template->setVariable( "LABEL_WARNING", $labelArray["LabelWarning"] );
        $template->setVariable( "LABEL_RESET", $labelArray["LabelFactoryReset"] );
        $template->setVariable( "LABEL_LOAD", $labelArray["LabelLoadSettings"] );
        $template->setVariable( "LABEL_SAVE", $labelArray["LabelSaveSettings"] );
        $template->setVariable( "EXECUTE_ENTRY", $labelArray["ExecuteButton"] );
        $template->setVariable( "RADIO_FACTORY", $labelArray["RADIO_FACTORY"] );
        $template->setVariable( "RADIO_LOAD", $labelArray["RADIO_LOAD"] );
        $template->setVariable( "RADIO_SAVE", $labelArray["RADIO_SAVE"] );

        // Force that the preselected action is to save the configuration
        switch ( 3 )
        {
            case 1:
                $template->setVariable( "RESET_CHECKED", "CHECKED" );
                break;
            case 2:
                $template->setVariable( "LOAD_CHECKED", "CHECKED" );
                break;
            case 3:
            default:
                $template->setVariable( "SAVE_CHECKED", "CHECKED" );
                break;
        }

        $executeEntry = "Not permitted";
        if ( $updateable == True )
        {
            $executeEntry ='<input id="submitFormButton" type="submit" value="'
                . $labelArray[ "ExecuteButton" ]
                . '" onclick="this.disabled=true;this.value=\'Executing...\';this.form.submit();">';
        }
        $template->setVariable( "EXECUTE_ENTRY", $executeEntry );

        $template->setVariable( "INS_ACTIONS_HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "INS_ACTIONS_HIDDEN_SESSION", session_id() );

        $template->parseCurrentBlock();

        // Now renderer the second form on this page

        $template->setCurrentBlock( "INS_SETTINGS_FORM" );
        $params = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$readTables["InstallerOptions"]} order by ID;" ) ) )
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
                                from {$readTables["InstallerOptionsParams"]}
                                where Name = '{$paramName}'
                                order by DisplayOrder;";
                    break;

                case DATA_ENTRY_YESNO_RADIO:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["InstallerOptionsParams"]}
                                where Name = 'GenericRadioYesNo'
                                order by DisplayOrder;";
                    break;
                case DATA_ENTRY_RADIO:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["InstallerOptionsParams"]}
                                where Name = '{$paramName}'
                                order by DisplayOrder;";
                    break;
                case DATA_ENTRY_TEXT:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["InstallerOptionsParams"]}
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

        $entries = 0;
        foreach ( $params as $paramName => $paramValue )
        {
            $template->setCurrentBlock( "INS_SETTINGS_ENTRY" );
            $template->setVariable( "PARAM_DISPLAY_NAME", $labelArray[ $paramName ]  );
            $template->setVariable( "PARAM_NAME", $paramName  );
            $template->setVariable( "ENTRY_NO", ++$entries );

            switch( $paramValue["Type"] )
            {
                case DATA_ENTRY_TEXT:
                    $template->setVariable( "PARAM_DISPLAY_VALUE", $paramValue["Value"] );
                    $template->setCurrentBlock( "INS_SETTINGS_TEXT" );
                    $template->setVariable( "TEXT_PARAM_NAME", $paramName  );
                    $template->setVariable( "TEXT_DISPLAY_VALUE", $paramValue["Value"]  );
                    
                    if ( isset( $paramValue[ "Options" ] ) )
                    {
                        if ( isset( $paramValue[ "Options" ][DATA_ENTRY_MAX_LENGTH] ) )
                        {
                            $template->setVariable( "TEXT_DISPLAY_LENGTH", $paramValue[ "Options" ][DATA_ENTRY_MAX_LENGTH] );
                        }
                    }
                    
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
                            $template->setCurrentBlock( "INS_SETTINGS_RADIO" );
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
                                $template->touchBlock( "INS_SETTINGS_RADIO_SEPARATOR" );
                            }
                            $template->parseCurrentBlock();
                        }
                    }
                    break;

                case DATA_ENTRY_SELECT:
                    $template->setVariable( "PARAM_DISPLAY_VALUE", $labelArray[ $paramValue["Value"]] );
                    $template->setCurrentBlock( "INS_SETTINGS_SELECT" );
                    $template->setVariable( "SELECT_PARAM_NAME", $paramName );
                    $template->setVariable( "SELECT_HERE", $labelArray["SelectHere"] );

                    if ( isset( $paramValue[ "Options" ] ) )
                    {
                        foreach( $paramValue[ "Options" ] as $Name => $Value )
                        {
                            $template->setCurrentBlock( "INS_SETTINGS_OPTION_SELECT" );
                            $template->setVariable( "OPTION_ID", $Name );
                            $template->setVariable( "OPTION_DISPLAY_VALUE", $labelArray[$Name] );
                            $template->parseCurrentBlock();
                        }
                    }
                    break;
                default:
                    break;
            }
            $template->setCurrentBlock( "INS_SETTINGS_ENTRY" );
            $template->parseCurrentBlock();
        }
        $template->setCurrentBlock( "INS_SETTINGS_FORM" );

        $submitEntry = "Not permitted";
        if ( $updateable == True )
        {
            $submitEntry ='<input id="submitFormButton" type="submit" value="'
                . $labelArray[ "ApplyChanges" ].'">';
        }
        $template->setVariable( "SUBMIT_ENTRY", $submitEntry );

        $template->setVariable( "INS_SETTINGS_HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "INS_SETTINGS_HIDDEN_SESSION", session_id() );

        $template->parseCurrentBlock();

        // Finish off with the generic content

        $template->setCurrentBlock( "INS_BODY" );

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
