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
  <!-- BEGIN INS_BODY -->
  <table class="MMM">
    <tr>
      <td>
        <blockquote>
          {TITLE}
        </blockquote>
        <!-- BEGIN INS_ACTIONS_FORM -->
        <form action="do.ins_action.php" method="post" name="InstallerAction"
         id="InstallerAction" accept-charset="ISO-8859-1">
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

                    <td class="m4">{LABEL_RESET}</td>

                    <td class="m4"><input type="radio" name=
                    "baseRestart" {RESET_CHECKED}
                    value="{RADIO_FACTORY}"></td>
                  </tr>

                  <tr>
                    <td class="lb" width="17">2.</td>

                    <td class="m4">{LABEL_LOAD}</td>

                    <td class="m4"><input type="radio" name=
                    "baseRestart" {LOAD_CHECKED}
                    value="{RADIO_LOAD}"></td>
                  </tr>

                  <tr>
                    <td class="lb" width="17">3.</td>

                    <td class="m4">{LABEL_SAVE}</td>

                    <td class="m4"><input type="radio" name=
                    "baseRestart" {SAVE_CHECKED}
                    value="{RADIO_SAVE}"></td>
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
            <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{INS_ACTIONS_HIDDEN_TIMENOW}" >
            <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{INS_ACTIONS_HIDDEN_SESSION}" >
        </form>
        <!-- END INS_ACTIONS_FORM  -->

        <!-- BEGIN INS_SETTINGS_FORM -->
        <form action="do.ins_settings.php" method="post" name="InstallerSetting"
         id="InstallerSetting" accept-charset="ISO-8859-1">
          <table class="M1" align="center" border="1" cellspacing=
          "6">
            <tr>
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <!-- BEGIN INS_SETTINGS_ENTRY -->
                  <tr>
                    <td class="rb" height="25">{PARAM_DISPLAY_NAME}</td>

                    <td class="bb">{PARAM_DISPLAY_VALUE}&nbsp;</td>

                    <td class="lb" width="20">{ENTRY_NO}.</td>

                    <td width="250" class="m4">
                      <!-- BEGIN INS_SETTINGS_TEXT -->
                      <input type="text"
                        name="params[{TEXT_PARAM_NAME}]" size="{TEXT_DISPLAY_LENGTH}" maxlength="{TEXT_DISPLAY_LENGTH}"
                        value="{TEXT_DISPLAY_VALUE}">
                      <!-- END INS_SETTINGS_TEXT -->
                      <!-- BEGIN INS_SETTINGS_SELECT -->
                      <select name="params[{SELECT_PARAM_NAME}]">
                      <option value="">
                        {SELECT_HERE}
                      </option>

                      <option value="">
                        --------------------
                      </option>
                      <!-- BEGIN INS_SETTINGS_OPTION_SELECT -->
                      <option value="{OPTION_ID}">
                        {OPTION_DISPLAY_VALUE}
                      </option>
                      <!-- END INS_SETTINGS_OPTION_SELECT -->
                      </select>
                      <!-- END INS_SETTINGS_SELECT -->
                      <!-- BEGIN INS_SETTINGS_RADIO -->
                        <input type="radio"
                            name="params[{RADIO_PARAM_NAME}]" {RADIO_CHECKED}
                            value="{RADIO_VALUE}">{RADIO_VALUE_DISPLAY}
                        <!-- BEGIN INS_SETTINGS_RADIO_SEPARATOR -->
                        &nbsp;&nbsp;|&nbsp;
                        <!-- END INS_SETTINGS_RADIO_SEPARATOR -->
                      <!-- END INS_SETTINGS_RADIO -->
                    </td>
                  </tr>
                  <!-- END INS_SETTINGS_ENTRY -->
                </table>
              </td>
            </tr>
          </table>
          <table class="F1" align="center" cellspacing="0">
            <tr>
              <td></td>
              <td id="f3" align="center" width="140" name="submitButton">
                      {SUBMIT_ENTRY}
              </td>
            </tr>
            </table>
            <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{INS_SETTINGS_HIDDEN_TIMENOW}" >
            <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{INS_SETTINGS_HIDDEN_SESSION}" >
        </form>
        <!-- END INS_SETTINGS_FORM -->
        <table class="F1" align="center" cellspacing="0">
          <tr><td></td>
            <td  id="{ERROR_ID}_TD">{SESSION_ERROR_MESSAGE}</td>
          </tr>
          </table>
      </td>
    </tr>
  </table>
  <!-- END INS_BODY -->
</body>
</html>
