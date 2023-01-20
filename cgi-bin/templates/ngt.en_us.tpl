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
        <!-- BEGIN NGT_FORM -->
        <form action="do.ngt.php" method="post" name="FormNightVolume" id=
        "FormNightVolume" accept-charset="ISO-8859-1">
          <blockquote>{TITLE}
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

                  <tr>
                    <td class="rb">{DAY_OUTBOUND_TALK_VOL}</td>

                    <td class="bb">{DAY_OUTBOUND_TALK_VOL_VALUE}</td>

                    <td class="lb">&nbsp;</td>

                    <td width="30" class="m4">&nbsp;
                        <input type="hidden" 
                            name="{DAY_OUTBOUND_TALK_VOL_PARAM_NAME}"
                            value="{DAY_OUTBOUND_TALK_VOL_VALUE}" >
                    </td>

                    <td class="bb">{DAY_OUTBOUND_TALK_VOL_VALUE_L2}</td>

                    <td class="lb">&nbsp;</td>

                    <td width="30" class="m4">&nbsp;
                        <input type="hidden" 
                            name="{DAY_OUTBOUND_TALK_VOL_PARAM_NAME_L2}"
                            value="{DAY_OUTBOUND_TALK_VOL_VALUE_L2}" >
                    </td>
				  </tr>
				
                  <!-- BEGIN FORM_ENTRY -->
                  <tr>
                    <td class="rb" width="390" height="25">{PARAM_DISPLAY_NAME}</td>

                    <td class="bb">{PARAM_DISPLAY_VALUE}</td>

                    <td class="lb" width="20">{ENTRY_NO}.</td>

                    <td width="30" class="m4">
                      <!-- BEGIN FORM_TEXT -->
                      <input type="text"
                        {TEXT_DISABLED}
                        name="params[{TEXT_PARAM_NAME}]" size="2" maxlength="2"
                        value="{TEXT_DISPLAY_VALUE}">
                    </td>

                    <td class="bb">{PARAM_DISPLAY_VALUE_L2}</td>

                    <td class="lb" width="20">{ENTRY_NO_L2}.</td>

                    <td width="30" class="m4">
                      <!-- BEGIN FORM_TEXT -->
                      <input type="text"
                        {TEXT_DISABLED}
                        name="params[{TEXT_PARAM_NAME_L2}]" size="2" maxlength="2"
                        value="{TEXT_DISPLAY_VALUE_L2}">
                      <!-- END FORM_TEXT -->
                    </td>
                  </tr>
                  <!-- END FORM_ENTRY -->
                </table>
              </td>
            </tr>
          </table>
          <table class="F1" align="center" cellspacing="0">
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
        <!-- END NGT_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
