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
        <!-- BEGIN CLOUD_FORM -->
        <form action="do.cloud.php" method="post" name="FormCloudConfiguration" id=
        "FormCloudConfiguration" accept-charset="ISO-8859-1">
          <blockquote>{TITLE}</blockquote>

          <table class="M1" align="center" border="1" cellspacing=
          "6">
            <tr>
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                <!-- BEGIN CLOUD_ENTRY -->
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_ENABLED}</td>

                    <td class="bb">{PARAM_DISPLAY_ENABLED_VALUE}&nbsp;</td>

                    <td width="20" class="lb">1.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[CloudEnabled]" {PARAM_ENABLED} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[CloudEnabled]" {PARAM_DISABLED} value="RADIO_NO">NO
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_STATUS}</td>

                    <td class="bb">{PARAM_DISPLAY_CLOUD_STATUS}&nbsp;</td>

                    <td width="20" class="lb"></td>

                    <td width="130" class="m4">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_ADDRESS}</td>

                    <td class="bb">{PARAM_DISPLAY_CLOUD_ADDRESS}&nbsp;</td>

                    <td width="20" class="lb">2.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[CloudAddress]" size="40" maxlength="80" value="{PARAM_DISPLAY_CLOUD_ADDRESS}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_PORT}</td>

                    <td class="bb">{PARAM_DISPLAY_CLOUD_PORT}&nbsp;</td>

                    <td width="20" class="lb">3.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[CloudPort]" size="40" maxlength="80" value="{PARAM_DISPLAY_CLOUD_PORT}">
                    </td>
                  </tr>

                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_USERNAME}</td>

                    <td class="bb">{PARAM_DISPLAY_CLOUD_USERNAME}&nbsp;</td>

                    <td width="20" class="lb">3.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[CloudUsername]" size="40" maxlength="80" value="{PARAM_DISPLAY_CLOUD_USERNAME}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_PASSWORD}</td>

                    <td class="bb">{PARAM_DISPLAY_CLOUD_PASSWORD}&nbsp;</td>

                    <td width="20" class="lb">3.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[CloudPassword]" size="40" maxlength="80" value="{PARAM_DISPLAY_CLOUD_PASSWORD}">
                    </td>
                  </tr>

                  <!-- END CLOUD_ENTRY -->
                </table>
              </td>
            </tr>
          </table>
          <table class="F1" align="center" cellspacing="0">
            <tr>
              <td id="{ERROR_ID}_TD" width="85%">{SESSION_ERROR_MESSAGE}</td>
              <td id="f3" align="center" width="140" name="submitButton">{SUBMIT_ENTRY}</td>
            </tr>
            </table>
            <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{HIDDEN_TIMENOW}" >
            <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{HIDDEN_SESSION}" >
        </form>
        <!-- END CLOUD_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
