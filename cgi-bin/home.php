#!/usr/bin/php-cgi -q
<?php
    if ( session_start() == false )
    {
        die( "Unable to start session. Serious. Terminating script processing");
    }

    require_once "venus_helper.php";

    VenusSessionAuthenticate();
?>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Pragma" content="no-cache">
        <link rel="shortcut icon" href="../images/favicon.ico" type="image/x-icon">
        <link rel="icon" href="../images/favicon.ico" type="image/x-icon">
        <title>Welcome to PAR G5 Embedded Server</title>
    </head>
<frameset rows="32,*" border="0">
    <frame src="lgo.php" name="banner"
        scrolling="no" noresize marginwidth="0" marginheight="0" frameborder="0"
        >
    <frameset rows="*" cols="170,*">
        <frame src="mnu.php" name="menu"
            scrolling="auto" marginwidth="0" marginheight="0" frameborder="0"
        >
        <frameset rows="*, 19">
            <frame src="lca.php" name="infowindow"
                scrolling="auto" marginwidth="0" marginheight="0" frameborder="0"
                >
            <frame src="../ftr.htm" scrolling="no"
                noresize marginwidth="0" marginheight="0" frameborder="0"
                >
        </frameset>
    </frameset>
</frameset>
</html>
