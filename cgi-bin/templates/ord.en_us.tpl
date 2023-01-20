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
        <!-- BEGIN ORD_FORM -->
        <form action="do.ord.php" method="post" name="FormOrderSetup" id=
        "FormOrderSetup" accept-charset="ISO-8859-1">
          <blockquote>{TITLE}</blockquote>

          <table class="M1" align="center" border="1" cellspacing=
          "6">
            <tr>
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <!-- BEGIN FORM_ENTRY -->
                  <tr>
                    <td class="rb" width="390" height="25">{PARAM_DISPLAY_NAME}</td>

                    <td class="bb">{PARAM_DISPLAY_VALUE}&nbsp;</td>

                    <td class="lb" width="20">{ENTRY_NO}.</td>

                    <td width="110" class="m4">
                      <!-- BEGIN FORM_TEXT -->
                      <input type="text"
                        name="params[{TEXT_PARAM_NAME}]" size="3" maxlength="3"
                        value="{TEXT_DISPLAY_VALUE}">
                      <!-- END FORM_TEXT -->
                      <!-- BEGIN FORM_SELECT -->
                      <select name="params[{SELECT_PARAM_NAME}]">
                      <option value="">
                        {SELECT_HERE}
                      </option>

                      <option value="">
                        --------------------
                      </option>
                      <!-- BEGIN FORM_OPTION_SELECT -->
                      <option value="{OPTION_ID}">
                        {OPTION_DISPLAY_VALUE}
                      </option>
                      <!-- END FORM_OPTION_SELECT -->
                      </select>
                      <!-- END FORM_SELECT -->
                      <!-- BEGIN FORM_RADIO -->
                        <input type="radio"
                            name="params[{RADIO_PARAM_NAME}]" {RADIO_CHECKED}
                            value="{RADIO_VALUE}">{RADIO_VALUE_DISPLAY}
                        <!-- BEGIN FORM_RADIO_SEPARATOR -->
                        &nbsp;&nbsp;|&nbsp;
                        <!-- END FORM_RADIO_SEPARATOR -->
                      <!-- END FORM_RADIO -->
                    </td>
                  </tr>
                  <!-- END FORM_ENTRY -->
                </table>
              </td>
            </tr>
          </table>
          <table class="F1" align="center" cellspacing="0">
            <tr>
              <td id="{ERROR_ID}_TD" width="85%">{SESSION_ERROR_MESSAGE}</td>
              <td id="f3" align="center" width="140" name="submitButton">
                      {SUBMIT_ENTRY}
              </td>
            </tr>
            </table>
            <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{HIDDEN_TIMENOW}" >
            <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{HIDDEN_SESSION}" >
        </form>
        <!-- END ORD_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
