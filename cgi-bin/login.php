#!/usr/bin/php-cgi -q
<?php
    /******************************************************************************
    **
    **  COMPONENT:          login.php - Venus web-site login support
    **
    **  REVISION:           $Revision:  $
    **  LAST MODIFIED BY:   $Author:  $
    **  DATE:               $Date:  $
    **
    **  Presents the login form to a web-site user.
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
    $template = new HTML_Template_ITX( "templates" );

    $template->loadTemplatefile( "login.tpl", true, true );

    if ( session_start() == True )
    {
        if ( isset( $_GET[ 'doCCheck' ] )
             && $_GET[ 'doCCheck' ] == True )
        {
            if ( isset( $_COOKIE[ 'CCheck' ] )
                 && $_COOKIE[ 'CCheck' ] == 'confirmed')
            {
                $users = array();

                $con = VenusDBConnect();
                $table = "Users";
                $languageTable = "Languages";

                if (
                    (!$usersResult = @mysqli_query( $con, "select Value from ${table};" ) )
                    || (!$languagesResult = @mysqli_query( $con, "select ID, LanguageName from ${languageTable};" )) )
                {
                    VenusShowError( $con );
                }
                else
                {
                    $template->setCurrentBlock( "LOGIN_FORM" );
                    $template->setVariable( "USER_NAME_PROMPT","User-name" );

                    $template->setCurrentBlock( "ADD_USER" );
                    while ( ($row = mysqli_fetch_array( $usersResult, MYSQLI_ASSOC ) ) != NULL )
                    {
                        $template->setVariable( "USER", $row["Value"] );
                        $template->parseCurrentBlock();
                    }
                    $template->setCurrentBlock( "LOGIN_FORM" );

                    $template->setVariable( "PASSWORD_PROMPT","Password" );
                    $template->setVariable( "PASSWORD_LENGTH","8" );

                    $template->setVariable( "LANGUAGE_PROMPT","Language" );
                    $template->setCurrentBlock( "ADD_LANGUAGE" );
                    while ( ($row = mysqli_fetch_array( $languagesResult, MYSQLI_ASSOC ) ) != NULL )
                    {
                        $template->setVariable( "LANGUAGE", $row["LanguageName"] );
                        $template->parseCurrentBlock();
                    }
                    $template->setCurrentBlock( "LOGIN_FORM" );

                    $template->setVariable( "MESSAGE", $_SESSION[ "message" ] );

                    $template->parseCurrentBlock();

                    mysqli_free_result( $usersResult );
                    mysqli_free_result( $languagesResult );
                }
                $template->show();
            }
            else
            {
                $template->setCurrentBlock( "NO_COOKIES" );
                $template->touchBlock( "NO_COOKIES" );
                $template->parseCurrentBlock();
                $template->show();
            }
        }
        else
        {
            setcookie(
                'CCheck',      // Cookie name
                'confirmed',   // Cookie value
                0,             // Timeout - until browser is closed
                "",            // path
                "",            // domain
                false,          // Only via HTTPS
                true );        // Don't allow local scripts to use

            // redirecting to the same page to check
            header(
                "location: {$_SERVER['PHP_SELF']}?doCCheck=True",
                true, // replace any existing location header
                303   // HTTP "303 see other" response code
                );
        }
    }
    else
    {
        $template->setCurrentBlock( "NO_SESSION" );
        $template->touchBlock( "NO_SESSION" );
        $template->parseCurrentBlock();
        $template->show();
    }
?>
