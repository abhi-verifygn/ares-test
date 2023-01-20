#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          ltm.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the clock and lane settings form
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "HTML/Template/ITX.php";
    require_once "venus_helper.php";


    /******************************************************************************
    ** Function:    ltm_getTimezones
    ** Parameters:      connection [in] is the database handle
    **                  ltmParamsTable [in] the parameter helper values of page
    **                  ltmLangTable [in] the localisable language table
    **                  language [in] the currently selected language
    ** Returns:         all the timezones defined in the params table along with
    **                  associated timezone labels
    **
    ** Retrieves all the time zones defined in the params table with the
    ** associated display names and its time Venus zone value.
    */
    function ltm_getTimezones( $connection, $ltmParamsTable, $ltmLangTable, $language  )
    {
        $timeZones = array();

        if ( $queryResult = @mysqli_query( $connection,
            "SELECT {$ltmParamsTable}.ValueName,
                {$ltmParamsTable}.DisplayOrder,
                {$ltmParamsTable}.Value,
                {$ltmLangTable}.text
             FROM {$ltmParamsTable}
             INNER JOIN {$ltmLangTable}
             ON {$ltmParamsTable}.ValueName = {$ltmLangTable}.textID
             WHERE {$ltmParamsTable}.Name = 'TimeZone'
                and {$ltmLangTable}.language = '{$language}'
             ORDER BY {$ltmParamsTable}.DisplayOrder;" ) )
        {
            while ( ($timeZoneRow = mysqli_fetch_array( $queryResult )) != null )
            {
                $timeZones[ $timeZoneRow["Value" ] ] = array(
                    "venusTZ" => $timeZoneRow["ValueName"],
                    "displayName" => $timeZoneRow["text" ],
                    "displayOrder" => $timeZoneRow["DisplayOrder" ]
                );
            }

            mysqli_free_result( $queryResult );
        }
        else
        {
            VenusShowError( $connection );
        }

        return $timeZones;
    }

    /******************************************************************************
    ** Function:    ltm_readSOTMValue
    ** Parameters:      connection [in] is the database handle
    **                  orderTakingTable [in] the order taking page database
    **                  langOrderTakingTable [in] the localisable language table
    **                  language [in] the currently selected language
    **                  sotm [in/out] the order taker currently selected mode
    ** Returns:         nothing
    **
    */
    function ltm_readSOTMValue( $connection, $orderTakingTable, $langOrderTakingTable, $language, &$sotm )
    {
        $sotm = array();
        if ( $queryResult = @mysqli_query( $connection,
                "SELECT {$langOrderTakingTable}.text
                 FROM {$orderTakingTable}
                 INNER JOIN {$langOrderTakingTable}
                 ON {$orderTakingTable}.ParamValueID = {$langOrderTakingTable}.textID
                 WHERE {$orderTakingTable}.ParamNameID = 'SelectedMode'
                    AND {$langOrderTakingTable}.language = '{$language}';" ) )
        {
            if ( ($sotmSetting = mysqli_fetch_array( $queryResult )) != null )
            {
                $sotm[ "setting" ] = $sotmSetting[ "text" ];

                if ( $queryResult = @mysqli_query( $connection,
                    "SELECT text
                    FROM {$langOrderTakingTable}
                    where {$langOrderTakingTable}.TextID = 'SelectedMode'
                    AND {$langOrderTakingTable}.language = '{$language}';" ))
                {
                    if ( ($sotmPrompt = mysqli_fetch_array( $queryResult )) != null )
                    {
                        $sotm[ "prompt" ] = $sotmPrompt[ "text" ];
                    }
                    else
                    {
                        VenusShowError( $connection );
                    }
                }
            }
            else
            {
                VenusShowError( $connection );
            }
            mysqli_free_result( $queryResult );
        }
        else
        {
            VenusShowError( $connection );
        }
    }

    /******************************************************************************
    ** Function:    ltm_readNLASValue
    ** Parameters:      connection [in] is the database handle
    **                  installerOptionsTable [in] the installer options page database
    **                  langInstallerOptionsTable [in] the localisable language table
    **                  language [in] the currently selected language
    **                  nlas [in/out] the number of sites related entry
    ** Returns:         nothing
    **
    */
    function ltm_readNLASValue( $connection, $installerOptionsTable, $langInstallerOptionsTable, $language, &$nlas )
    {
        $nlas = array();
        if ( $queryResult = @mysqli_query( $connection,
                "SELECT {$langInstallerOptionsTable}.text
                 FROM {$installerOptionsTable}
                 INNER JOIN {$langInstallerOptionsTable}
                 ON {$installerOptionsTable}.ParamValueID = {$langInstallerOptionsTable}.textID
                 WHERE {$installerOptionsTable}.ParamNameID = 'NumberOfBaseStations'
                    AND {$langInstallerOptionsTable}.language = '{$language}';" ) )
                    
        {
            if ( ($nlasSetting = mysqli_fetch_array( $queryResult )) != null )
            {
                $nlas[ "setting" ] = $nlasSetting[ "text" ];

                if ( $queryResult = @mysqli_query( $connection,
                    "SELECT text
                    FROM {$langInstallerOptionsTable}
                    where {$langInstallerOptionsTable}.TextID = 'NumberOfBaseStations'
                    AND {$langInstallerOptionsTable}.language = '{$language}';" ))
                {
                    if ( ($nlasPrompt = mysqli_fetch_array( $queryResult )) != null )
                    {
                        $nlas[ "prompt" ] = $nlasPrompt[ "text" ];
                    }
                    else
                    {
                        VenusShowError( $connection );
                    }
                }
            }
            else
            {
                VenusShowError( $connection );
            }
            mysqli_free_result( $queryResult );
        }
        else
        {
            VenusShowError( $connection );
        }
    }
    
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

    $writeTables = array( "LTM"=>"LTM" );
    $readTables = array( "LangLTM"=>"LangLTM",
                         "LTMParams"=>"LTMParams",
                         "OrderTaking"=>"OrderTaking",
                         "LangOrderTaking"=>"LangOrderTaking",
                         "InstallerOptions"=>"InstallerOptions",
                         "LangInstallerOptions"=>"LangInstallerOptions" );

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        $currentTimeZone = VenusGetTimeZoneFromDB( $con );

        if (VenusIsUpdatableCheck( $con, "ltm", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangLTM"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "ltm" ), true, true );

        $template->setCurrentBlock( "LTM_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );


        $params = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$writeTables["LTM"]} order by ID;" ) ) )
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
                                from {$readTables["LTMParams"]}
                                where Name = '{$paramName}'
                                order by DisplayOrder;";
                    break;

                case DATA_ENTRY_YESNO_RADIO:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["LTMParams"]}
                                where Name = 'GenericRadioYesNo'
                                order by DisplayOrder;";
                    break;
                case DATA_ENTRY_RADIO:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["LTMParams"]}
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

        // Timezone retrieval
        $timezones = ltm_getTimezones( $con,
            $readTables["LTMParams"],
            $readTables["LangLTM"],
            $_SESSION[ SESS_LANGUAGE ]  );

        $entries = 0;

        // Date/Time and Timezone
        $sysDate = date( "Y/m/d" );
        $sysTime = date( "H:i:s" );
        $template->setCurrentBlock( "DATE_TIME_SETTINGS" );
        $template->setVariable( "DATE_DISPLAY_NAME", $labelArray[ "LocalDate" ]  );
        $template->setVariable( "DATE_DISPLAY_VALUE", $sysDate );
        $template->setVariable( "ENTRY_NO_DATE", ++$entries );

        $template->setVariable( "TIME_DISPLAY_NAME", $labelArray[ "LocalTime" ]  );
        $template->setVariable( "TIME_DISPLAY_VALUE", $sysTime  );
        $template->setVariable( "ENTRY_NO_TIME", ++$entries );

        $template->setVariable( "TZ_DISPLAY_NAME", $labelArray[ "TimeZone" ]  );
        $template->setVariable( "TZ_DISPLAY_VALUE", $labelArray[ $timezones[$currentTimeZone]["venusTZ"] ] );
        $template->setVariable( "ENTRY_NO_TZ", ++$entries );

        $template->setCurrentBlock( "TZ_SELECT" );
        $template->setVariable( "TZ_SELECT_HERE", $labelArray["SelectHere"] );
        $template->setVariable( "IGNORE_SELECTION", IGNORE_SELECTION );

        foreach( $timezones as $timeZone => $timezoneEntry )
        {
            $template->setCurrentBlock( "TZ_ENTRY" );
            $template->setVariable( "TZ_VENUS_ID", $timeZone );
            $template->setVariable( "TZ_ENTRY_DISPLAY_VALUE", $timezoneEntry["displayName"] );
            $template->parseCurrentBlock();
        }
        $template->parseCurrentBlock();

        // Show the currently selected order taking mode (SOTM)
        $template->setCurrentBlock( "SOTM_READONLY" );
        ltm_readSOTMValue(
                $con,
                $readTables[ "OrderTaking"],
                $readTables[ "LangOrderTaking" ],
                $_SESSION[ SESS_LANGUAGE ],
                $sotm );
        $template->setVariable( "SOTM_DISPLAY_NAME", $sotm["prompt"]  );
        $template->setVariable( "SOTM_DISPLAY_VALUE", $sotm["setting"] );
        $template->setVariable( "ENTRY_NO_SOTM", ++$entries );
        $template->parseCurrentBlock();

        // Show the number of lanes at site (NLAS)
        $template->setCurrentBlock( "NLAS_READONLY" );
        ltm_readNLASValue(
                $con,
                $readTables[ "InstallerOptions"],
                $readTables[ "LangInstallerOptions" ],
                $_SESSION[ SESS_LANGUAGE ],
                $nlas );
        $template->setVariable( "NLAS_DISPLAY_NAME",  $nlas["prompt"]   );
        $template->setVariable( "NLAS_DISPLAY_VALUE", $nlas["setting"]);
        $template->setVariable( "ENTRY_NO_NLAS", ++$entries );
        $template->parseCurrentBlock();
        
        // Mark the Dual-lane mode entry as disabled if a single lane system
        if ( $nlas["setting"] < 2 )
        {
            if ( isset( $params["DLM"] ) )
            {
                $params["DLM"]["disabled"] = true;
            }
        }

        // Database sourced parameters
        foreach ( $params as $paramName => $paramValue )
        {
            $template->setCurrentBlock( "FORM_ENTRY" );
            $template->setVariable( "PARAM_DISPLAY_NAME", $labelArray[ $paramName ]  );
            $template->setVariable( "PARAM_NAME", $paramName  );
            $template->setVariable( "ENTRY_NO", ++$entries );

            switch( $paramValue["Type"] )
            {
                case DATA_ENTRY_DISPLAY_ONLY:
                    $template->setVariable( "PARAM_DISPLAY_VALUE",  $paramValue["Value"] );
                    break;
                case DATA_ENTRY_DISABLED_TEXT:
                    $template->setVariable( "TEXT_DISABLED", "disabled"  );
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
                            if ( isset( $paramValue["disabled"] ) )
                            {
                                $template->setVariable( "RADIO_DISABLED", "disabled" );
                            }
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

        $template->setCurrentBlock( "LTM_FORM" );

        $submitEntry = "Not permitted";
        if ( $updateable == True )
        {
            $submitEntry ='<input id="submitFormButton" type="submit" value="'
                . $labelArray[ "ApplyChanges" ].'">';
        }
        $template->setVariable( "SUBMIT_ENTRY", $submitEntry );

        $template->setVariable( "HIDDEN_TIMENOW", $timeNow );
        $template->setVariable( "HIDDEN_SESSION", session_id() );
        $template->setVariable( "HIDDEN_SYSDATE", $sysDate );
        $template->setVariable( "HIDDEN_SYSTIME", $sysTime );
        

        $template->setVariable( "ERROR_ID", AJAX_ERROR );

        if ( isset( $_SESSION[ SESS_ERROR ] ))
        {
            $template->setVariable( "SESSION_ERROR_MESSAGE", $_SESSION[ SESS_ERROR ] );
        }


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
