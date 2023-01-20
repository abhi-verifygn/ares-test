#!/usr/bin/php-cgi -q
<?php
    if ( session_start() == false )
    {
        die( "Unable to start session. Serious. Terminating script processing");
    }

    require_once "venus_helper.php";

    if ( VenusSessionAuthenticate( false ) )
    {
        echo <<<'logo'
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Pragma" content="no-cache">
        <link rel="stylesheet" type="text/css" href="../styles/lgo.css">
        <title></title>
    </head>
<body text="#00447C">
    <table border="0" cellpadding="0" cellspacing="0" align="left" width="100%">
        <tr>
            <td>&nbsp;</td>
            <td width="115">
                <a href="lca.php" target="infowindow">
                    <img src="../images/hom.gif" alt="">H<span class="f2">ome</span>
                </a>
            </td>
            <td width="115">
                <a href="logout.php" target="_top">
                    <img src="../images/out.gif" alt="">L<span class="f2">ogout</span></a>
            </td>
            <td id="a1">
                <span id="f1">
                    &nbsp;&nbsp;<?=$254_customerName?>&nbsp;<?=$128_CUSTOMER_LANE?>
                </span>
                : &nbsp;
                C<span class="f2">onfiguration Site&nbsp;&nbsp;</span>
            </td>
        </tr>
    </table>
</body>
</html>
logo;
    }
?>
