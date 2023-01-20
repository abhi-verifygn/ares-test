#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          noi.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the noise reduction settings form
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

    $writeTables = array(
                        "NoiseReduction"=>"NoiseReduction",
                        "DL2NoiseReduction"=>"DL2NoiseReduction");
    $readTables = array(
                        "LangNoiseReduction"=>"LangNoiseReduction",
                        "NoiseReductionParams"=>"NoiseReductionParams",
                        "DL2NoiseReductionParams"=>"DL2NoiseReductionParams",
                         );

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "noi", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangNoiseReduction"], $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "noi" ), true, true );

        $template->setCurrentBlock( "NOI_FORM" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );
        $template->setVariable( "L1HEAD", $labelArray["Lane1Header"] );
        $template->setVariable( "L2HEAD", $labelArray["Lane2Header"] );

        // Read in the current values of the various NR parameters (lane 1)
        $params = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$writeTables["NoiseReduction"]} order by ID;" ) ) )
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
                                from {$readTables["NoiseReductionParams"]}
                                where Name = '{$paramName}'
                                order by DisplayOrder;";
                    break;

                case DATA_ENTRY_YESNO_RADIO:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["NoiseReductionParams"]}
                                where Name = 'GenericRadioYesNo'
                                order by DisplayOrder;";
                    break;
                case DATA_ENTRY_RADIO:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["NoiseReductionParams"]}
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


        // Now read in the current values of the various NR parameters (lane 2)
        $paramsL2 = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$writeTables["DL2NoiseReduction"]} order by ID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $paramsL2[$rowResult["ParamNameID"]] = array( 
                    "Value" => $rowResult["ParamValueID"],
                    "Type" => $rowResult["DataEntryType"] );
            }
            mysqli_free_result( $queryResult );
        }
        foreach ( $paramsL2 as $paramName => $param )
        {
            $sqlQuery = "";
            switch ( $param["Type"] )
            {
                case DATA_ENTRY_SELECT:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["DL2NoiseReductionParams"]}
                                where Name = '{$paramName}'
                                order by DisplayOrder;";
                    break;

                case DATA_ENTRY_YESNO_RADIO:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["DL2NoiseReductionParams"]}
                                where Name = 'GenericRadioYesNo'
                                order by DisplayOrder;";
                    break;
                case DATA_ENTRY_RADIO:
                    $sqlQuery = "select ValueName, Value
                                from {$readTables["DL2NoiseReductionParams"]}
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
                $paramsL2[$paramName]["Options"] = $options;
            }
        }


        // Fill in the web-page template
        $entries = 0;
        foreach ( $params as $paramName => $paramValue )
        {
            $template->setCurrentBlock( "NOI_ENTRY" );
            $template->setVariable( "PARAM_DISPLAY_NAME", $labelArray[ $paramName ]  );
            $template->setVariable( "PARAM_NAME", $paramName  );
            $template->setVariable( "PARAM_NAME_L2", $paramName . "_L2"  );
            $template->setVariable( "ENTRY_NO", ++$entries );
            $template->setVariable( "ENTRY_NO_L2", ++$entries );

            /* Grab the Lane 2 parameter */
            $paramL2Value = $paramsL2[$paramName];

            switch( $paramValue["Type"] )
            {
                case DATA_ENTRY_SELECT:
                    $template->setVariable( "PARAM_DISPLAY_VALUE", $labelArray[ $paramValue["Value"]] );
                    $template->setVariable( "PARAM_DISPLAY_VALUE_L2", $labelArray[ $paramL2Value["Value"]] );
                    $template->setCurrentBlock( "GLB_SELECT" );
                    $template->setVariable( "SELECT_PARAM_NAME", $paramName );
                    $template->setVariable( "SELECT_HERE", $labelArray["SelectHere"] );

                    if ( isset( $paramValue[ "Options" ] ) )
                    {
                        foreach( $paramValue[ "Options" ] as $Name => $Value )
                        {
                            $template->setCurrentBlock( "NOI_OPTIONS" );
                            $template->setVariable( "OPTION_ID", $Name );
                            $template->setVariable( "OPTION_DISPLAY_VALUE", $labelArray[$Name] );
                            $template->parseCurrentBlock();
                        }
                    }
                    if ( isset( $paramL2Value[ "Options" ] ) )
                    {
                        foreach( $paramL2Value[ "Options" ] as $Name => $Value )
                        {
                            $template->setCurrentBlock( "NOI_OPTIONS_L2" );
                            $template->setVariable( "OPTION_ID_L2", $Name );
                            $template->setVariable( "OPTION_DISPLAY_VALUE", $labelArray[$Name] );
                            $template->parseCurrentBlock();
                        }
                    }
                    break;
                default:
                    /* This web page is not currently set up for data types other than a selector 
                     * Compare with glb.php to see a page processor that processes database data
                     * with more than just a selector in it. */
                    break;
            }
            $template->setCurrentBlock( "NOI_ENTRY" );
            $template->parseCurrentBlock();
        }
        $template->setCurrentBlock( "NOI_FORM" );

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
