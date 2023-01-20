#!/usr/bin/php-cgi -q
<?php
    require_once "HTML/Template/ITX.php";
    require_once "venus_helper.php";

    if ( session_start() == false )
    {
        die( "Unable to start session. Serious. Terminating script processing");
    }

    $timeNow = time();

    VenusSessionAuthenticate();

    $template = new HTML_Template_ITX( "templates" );
    $template->loadTemplatefile( "ino.tpl", true, true );

    $message = "";

    $template->setVariable( "MESSAGE", $message );
    $template->parseCurrentBlock();
    $template->show();

    exit;
?>
