<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
  <meta name="generator" content=
  "HTML Tidy for Linux/x86 (vers 25 March 2009), see www.w3.org">
  <meta http-equiv="Content-Type" content=
  "text/html; charset=utf-8">
  <link rel="stylesheet" type="text/css" href=
  "../../styles/css.css">

  <title></title>
</head>

<body>
  <!-- BEGIN RES_BODY -->
  <table class="MMM">
    <tr>
      <td>
        <blockquote>
          {TITLE}
        </blockquote>
        <!-- BEGIN RES_ACTIONS_FORM -->
        <form action="do.res_action.php" method="post" name="RebootAction"
         id="RebootAction" accept-charset="ISO-8859-1">
          <table class="M1" align="center" border="1" cellspacing=
          "6">
            <tr>
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                    <td class="rb" align="center" colspan="3">
                      <h4>{LABEL_WARNING}</h4>
                    </td>
                  </tr>
                  <tr>
                    <td class="lb" width="17">1.</td>

                    <td class="m4">{LABEL_REBOOT}</td>

                    <td class="m4"><input type="checkbox" name=
                    "baseReboot"
                    value="{RADIO_REBOOT}">{RADIO_REBOOT}</td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>

          <table class="F1" align="center" cellspacing="0">
            <tr><td></td>
              <td id="f3" align="center" width="140" name="submitButton">
                      {EXECUTE_ENTRY}
              </td>
            </tr>
            </table>
            <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{RES_ACTIONS_HIDDEN_TIMENOW}" >
            <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{RES_ACTIONS_HIDDEN_SESSION}" >
        </form>
        <!-- END RES_ACTIONS_FORM  -->

        <table class="F1" align="center" cellspacing="0">
          <tr><td></td>
            <td  id="{ERROR_ID}_TD">{SESSION_ERROR_MESSAGE}</td>
          </tr>
          </table>
      </td>
    </tr>
  </table>
  <!-- END RES_BODY -->
</body>
</html>
