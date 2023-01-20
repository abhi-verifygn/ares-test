<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="../../styles/css.css">
        <title></title>
    </head>
<body>
    <table class="MMM">
        <tr>
            <td>
                <!-- BEGIN NO_SESSION -->
                <p>No session</p>
                <!-- END NO_SESSION -->
                <!-- BEGIN NO_COOKIES -->
                <table class="MMM">
                    <tr><td>
                        <blockquote>Login Not Possible</blockquote>
                        <center>
                            <font face="arial" color="white">:: PAR Embedded Server ::</font><br>
                            <font color="red"><h1><tt>LOG-IN REJECTED</tt></h1></font>
                            <font face="arial">Your browser may be configured in a way that prevents logging 
                                               in to this website.</font><br>
                            <br>
                            <font face="arial">Check your browser's security and privacy settings.</font><br>
                            <br>
                            <font face="arial" color="grey">Typically adding this website to your list of trusted sites and 
                            enabling cookies should be sufficient. Check your browser's help pages for step-by-step
                            instructions.</font><br>
                        </center>
                    </td></tr>
                    <tr><td>
                        <font face="arial"><u>Advice For Microsoft Internet Explorer 11</u></font><br>
                        <font face="arial" color="grey">
                            <ol>
                                <li>Choose Internet Options from the Tools menu (either click the gear/cog button, or press ALT+X).</li>
                                <li>In Internet Options dialog's Privacy tab click Sites.</li>
                                <li>In the Privacy Actions dialog, enter the IP-address or URL of this web-site then click Allow.</li>
                                <li>Click OK to close Privacy Actions dialog</li>
                                <li>Click OK on the Internet Options</li>
                                <li>Close all IE windows then restart IE</li>
                            </ol>
                        </font>
                        <br>
                    </td></tr>
                </table>
                
                <!-- END NO_COOKIES -->
                <!-- BEGIN LOGIN_FORM -->
                <form action="do.login.php" method="POST" name="FormLogin" target="_top" accept-charset="ISO-8859-1">
                <blockquote>Log in</blockquote>
                <table class="M1" align="center" border="1" cellspacing="6">
                    <tr><td class="M2">
                        <table class="M3" align="center" cellspacing="0" cellpadding="4">
                        <tr>
                            <td width="145" class="rb">{USER_NAME_PROMPT}</td>
                            <td class="bb">&nbsp;</td>
                            <td width="20" class="lb">1.</td>
                            <td width="207" class="m4">
                                <select name="USER" tabindex="1" >
                                    <!-- BEGIN ADD_USER -->
                                    <option>{USER}</option>
                                    <!-- END ADD_USER -->>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="rb">{PASSWORD_PROMPT}</td>
                            <td class="bb">&nbsp;</td>
                            <td class="lb">2.</td>
                            <td class="m4">
                                <input type="password" size="29"
                                    maxlength="{PASSWORD_LENGTH}"
                                    name="PASSWORD"
                                    value=""
                                    tabindex="2" >
                            </td>
                        </tr>
                        <tr>
                            <td width="145" class="rb">{LANGUAGE_PROMPT}</td>
                            <td class="bb">&nbsp;</td>
                            <td width="20" class="lb">3.</td>
                            <td width="207" class="m4">
                                <select name="LANGUAGE" tabindex="3" >
                                    <!-- BEGIN ADD_LANGUAGE -->
                                    <option>{LANGUAGE}</option>
                                    <!-- END ADD_LANGUAGE -->>
                                </select>
                            </td>
                        </tr>
                        </table>
                    </td></tr>
                </table>
                <table class="F1" align="center" cellspacing="0">
                <tr>
                    <td>{MESSAGE}</td>
                    <td id="f3" align="center" width="140" name="submitButton">
                        <input
                            type="submit"
                            value="Log in"
                            tabindex = "3" >
                    </td>
                </tr>
                </table>
                </form>
                <!-- END LOGIN_FORM -->
            </td>
        </tr>
    </table>
</body>
</html>
