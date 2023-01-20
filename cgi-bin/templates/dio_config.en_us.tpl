<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
  <meta name="generator" content=
  "HTML Tidy for Linux/x86 (vers 25 March 2009), see www.w3.org">
  <meta http-equiv="Content-Type" content=
  "text/html; charset=ISO-8859-1">
  <link rel="stylesheet" type="text/css" href=
  "../../styles/css.css">

  <title></title>
</head>

<body>
  <table class="MMM">
    <tr>
      <td>
        <!-- BEGIN DIO_CFG_FORM -->
        <form action="do.dio_config.php" method="post" name="DIOSetUp" id=
        "DIOSetUp" accept-charset="ISO-8859-1">
          <blockquote>{TITLE}</blockquote>

          <table class="M1" align="center" border="1" cellspacing=
          "6">
            <tr>
              <td class="flh" colspan="9">{CURRENT_SETTING_HEADING}</td>
            </tr>
            <tr>
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <!-- BEGIN HEADING_OLD_ENTRY -->
                  <tr>
                    <td class="rb" width="240" height="25">{PARAM_DISPLAY_NAME}</td>

                    <td class="bb" width="120">{PARAM_DISPLAY_VALUE}&nbsp;</td>

                    <td class="bb">{PARAM_DISPLAY_SOURCE_VALUE}&nbsp;</td>
                  </tr>
                  <!-- END HEADING_OLD_ENTRY -->
                </table>
              </td>
            </tr>
            <tr>
              <td class="flh" colspan="9">{NEW_SETTING_HEADING}</td>
            </tr>
            <tr>
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <!-- BEGIN HEADING_NEW_ENTRY -->
                  <tr>
                    <td class="rb" width="240" height="25">{PARAM_DISPLAY_NAME}</td>
                    <td class="bb" width="120" >{PARAM_DISPLAY_VALUE}&nbsp;</td>
                    <td class="lb">&nbsp;</td>
                  </tr>
                  <!-- END HEADING_NEW_ENTRY -->
                </table>
              </td>
            </tr>
            <tr>  
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                  <!-- BEGIN NEW_SETTING_ENTRY -->
                  <tr> 
                    <td width="150" class="m4" colspan=3>
                    <input type="radio"
                        name="params[{RADIO_SETTING_NAME}]" {RADIO_CHECKED} {RADIO_DISABLED}
                        value="{RADIO_SETTING_VALUE}">{RADIO_VALUE_DISPLAY}
                    </td>
                  </tr>
                  <!-- END NEW_SETTING_ENTRY -->
                </table>
              </td>
            </tr>
          </table>
          <table class="F1" align="center" cellspacing="0">
            <tr>
              <td id="{ERROR_ID}_TD" width="85%">{SESSION_ERROR_MESSAGE}</td>
              <td id="f3" align="center" width="140" name="cancelButton">
                      {CANCEL_ENTRY}
              </td>
              <td id="f3" align="center" width="140" name="submitButton">
                      {SUBMIT_ENTRY}
              </td>
            </tr>
          </table>
          <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{HIDDEN_TIMENOW}" >
          <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{HIDDEN_SESSION}" >
          <input type="hidden" name="pinID"     id="pinID_INPUT"     value="{HIDDEN_PIN_ID}" >
          <input type="hidden" name="direction" id="direction_INPUT" value="{HIDDEN_DIRECTION}" >
        </form>
        <!-- END DIO_CFG_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
