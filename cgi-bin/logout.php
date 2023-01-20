#!/usr/bin/php-cgi -q
<?php
    require_once "HTML/Template/ITX.php";

    if ( session_start() == True )
    {
        $template = new HTML_Template_ITX( "templates" );
        $template->loadTemplatefile( "logout.tpl", true, true );

        $message = "";
        if ( isset( $_SESSION[ "username" ]) )
        {
            $message .= "{$_SESSION["username"]} logged out. ";
        }
        if ( isset( $_SESSION[ "message" ] ) )
        {
            $message .= $_SESSION[ "message" ];
        }

        $template->setVariable( "MESSAGE", $message );
        $template->parseCurrentBlock();
        $template->show();

        session_destroy();

        exit;
    }
?>
