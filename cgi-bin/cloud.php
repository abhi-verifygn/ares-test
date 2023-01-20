#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          msc.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the network settings form
    **
    *******************************************************************************
    **
    **  Copyright (c) Digital Acoustics, 2022
    **
    *******************************************************************************/

    require_once "HTML/Template/ITX.php";
    require_once "venus_helper.php";

    function cvtRadioValue( $value )
    {
        $returnVal = "No";

        if( $value == "RADIO_YES" )
        {
            $returnVal = "Yes";
        }

        return $returnVal;
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

    $readTables  = array( "LangCloudSettings"=>"LangCloudSettings" );
    $writeTables = array( "CloudSettings"=>"CloudSettings" );

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "cloud", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangCloudSettings"], $_SESSION[ SESS_LANGUAGE ] );

// Read in the current values of the various NR parameters (lane 1)
        $Parms = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$writeTables["CloudSettings"]} order by textID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
            while ( $rowResult = mysqli_fetch_array( $queryResult ) )
            {
                $params[$rowResult["textID"]] = $rowResult["dataValue"];
            }
            mysqli_free_result( $queryResult );

            $params = stripslashes_deep($params);

            $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
            $template->loadTemplatefile( VenusGetTemplateName( "cloud" ), true, true );

            $template->setCurrentBlock( "CLOUD_FORM" );

            $template->setVariable( "TITLE", $labelArray["PageTitle"] );

            $template->setCurrentBlock( "CLOUD_ENTRY");

            $template->setVariable( "PARAM_DISPLAY_TITLE_ENABLED", $labelArray["CloudEnabledTitle"]);
            $template->setVariable( "PARAM_DISPLAY_ENABLED_VALUE", cvtRadioValue($params["CloudEnabled"]));

            if( $params["CloudEnabled"] == "RADIO_YES" )
            {
                $template->setVariable("PARAM_ENABLED", "CHECKED");
                $template->setVariable("PARAM_DISABLED", "");
            }
            else
            {
                $template->setVariable("PARAM_ENABLED", "");
                $template->setVariable("PARAM_DISABLED", "CHECKED");
            }

            $template->setVariable("PARAM_DISPLAY_TITLE_STATUS", $labelArray["CloudStatusTitle"]);

            if( intval($params["CloudStatusExpiration"]) > time() )
            {
                $template->setVariable("PARAM_DISPLAY_CLOUD_STATUS", $params["CloudConnectionStatus"]);
            }
            else
            {
                $template->setVariable("PARAM_DISPLAY_CLOUD_STATUS", "Disconnected/Expired");
            }

            $template->setVariable("PARAM_DISPLAY_TITLE_ADDRESS", $labelArray["CloudAddressTitle"]);
            $template->setVariable("PARAM_DISPLAY_CLOUD_ADDRESS", $params["CloudAddress"]);
            $template->setVariable("PARAM_DISPLAY_TITLE_PORT", $labelArray["CloudAddressPortTitle"]);
            $template->setVariable("PARAM_DISPLAY_CLOUD_PORT", $params["CloudPort"]);
            $template->setVariable("PARAM_DISPLAY_TITLE_USERNAME", $labelArray["CloudUsernameTitle"]);
            $template->setVariable("PARAM_DISPLAY_CLOUD_USERNAME", $params["CloudUsername"]);
            $template->setVariable("PARAM_DISPLAY_TITLE_PASSWORD", $labelArray["CloudPasswordTitle"]);
            $template->setVariable("PARAM_DISPLAY_CLOUD_PASSWORD", $params["CloudPassword"]);

            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "CLOUD_FORM" );

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
