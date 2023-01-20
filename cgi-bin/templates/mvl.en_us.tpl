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
        <!-- BEGIN MVL_FORM -->
        <form action="do.mvl.php" method="post" name="FormMonitorVolume" id=
        "FormMonitorVolume" accept-charset="ISO-8859-1">
          <blockquote>{TITLE}</blockquote>

          <table class="M1" id="m1a" align="center" border="1"
          cellspacing="6">
            <tr>
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
				  <tr>
                  <th class="th1a"></th>
                  <th class="th1a" colspan="6"><span class="th1b">{L1HEAD}</span></th>
                  <th class="th1a" colspan="6"><span class="th1b">{L2HEAD}</span></th>
				  </tr>
                  <tr>
                    <th class="th1a">Type</th>

                    <th class="th1" colspan="3">Volume</th>

                    <th class="th1" colspan="3">State</th>

                    <th class="th1" colspan="3">Volume</th>

                    <th class="th1" colspan="3">State</th>
                  </tr>

                  <!-- BEGIN MVL_ENTRY -->
                  <tr>
                    <td width="170" class="rb">{PARAM_DISPLAY_NAME}</td>

                    <td class="bb">&nbsp;{PARAM_DISPLAY_VALUE}
                    </td>

                    <td width="20" class="lb">{ENTRY_A}.</td>

                    <td width="62" class="m4"><input type="text"
                    name="params[{PARAM_NAME}][volume]" size="4" maxlength="3"
                    value="{PARAM_DISPLAY_VALUE}"></td>

                    <td class="bb">&nbsp;{PARAM_STATE_VALUE}
                    </td>

                    <td width="20" class="lb">{ENTRY_B}.</td>

                    <td width="100" class="m4"><input type="radio"
                    name=
                    "params[{PARAM_NAME}][state]" {RADIO_CHECKED_ON}
                    value="1">{RADIO_VALUE_DISPLAY_ON}&nbsp;&nbsp;|<input type="radio"
                    name=
                    "params[{PARAM_NAME}][state]" {RADIO_CHECKED_OFF}
                    value="0">{RADIO_VALUE_DISPLAY_OFF}</td>

                    <td class="bb">&nbsp;{PARAM_DISPLAY_VALUE_L2}
                    </td>

                    <td width="20" class="lb">{ENTRY_C}.</td>

                    <td width="62" class="m4"><input type="text"
                    name="paramsL2[{PARAM_NAME}][volume]" size="4" maxlength="3"
                    value="{PARAM_DISPLAY_VALUE_L2}"></td>

                    <td class="bb">&nbsp;{PARAM_STATE_VALUE_L2}
                    </td>

                    <td width="20" class="lb">{ENTRY_D}.</td>

                    <td width="100" class="m4"><input type="radio"
                    name=
                    "paramsL2[{PARAM_NAME}][state]" {RADIO_CHECKED_ON_L2}
                    value="1">{RADIO_VALUE_DISPLAY_ON_L2}&nbsp;&nbsp;|<input type="radio"
                    name=
                    "paramsL2[{PARAM_NAME}][state]" {RADIO_CHECKED_OFF_L2}
                    value="0">{RADIO_VALUE_DISPLAY_OFF_L2}</td>
				  </tr>
                  <!-- END MVL_ENTRY -->
                  <!-- BEGIN MVL_MIX_ENTRY -->
                  <tr>
                    <td width="390" height="25" class="rb">{PARAM_DISPLAY_NAME}</td>
                    <td class="bb">&nbsp;{PARAM_DISPLAY_VALUE}
                    </td>
                    <td width="20" class="lb">{ENTRY_A}.</td>
                    <td colspan="10" width="110" class="m4"><input type="radio"
                    name=
                    "params[{PARAM_NAME}][state]" {RADIO_CHECKED_ON}
                    value="1">{RADIO_VALUE_DISPLAY_ON}&nbsp;&nbsp;|<input type="radio"
                    name=
                    "params[{PARAM_NAME}][state]" {RADIO_CHECKED_OFF}
                    value="0">{RADIO_VALUE_DISPLAY_OFF}</td>
                  </tr>
                  <!-- END MVL_MIX_ENTRY -->
                </table>
              </td>
            </tr>
          </table>
          <table class="F1" id="f1a" align="center" cellspacing="0">
            <tr>
              <td id="{ERROR_ID}_TD">
                  <td>{SESSION_ERROR_MESSAGE}</td>
              <td id="f3" align="center" width="140" name="submitButton">
                      {SUBMIT_ENTRY}
              </td>
            </tr>
            </table>
            <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{HIDDEN_TIMENOW}" >
            <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{HIDDEN_SESSION}" >
        </form>
        <!-- END MVL_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
