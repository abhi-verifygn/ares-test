#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          do.login.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Processes the posted log-in form data and sets up the PHP session.
    **
    *******************************************************************************
    **
    **  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
    **
    *******************************************************************************/

    require_once "venus_helper.php";

    /******************************************************************************
    **  Script entry point
    **
    */
    $con = VenusDBConnect();
    $languageTable = "Languages";

    $userName = VenusMySqlClean( $_POST, "USER", 20, $con );
    $password = VenusMySqlClean( $_POST, "PASSWORD", 10, $con );
    $languageName = VenusMySqlClean( $_POST, "LANGUAGE", 30, $con );


    if ( session_start() == False )
    {
        die( "Unable to initiate session" );
    }

    if ( VenusAuthenticateUser( $con, $userName, $password ) )
    {
        // Authenticated
        $_SESSION[ SESS_USERNAME ] = $userName;
        $_SESSION[ SESS_LOGIN_IP ] = $_SERVER["REMOTE_ADDR"];

        // Assume fall back to default language
        $_SESSION[ SESS_LANGUAGE ] = DEFAULT_LANGUAGE;
        if ( $result = @mysqli_query( $con,
                            "SELECT ID, LanguageName from {$languageTable};" ) )
        {
            while( ($langArray = @mysqli_fetch_array( $result, MYSQLI_ASSOC )) != NULL )
            {
                if ( $langArray[ "LanguageName" ] == $languageName )
                {
                    $_SESSION[ SESS_LANGUAGE ] = $langArray[ "ID" ];
                }
            }

            mysqli_free_result( $result );
        }

        // Redirect to home
        header(
            "location: home.php",
            true, // replace any existing location header
            303   // HTTP "303 see other" response code
            );
        exit;
    }
    else
    {
        // Authentication failed
        $_SESSION["message"] = "Invalid password for {$userName}";
        header(
            "location: logout.php",
            true, // replace any existing location header
            303   // HTTP "303 see other" response code
            );
        exit;
    }
?>
