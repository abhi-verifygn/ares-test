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
            <!-- BEGIN LCA_FORM -->
            <form onSubmit=''  action="do.lca.php" method="POST" name="FormLocation" accept-charset="ISO-8859-1">
            <blockquote>{TITLE}</blockquote>
            <table class="M1" align="center" border="1" cellspacing="6">
                <tr><td class="M2">
                    <table id="tableData" class="M3" align="center" cellspacing="0" cellpadding="4">
                        <!-- BEGIN LCA_ROW -->
                        <tr>
                            <td width="145" class="rb">{PARAM_NAME}</td>
                            <td class="bb" id="{PARAM_ID}_TD">{PARAM_CURRENT_VALUE}&nbsp;</td>
                            <td width="20" class="lb">{ROW_NO}</td>
                            <td width="207" class="m4">
                                <input type="text" size="29"
                                    maxlength="{PARAM_VALUE_MAX_LENGTH}"
                                    name="{PARAM_ID}"
                                    id="{PARAM_ID}_INPUT"
                                    value="{PARAM_UPDATED_VALUE}" >
                            </td>
                        </tr>
                        <!-- END LCA_ROW -->
                    </table>
                </td></tr>
            </table>
            <table class="F1" align="center" cellspacing="0">
                <tr>
                    <td id="{ERROR_ID}_TD">{SESSION_ERROR_MESSAGE}</td>
                    <td id="f3" align="center" width="140" name="submitButton">
                        {SUBMIT_ENTRY}
                    </td>
                </tr>
            </table>
            <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{HIDDEN_TIMENOW}" >
            <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{HIDDEN_SESSION}" >
            </form>
            <!-- END LCA_FORM -->
        </td>
    </tr>
    </table>
</body>
</html>
