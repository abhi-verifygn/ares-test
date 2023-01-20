#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          abt.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Provides details about a venus unit
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "HTML/Template/ITX.php";
    require_once "venus_helper.php";

    /******************************************************************************/
    /*    Macro Definitions                                                       */
    /******************************************************************************/
    define( "SYS_REVISION_LEVEL", 0 );
    define( "APP_REVISION_LEVEL", 1 );
    define( "PCB_REVISION_LEVEL", 2 );
    define( "MSP_REVISION_LEVEL", 3 );
    define( "DSP_REVISION_LEVEL", 4 );
    define( "BBC_REVISION_LEVEL", 5 );
    define( "CONFIG_SERIAL",      6 );
    define( "PERM_SERIAL",        7 );
    define( "PHP_REVISION_LEVEL", 8 );

    /******************************************************************************
    **  Script entry point
    **
    */

    if ( session_start() == false )
    {
        die( "Unable to start session. Serious. Terminating script processing");
    }

    VenusSessionAuthenticate();

    $con = VenusDBConnect();
    $langTable = "LangAbout";

    $mySQLServerVersion = substr( mysqli_get_server_info( $con ), 0 , 15 );
    $PHPVersion = phpversion();

    if (!mysqli_query( $con,
            "LOCK TABLE {$langTable} READ;" ) )
    {
        VenusShowError( $con );
    }
    else
    {
        $labelArray = VenusGetLabels( $con, $langTable, $_SESSION[ SESS_LANGUAGE ] );

        $template = new HTML_Template_ITX( TEMPLATE_FOLDER );
        $template->loadTemplatefile( VenusGetTemplateName( "abt" ), true, true );

        $template->setCurrentBlock( "ABT_PAGE" );
        $template->setVariable( "TITLE", $labelArray["PageTitle"] );

        /* Determine version information from MMI task */
        $versionInfo = array();
        exec( "/usr/bin/send_ver_req_msg -w 10", $versionInfo, $returnValue );

        $template->setVariable( "HW_REVISION_LEVELS", $labelArray["HardwareRevisionLevels"] );

        $template->setVariable( "SERIAL_NO_CHANGEABLE", $labelArray["SerialNoChangable"] );
        $template->setVariable( "SERIAL_NO_PERMANENT", $labelArray["SerialNoPermanent"] );
        $template->setVariable( "HW_SERIAL_C", $versionInfo[CONFIG_SERIAL] );
        $template->setVariable( "HW_SERIAL_P", $versionInfo[PERM_SERIAL] );

        $template->setVariable( "BASE_STATION_HARDWARE", $labelArray["BaseStationHardware"] );

        $template->setVariable( "BASE_STATION_HARDWARE_REVISION", $versionInfo[PCB_REVISION_LEVEL] );
        $template->setVariable( "SYSTEM", $labelArray["SystemRevision"] );
        $template->setVariable( "SYSTEM_VERSION", $versionInfo[SYS_REVISION_LEVEL] );

        $template->setVariable( "SOFTWARE_REVISION_LEVELS", $labelArray["SoftwareRevisionLevels"] );

        $template->setVariable( "BBC_SOFTWARE", $labelArray["BBCSoftware"] );
        $template->setVariable( "BBC_SW_REVISION", $versionInfo[BBC_REVISION_LEVEL] );

        $template->setVariable( "DSP_SOFTWARE", $labelArray["DSPSoftware"] );
        $template->setVariable( "DSP_VERSION", $versionInfo[DSP_REVISION_LEVEL] );
        $template->setVariable( "MSP_SOFTWARE", $labelArray["MSPSoftware"] );
        $template->setVariable( "MSP_SOFTWARE_REVISION", $versionInfo[MSP_REVISION_LEVEL] );

        $template->setVariable( "APP_SOFTWARE", $labelArray["AppSoftware"] );
        $template->setVariable( "APP_SW_VERSION", $versionInfo[APP_REVISION_LEVEL] );

        $template->setVariable( "DATABASE", $labelArray["Database"] );
        $template->setVariable( "DB_VERSION", $mySQLServerVersion );

        $template->setVariable( "WEB_SERVER", $labelArray["WebServer"] );
        $template->setVariable( "WEB_SERVER_VERSION", $_ENV["SERVER_SOFTWARE"] );

        $template->setVariable( "PHP_SOFTWARE", $labelArray["PHPSoftware"] );
        $template->setVariable( "PHP_SOFTWARE_VERSION", $PHPVersion );

        $template->parseCurrentBlock();
        $template->show( );

        if ( !@mysqli_query( $con, "UNLOCK TABLES;" ) )
        {
            VenusShowError( $con );
        }
    }
?>
