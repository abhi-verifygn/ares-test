<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
  <meta name="generator" content=
  "HTML Tidy for Linux/x86 (vers 25 March 2009), see www.w3.org">
  <meta http-equiv="Content-Type" content=
  "text/html; charset=charset=ISO-8859-1">
  <link rel="stylesheet" type="text/css" href=
  "../../styles/css.css">

  <title></title>
</head>

<body>
  <table class="MMM">
    <tr>
      <td>
        <!-- BEGIN NOI_FORM -->
        <form action="do.noi.php" method="post" name="FormNoiseReduction" id=
        "FormNoiseReduction" accept-charset="ISO-8859-1">
          <blockquote>
            {TITLE}
          </blockquote>

          <table class="M1" align="center" border="1" cellspacing=
          "6">
            <tr>
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                  <th class="th1a"></th>
                  <th class="th1a" colspan="3"><span class="th1b">{L1HEAD}</span></th>
                  <th class="th1a" colspan="3"><span class="th1b">{L2HEAD}</span></th>
                  </tr>
                <!-- BEGIN NOI_ENTRY -->
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_NAME}</td>

                    <td class="bb">{PARAM_DISPLAY_VALUE}
                    &nbsp;</td>

                    <td width="20" class="lb">{ENTRY_NO}.</td>

                    <td width="118" class="m4"><select name=
                    "params[{PARAM_NAME}]" size="1">
                      <option value="" selected >
                        {SELECT_HERE}
                      </option>

                      <option value="">
                        -------------------
                      </option>
                      <!-- BEGIN NOI_OPTIONS -->
                      <option value="{OPTION_ID}">
                        {OPTION_DISPLAY_VALUE}
                      </option>
                      <!-- END NOI_OPTIONS -->
                    </select></td>

                    <td class="bb">{PARAM_DISPLAY_VALUE_L2}
                    &nbsp;</td>

                    <td width="20" class="lb">{ENTRY_NO_L2}.</td>

                    <td width="118" class="m4"><select name=
                    "params[{PARAM_NAME_L2}]" size="1">
                      <option value="" selected >
                        {SELECT_HERE}
                      </option>

                      <option value="">
                        -------------------
                      </option>
                      <!-- BEGIN NOI_OPTIONS_L2 -->
                      <option value="{OPTION_ID_L2}">
                        {OPTION_DISPLAY_VALUE}
                      </option>
                      <!-- END NOI_OPTIONS_L2 -->
                      </select></td> 
                  </tr>
                  <!-- END NOI_ENTRY -->
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
        <!-- END NOI_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
