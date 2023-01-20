#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          mnu.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the web-site's menu .
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "HTML/Template/ITX.php";


    /******************************************************************************
    **  Script entry point
    **
    */

    if ( session_start() == false )
    {
        die( "Unable to start session. Serious. Terminating script processing");
    }

    require_once "venus_helper.php";

    if ( VenusSessionAuthenticate( false ) )
    {
        $con = VenusDBConnect();
        $table = "Messages";
        $langTable = "LangMenu";

        if (!mysqli_query( $con,
                "LOCK TABLE {$table} READ, {$langTable} READ;" ) )
        {
            VenusShowError( $con );
        }
        else
        {
            $labelArray = VenusGetLabels( $con, $langTable, $_SESSION[ SESS_LANGUAGE ] );

            $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
            $template->loadTemplatefile( VenusGetTemplateName( "mnu" ), true, true );

            // Read in names of greeter messages for use in greeter combo
            $messageNames = array();

            if ( !$result = @mysqli_query( $con,
                "select MsgID, Name from {$table} order by MsgID;" ) )
            {
                VenusShowError( $con );
            }
            else
            {
                while( $row = mysqli_fetch_array( $result, MYSQLI_ASSOC ) )
                {
                    $messageNames[ $row[ "MsgID" ] ] = $row[ "Name" ];
                }
                mysqli_free_result( $result );
            }

            $messageNames = stripslashes_deep($messageNames);

//            error_log("SettingsItemCloud=".$labelArray["SettingsItemVoIP"], 3, "mnu_log.txt");

            $template->setCurrentBlock( "MNU_BODY" );
            $template->setVariable( "SITE_MENU_TITLE", $labelArray["SiteMenuTitle"] );
            $template->setVariable( "SITE_MENU_INFO", $labelArray["SiteItemSiteInfo" ] );
            $template->setVariable( "SITE_MENU_WORKING_HOURS", $labelArray["SiteItemWorkingHours" ] );
            $template->setVariable( "SITE_MENU_HOLIDAY_SCHEDULE", $labelArray["SiteItemHolidaySchedule" ] );
            $template->setVariable( "SITE_MENU_REVISIONS", $labelArray["SiteItemRevisions" ] );

            $template->setVariable( "STATUS_MENU_TITLE", $labelArray["StatusMenuTitle"] );
            $template->setVariable( "STATUS_ITEM_CURRENT", $labelArray["StatusItemCurrent" ] );
            $template->setVariable( "STATUS_ITEM_DIAGNOSTICS", $labelArray["StatusItemDiagnostics" ] );
            $template->setVariable( "STATUS_ITEM_RESTART", $labelArray["StatusItemRestartSystem" ] );
            $template->setVariable( "STATUS_ITEM_INSTALLER_OPTIONS", $labelArray["StatusItemInstallerOptions" ] );

            $template->setVariable( "SETTINGS_MENU_TITLE", $labelArray["SettingsMenuTitle"] );
            $template->setVariable( "SETTINGS_VOL_CB_TITLE", $labelArray["SettingsVolCBTitle"] );
            $template->setVariable( "SETTINGS_VOL_CB_DRIVETHRU", $labelArray["SettingsVolCBDriveThru"] );
            $template->setVariable( "SETTINGS_VOL_CB_MONITOR", $labelArray["SettingsVolCBMonitor"] );
            $template->setVariable( "SETTINGS_VOL_CB_NIGHT", $labelArray["SettingsVolCBNight"] );
            $template->setVariable( "SETTINGS_ITEM_NR", $labelArray["SettingsItemNR"] );
            $template->setVariable( "SETTINGS_ITEM_GLOBAL", $labelArray["SettingsItemGlobal"] );
            $template->setVariable( "SETTINGS_ITEM_DETECTORS", $labelArray["SettingsItemDetectors"] );
            $template->setVariable( "SETTINGS_ITEM_ORDER_TAKING", $labelArray["SettingsItemOrderTaking"] );
            $template->setVariable( "SETTINGS_ITEM_SELF_MONITOR", $labelArray["SettingsItemSelfMonitor"] );
            $template->setVariable( "SETTINGS_ITEM_NETWORK", $labelArray["SettingsItemNetwork"] );
            $template->setVariable( "SETTINGS_ITEM_VOIP", $labelArray["SettingsItemVoIP"] );
			$template->setVariable( "SETTINGS_ITEM_LANE_DEVICE", $labelArray["SettingsItemLaneDevice"] );
			$template->setVariable( "SETTINGS_ITEM_LANE_SERVER", $labelArray["SettingsItemLaneServer"] );
            $template->setVariable( "SETTINGS_ITEM_CLOUD", $labelArray["SettingsItemCloud"]);

            $template->setVariable( "OTHER_HW_ITEM_HEADSET", $labelArray["OtherHWItemHeadset"] );

            $template->setVariable( "OTHER_HW_GREETER_CB_TITLE", $labelArray["OtherHWGreeterCBTitle"] );
            $template->setVariable( "OTHER_HW_GREETER_CB_GLOBAL", $labelArray["OtherHWGreeterCBGlobal"] );
            $template->setVariable( "OTHER_HW_GREETER_CB_DAYPARTS", $labelArray["OtherHWGreeterCBDayparts"] );

            for( $i = 1; $i <= 16; ++$i )
            {
                $template->setVariable(
                    "OTHER_HW_GREETER_CB_MSG_{$i}",
                    $labelArray["OtherHWGreeterCBMSG_{$i}"] );
                $template->setVariable(
                    "OTHER_HW_GREETER_CB_MSG_{$i}_NAME",
                    $messageNames["{$i}"] );
            }
            $template->setVariable( "SETTINGS_ITEM_DIO", "Digital I/O" ); #; $labelArray["OtherHWItemHeadset"] );

            $template->setVariable( "FILE_MENU_TITLE", $labelArray["FileMenuTitle"] );
            $template->setVariable( "FILE_ITEM_CONFIG", $labelArray["FileItemConfig"] );

            $template->parseCurrentBlock();
            $template->show( );

            if ( !@mysqli_query( $con, "UNLOCK TABLES;" ) )
            {
                VenusShowError( $con );
            }
        }
    }
?>
