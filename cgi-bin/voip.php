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

    $readTables  = array( "LangVoIPSettings"=>"LangVoIPSettings" );
    $writeTables = array( "VoIPSettings"=>"VoIPSettings" );

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
        if (VenusIsUpdatableCheck( $con, "voip", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangVoIPSettings"], $_SESSION[ SESS_LANGUAGE ] );

// Read in the current values of the various NR parameters (lane 1)
        $params = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$writeTables["VoIPSettings"]} order by textID;" ) ) )
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
            $template->loadTemplatefile( VenusGetTemplateName( "voip" ), true, true );

            $template->setCurrentBlock( "VOIP_FORM" );

            $template->setVariable( "TITLE", $labelArray["PageTitle"] );
            $template->setVariable( "L1HEAD", $labelArray["Lane1Header"] );
            $template->setVariable( "L2HEAD", $labelArray["Lane2Header"] );
            $template->setVariable( "PARAM_DISPLAY_TITLE_ENABLED", $labelArray["VoIPEnabledTitle"]);

            $template->setCurrentBlock( "VOIP_ENTRY");

            $template->setVariable( "PARAM_DISPLAY_ENABLED_VALUE_L1", cvtRadioValue($params["Lane1VoIPEnabled"]));

            if( $params["Lane1VoIPEnabled"] == "RADIO_YES" )
            {
                $template->setVariable("PARAM_ENABLED_L1", "CHECKED");
                $template->setVariable("PARAM_DISABLED_L1", "");
            }
            else
            {
                $template->setVariable("PARAM_ENABLED_L1", "");
                $template->setVariable("PARAM_DISABLED_L1", "CHECKED");
            }

            $template->setVariable( "PARAM_DISPLAY_ENABLED_VALUE_L2", cvtRadioValue($params["Lane2VoIPEnabled"]));

            if( $params["Lane2VoIPEnabled"] == "RADIO_YES" )
            {
                $template->setVariable("PARAM_ENABLED_L2", "CHECKED");
                $template->setVariable("PARAM_DISABLED_L2", "");
            }
            else
            {
                $template->setVariable("PARAM_ENABLED_L2", "");
                $template->setVariable("PARAM_DISABLED_L2", "CHECKED");
            }

            $template->setVariable("PARAM_DISPLAY_TITLE_SERVER", $labelArray["VoIPServerTitle"]);
            $template->setVariable("PARAM_DISPLAY_SERVER_VALUE_L1", $params["Lane1VoIPServer"]);
            $template->setVariable("PARAM_DISPLAY_SERVER_VALUE_L2", $params["Lane2VoIPServer"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_SERVER_PORT", $labelArray["VoIPServerPortTitle"]);
            $template->setVariable("PARAM_DISPLAY_SERVER_PORT_VALUE_L1", $params["Lane1VoIPServerPort"]);
            $template->setVariable("PARAM_DISPLAY_SERVER_PORT_VALUE_L2", $params["Lane2VoIPServerPort"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_REGISTRAR", $labelArray["VoIPRegistrarTitle"]);
            $template->setVariable("PARAM_DISPLAY_REGISTRAR_VALUE_L1", $params["Lane1VoIPRegistrar"]);
            $template->setVariable("PARAM_DISPLAY_REGISTRAR_VALUE_L2", $params["Lane2VoIPRegistrar"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_REGISTRAR_PORT", $labelArray["VoIPRegistrarPortTitle"]);
            $template->setVariable("PARAM_DISPLAY_REGISTRAR_PORT_VALUE_L1", $params["Lane1VoIPRegistrarPort"]);
            $template->setVariable("PARAM_DISPLAY_REGISTRAR_PORT_VALUE_L2", $params["Lane2VoIPRegistrarPort"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_EXTENSION", $labelArray["VoIPExtensionTitle"]);
            $template->setVariable("PARAM_DISPLAY_EXTENSION_VALUE_L1", $params["Lane1VoIPExtension"]);
            $template->setVariable("PARAM_DISPLAY_EXTENSION_VALUE_L2", $params["Lane2VoIPExtension"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_AUTHENTICATION", $labelArray["VoIPAuthenticationTitle"]);
            $template->setVariable("PARAM_DISPLAY_AUTHENTICATION_VALUE_L1", $params["Lane1VoIPAuthentication"]);
            $template->setVariable("PARAM_DISPLAY_AUTHENTICATION_VALUE_L2", $params["Lane2VoIPAuthentication"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_PASSWORD", $labelArray["VoIPPasswordTitle"]);
            $template->setVariable("PARAM_DISPLAY_PASSWORD_VALUE_L1", $params["Lane1VoIPPassword"]);
            $template->setVariable("PARAM_DISPLAY_PASSWORD_VALUE_L2", $params["Lane2VoIPPassword"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_OUTDIAL", $labelArray["VoIPOutdialExtensionTitle"]);
            $template->setVariable("PARAM_DISPLAY_OUTDIAL_VALUE_L1", $params["Lane1VoIPOutDial"]);
            $template->setVariable("PARAM_DISPLAY_OUTDIAL_VALUE_L2", $params["Lane2VoIPOutDial"]);

// AutoAnswer

$template->setVariable("PARAM_DISPLAY_TITLE_AUTO_ANSWER_ENABLED", $labelArray["VoIPAutoAnswerCallsTitle"]);

$template->setVariable( "PARAM_DISPLAY_AUTO_ANSWER_ENABLED_VALUE_L1", cvtRadioValue($params["Lane1VoIPAutoAnswer"]));

if( $params["Lane1VoIPAutoAnswer"] == "RADIO_YES" )
{
    $template->setVariable("PARAM_AUTO_ANSWER_ENABLED_VALUE_L1", "CHECKED");
    $template->setVariable("PARAM_AUTO_ANSWER_DISABLED_VALUE_L1", "");
}
else
{
    $template->setVariable("PARAM_AUTO_ANSWER_ENABLED_VALUE_L1", "");
    $template->setVariable("PARAM_AUTO_ANSWER_DISABLED_VALUE_L1", "CHECKED");
}

$template->setVariable( "PARAM_DISPLAY_AUTO_ANSWER_ENABLED_VALUE_L2", cvtRadioValue($params["Lane2VoIPAutoAnswer"]));

if( $params["Lane2VoIPAutoAnswer"] == "RADIO_YES" )
{
    $template->setVariable("PARAM_AUTO_ANSWER_ENABLED_VALUE_L2", "CHECKED");
    $template->setVariable("PARAM_AUTO_ANSWER_DISABLED_VALUE_L2", "");
}
else
{
    $template->setVariable("PARAM_AUTO_ANSWER_ENABLED_VALUE_L2", "");
    $template->setVariable("PARAM_AUTO_ANSWER_DISABLED_VALUE_L2", "CHECKED");
}

// Outdial On Sensor

$template->setVariable("PARAM_DISPLAY_TITLE_OUTDIAL_ON_SENSOR_ENABLED", $labelArray["VoIPOutdialOnSensorTitle"]);

$template->setVariable( "PARAM_DISPLAY_OUTDIAL_ON_SENSOR_ENABLED_VALUE_L1", cvtRadioValue($params["Lane1VoIPOutDialOnSensor"]));

if( $params["Lane1VoIPOutDialOnSensor"] == "RADIO_YES" )
{
    $template->setVariable("PARAM_OUTDIAL_ON_SENSOR_ENABLED_VALUE_L1", "CHECKED");
    $template->setVariable("PARAM_OUTDIAL_ON_SENSOR_DISABLED_VALUE_L1", "");
}
else
{
    $template->setVariable("PARAM_OUTDIAL_ON_SENSOR_ENABLED_VALUE_L1", "");
    $template->setVariable("PARAM_OUTDIAL_ON_SENSOR_DISABLED_VALUE_L1", "CHECKED");
}

$template->setVariable( "PARAM_DISPLAY_OUTDIAL_ON_SENSOR_ENABLED_VALUE_L2", cvtRadioValue($params["Lane2VoIPOutDialOnSensor"]));

if( $params["Lane2VoIPOutDialOnSensor"] == "RADIO_YES" )
{
    $template->setVariable("PARAM_OUTDIAL_ON_SENSOR_ENABLED_VALUE_L2", "CHECKED");
    $template->setVariable("PARAM_OUTDIAL_ON_SENSOR_DISABLED_VALUE_L2", "");
}
else
{
    $template->setVariable("PARAM_OUTDIAL_ON_SENSOR_ENABLED_VALUE_L2", "");
    $template->setVariable("PARAM_OUTDIAL_ON_SENSOR_DISABLED_VALUE_L2", "CHECKED");
}

// Proxy Enabled

            $template->setVariable("PARAM_DISPLAY_TITLE_PROXY_ENABLED", $labelArray["VoIPProxyEnabledTitle"]);

            $template->setVariable( "PARAM_DISPLAY_PROXY_ENABLED_VALUE_L1", cvtRadioValue($params["Lane1VoIPProxyEnabled"]));

            if( $params["Lane1VoIPProxyEnabled"] == "RADIO_YES" )
            {
                $template->setVariable("PARAM_PROXY_ENABLED_VALUE_L1", "CHECKED");
                $template->setVariable("PARAM_PROXY_DISABLED_VALUE_L1", "");
            }
            else
            {
                $template->setVariable("PARAM_PROXY_ENABLED_VALUE_L1", "");
                $template->setVariable("PARAM_PROXY_DISABLED_VALUE_L1", "CHECKED");
            }

            $template->setVariable( "PARAM_DISPLAY_PROXY_ENABLED_VALUE_L2", cvtRadioValue($params["Lane2VoIPProxyEnabled"]));

            if( $params["Lane2VoIPProxyEnabled"] == "RADIO_YES" )
            {
                $template->setVariable("PARAM_PROXY_ENABLED_VALUE_L2", "CHECKED");
                $template->setVariable("PARAM_PROXY_DISABLED_VALUE_L2", "");
            }
            else
            {
                $template->setVariable("PARAM_PROXY_ENABLED_VALUE_L2", "");
                $template->setVariable("PARAM_PROXY_DISABLED_VALUE_L2", "CHECKED");
            }

// Registration and Call Status

            $template->setVariable("PARAM_DISPLAY_TITLE_REG_STATUS", $labelArray["VoIPRegStatusTitle"]);
            $template->setVariable("PARAM_DISPLAY_TITLE_CALL_STATUS", $labelArray["VoIPCallStatusTitle"]);
            if( intval($params["Lane1StatusExpiration"]) > time() )
            {
                $template->setVariable("PARAM_DISPLAY_REG_STATUS_VALUE_L1", $params["Lane1RegStatus"]);
                $template->setVariable("PARAM_DISPLAY_CALL_STATUS_VALUE_L1", $params["Lane1CallStatus"]);
            }
            else
            {
                $template->setVariable("PARAM_DISPLAY_REG_STATUS_VALUE_L1", "Unregistered/Expired");
                $template->setVariable("PARAM_DISPLAY_CALL_STATUS_VALUE_L1", "Not Registered");
            }

            if( intval($params["Lane2StatusExpiration"]) > time() )
            {
                $template->setVariable("PARAM_DISPLAY_REG_STATUS_VALUE_L2", $params["Lane2RegStatus"]);
                $template->setVariable("PARAM_DISPLAY_CALL_STATUS_VALUE_L2", $params["Lane2CallStatus"]);
            }
            else
            {
                $template->setVariable("PARAM_DISPLAY_REG_STATUS_VALUE_L2", "Unregistered/Expired");
                $template->setVariable("PARAM_DISPLAY_CALL_STATUS_VALUE_L2", "Not Registered");
            }

            $template->parseCurrentBlock();
        }

        $template->setCurrentBlock( "VOIP_FORM" );

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
