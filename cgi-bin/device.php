#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          device.php - Venus web-site login support
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

    $readTables  = array( "LangLaneDeviceSettings"=>"LangLaneDeviceSettings", "LaneDevices"=>"LaneDevices" );
    $writeTables = array( "LaneDeviceSettings"=>"LaneDeviceSettings" );

    $disableSubmit = True;

    if (!mysqli_query( $con,
                VenusGenerateSQLLockingCommand( $writeTables, $readTables ) ) )
    {
        VenusShowError( $con );
    }
    else
    {
		$laneID = !empty( $_SESSION[ "DEVICE_FILTER" ] ) ? $_SESSION[ "DEVICE_FILTER" ] : '';
		$laneTitle = '';

		if ( isset( $_POST["deviceFilter"] ) && !empty( $_POST["deviceFilter"] ) )
		{
			$laneID = $_POST["deviceFilter"];
			$_SESSION[ "DEVICE_FILTER" ] = $_POST["deviceFilter"];
		}

		if ( !($queryDevicesResult = @mysqli_query( $con,
                    "select *
                    from {$readTables["LaneDevices"]} order by ID;" ) ) )
        {
            VenusShowError( $con );
        }
        else
        {
			$filterOptions = array();

			while ( $rowDevicesResult = mysqli_fetch_array( $queryDevicesResult ) )
            {
				$deviceName = $rowDevicesResult["Name"];
				$deviceCount = (int) $rowDevicesResult["Count"];
				$deviceLanes = array();
				$isfirst = true;

				for ($i=1; $i <= $deviceCount; $i++) {
					$laneName = "Lane {$i}";
					$laneKey = str_replace(" ", "", "Lane{$i}{$deviceName}" );

					if ( $isfirst && empty( $laneID ) && empty( $laneTitle ) ) {
						$laneID = $laneKey;
					}

					if ( $laneID === $laneKey ) {
						$laneTitle = $deviceName . ' - ' . $laneName;
					}

					$deviceLanes[ $laneKey ] = $laneName;

					$isfirst = false;
				}

                $filterOptions[] = array(
					'Name' => $deviceName,
					'Count' => $deviceCount,
					'Lanes' => $deviceLanes
				);
            }
            mysqli_free_result( $queryDevicesResult );

            $filterOptions = stripslashes_deep($filterOptions);
		}

        if (VenusIsUpdatableCheck( $con, "device", $timeNow, session_id() ) === True  )
        {
            $updateable = True;
        }

        $labelArray = VenusGetLabels( $con,
                $readTables["LangLaneDeviceSettings"], $_SESSION[ SESS_LANGUAGE ] );

// Read in the current values of the various NR parameters (lane 1)
        $params = array();
        if ( !($queryResult = @mysqli_query( $con,
                    "select *
                    from {$writeTables["LaneDeviceSettings"]} where laneID='{$laneID}' order by textID;" ) ) )
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
            $template->loadTemplatefile( VenusGetTemplateName( "device" ), true, true );

            $template->setCurrentBlock( "DEVICE_FORM" );

            $template->setVariable( "TITLE", $labelArray["PageTitle"] );
            $template->setVariable( "LINEHEAD", $laneTitle );
            $template->setVariable( "PARAM_DISPLAY_TITLE_ENABLED", $labelArray["EnabledTitle"]);

            $template->setCurrentBlock( "DEVICE_ENTRY");

			$template->setVariable( "PARAM_DISPLAY_ENABLED_KEY", $laneID."Enabled");
            $template->setVariable( "PARAM_DISPLAY_ENABLED_VALUE", cvtRadioValue($params[$laneID."Enabled"]));

            if( $params[$laneID."Enabled"] == "RADIO_YES" )
            {
                $template->setVariable("PARAM_ENABLED", "CHECKED");
                $template->setVariable("PARAM_DISABLED", "");
            }
            else
            {
                $template->setVariable("PARAM_ENABLED", "");
                $template->setVariable("PARAM_DISABLED", "CHECKED");
            }

            $template->setVariable("PARAM_DISPLAY_TITLE_SERVER", $labelArray["ServerTitle"]);
            $template->setVariable("PARAM_DISPLAY_SERVER_KEY", $laneID."Server");
			$template->setVariable("PARAM_DISPLAY_SERVER_VALUE", $params[$laneID."Server"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_SERVER_PORT", $labelArray["ServerPortTitle"]);
            $template->setVariable("PARAM_DISPLAY_SERVER_PORT_KEY", $laneID."ServerPort");
			$template->setVariable("PARAM_DISPLAY_SERVER_PORT_VALUE", $params[$laneID."ServerPort"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_REGISTRAR", $labelArray["RegistrarTitle"]);
            $template->setVariable("PARAM_DISPLAY_REGISTRAR_KEY", $laneID."Registrar");
			$template->setVariable("PARAM_DISPLAY_REGISTRAR_VALUE", $params[$laneID."Registrar"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_REGISTRAR_PORT", $labelArray["RegistrarPortTitle"]);
            $template->setVariable("PARAM_DISPLAY_REGISTRAR_PORT_KEY", $laneID."RegistrarPort");
			$template->setVariable("PARAM_DISPLAY_REGISTRAR_PORT_VALUE", $params[$laneID."RegistrarPort"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_EXTENSION", $labelArray["ExtensionTitle"]);
            $template->setVariable("PARAM_DISPLAY_EXTENSION_KEY", $laneID."Extension");
			$template->setVariable("PARAM_DISPLAY_EXTENSION_VALUE", $params[$laneID."Extension"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_AUTHENTICATION", $labelArray["AuthenticationTitle"]);
			$template->setVariable("PARAM_DISPLAY_AUTHENTICATION_KEY", $laneID."Authentication");
            $template->setVariable("PARAM_DISPLAY_AUTHENTICATION_VALUE", $params[$laneID."Authentication"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_PASSWORD", $labelArray["PasswordTitle"]);
			$template->setVariable("PARAM_DISPLAY_PASSWORD_KEY", $laneID."Password");
            $template->setVariable("PARAM_DISPLAY_PASSWORD_VALUE", $params[$laneID."Password"]);

            $template->setVariable("PARAM_DISPLAY_TITLE_OUTDIAL", $labelArray["OutdialExtensionTitle"]);
			$template->setVariable("PARAM_DISPLAY_OUTDIAL_KEY", $laneID."OutDial");
            $template->setVariable("PARAM_DISPLAY_OUTDIAL_VALUE", $params[$laneID."OutDial"]);

			// AutoAnswer

			$template->setVariable("PARAM_DISPLAY_TITLE_AUTO_ANSWER_ENABLED", $labelArray["AutoAnswerCallsTitle"]);

			$template->setVariable( "PARAM_DISPLAY_AUTO_ANSWER_ENABLED_KEY", $laneID."AutoAnswer");
			$template->setVariable( "PARAM_DISPLAY_AUTO_ANSWER_ENABLED_VALUE", cvtRadioValue($params[$laneID."AutoAnswer"]));

			if( $params[$laneID."AutoAnswer"] == "RADIO_YES" )
			{
				$template->setVariable("PARAM_AUTO_ANSWER_ENABLED_VALUE", "CHECKED");
				$template->setVariable("PARAM_AUTO_ANSWER_DISABLED_VALUE", "");
			}
			else
			{
				$template->setVariable("PARAM_AUTO_ANSWER_ENABLED_VALUE", "");
				$template->setVariable("PARAM_AUTO_ANSWER_DISABLED_VALUE", "CHECKED");
			}

			// Outdial On Sensor

			$template->setVariable("PARAM_DISPLAY_TITLE_OUTDIAL_ON_SENSOR_ENABLED", $labelArray["OutdialOnSensorTitle"]);

			$template->setVariable( "PARAM_DISPLAY_OUTDIAL_ON_SENSOR_ENABLED_KEY", $laneID."OutDialOnSensor");
			$template->setVariable( "PARAM_DISPLAY_OUTDIAL_ON_SENSOR_ENABLED_VALUE", cvtRadioValue($params[$laneID."OutDialOnSensor"]));

			if( $params[$laneID."OutDialOnSensor"] == "RADIO_YES" )
			{
				$template->setVariable("PARAM_OUTDIAL_ON_SENSOR_ENABLED_VALUE", "CHECKED");
				$template->setVariable("PARAM_OUTDIAL_ON_SENSOR_DISABLED_VALUE", "");
			}
			else
			{
				$template->setVariable("PARAM_OUTDIAL_ON_SENSOR_ENABLED_VALUE", "");
				$template->setVariable("PARAM_OUTDIAL_ON_SENSOR_DISABLED_VALUE", "CHECKED");
			}

			// Proxy Enabled

            $template->setVariable("PARAM_DISPLAY_TITLE_PROXY_ENABLED", $labelArray["ProxyEnabledTitle"]);

            $template->setVariable( "PARAM_DISPLAY_PROXY_ENABLED_KEY", $laneID."ProxyEnabled");
			$template->setVariable( "PARAM_DISPLAY_PROXY_ENABLED_VALUE", cvtRadioValue($params[$laneID."ProxyEnabled"]));

            if( $params[$laneID."ProxyEnabled"] == "RADIO_YES" )
            {
                $template->setVariable("PARAM_PROXY_ENABLED_VALUE", "CHECKED");
                $template->setVariable("PARAM_PROXY_DISABLED_VALUE", "");
            }
            else
            {
                $template->setVariable("PARAM_PROXY_ENABLED_VALUE", "");
                $template->setVariable("PARAM_PROXY_DISABLED_VALUE", "CHECKED");
            }

			// Registration and Call Status

            $template->setVariable("PARAM_DISPLAY_TITLE_REG_STATUS", $labelArray["RegStatusTitle"]);
            $template->setVariable("PARAM_DISPLAY_TITLE_CALL_STATUS", $labelArray["CallStatusTitle"]);

			$template->setVariable("PARAM_DISPLAY_REG_STATUS_KEY",  $laneID."RegStatus");
			$template->setVariable("PARAM_DISPLAY_CALL_STATUS_KEY",  $laneID."CallStatus");

            if( intval( $params[$laneID."StatusExpiration"]) > time() )
            {
                $template->setVariable("PARAM_DISPLAY_REG_STATUS_VALUE",  $params[$laneID."RegStatus"]);
				$template->setVariable("PARAM_DISPLAY_CALL_STATUS_VALUE",  $params[$laneID."CallStatus"]);
            }
            else
            {
                $template->setVariable("PARAM_DISPLAY_REG_STATUS_VALUE", "Unregistered/Expired");
                $template->setVariable("PARAM_DISPLAY_CALL_STATUS_VALUE", "Not Registered");
            }

            $template->parseCurrentBlock();
        }

		// Device filter block
		$template->setCurrentBlock( "DEVICE_FILTER_FORM" );
		$template->setVariable( "FILTER_FIELD_TITLE", $labelArray["FilterFieldTitle"] );

		$template->setCurrentBlock( "FILTER_OPTION_GROUP_SELECT" );

		foreach ($filterOptions as $group_key => $group_value) {

			$template->setVariable( "OPTION_GROUP_LABEL", $group_value["Name"] . " Lanes" );

			$optionsHTML = '';

			foreach ($group_value['Lanes'] as $option_key => $option_value) {
				$selected = $option_key === $laneID ? 'selected' : '';
				$optionsHTML .= '<option ' . $selected . ' value="' . $option_key . '">' . $option_value . '</option>';
			}

			$template->setVariable( "OPTION_GROUP_OPTIONS", $optionsHTML );
			$template->parseCurrentBlock();
		}

		$template->parseCurrentBlock();


        $template->setCurrentBlock( "DEVICE_FORM" );

        $template->setVariable( "ERROR_ID", AJAX_ERROR );
        $template->setVariable( "SESSION_ERROR_MESSAGE", $_SESSION[ SESS_ERROR ] );

        $submitEntry = "Not permitted";
        if ( $updateable == True )
        {
            $submitEntry ='<input id="submitFormButton" type="submit" value="'
                . $labelArray[ "ApplyChanges" ].'">';
        }
        $template->setVariable( "SUBMIT_ENTRY", $submitEntry );

		$template->setVariable( "HIDDEN_DEVICE_FILTER", $laneID );
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
