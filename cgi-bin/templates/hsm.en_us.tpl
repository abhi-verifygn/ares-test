<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
  <meta name="generator" content=
  "HTML Tidy for Linux/x86 (vers 25 March 2009), see www.w3.org">
  <meta http-equiv="Content-Type" content=
  "text/html; charset=ISO-8859-1">
  <link rel="stylesheet" type="text/css" href="../../styles/css.css">
  <script src="do.hsm.js"></script>
  <script type="text/javascript" src="load.js">
  <title></title>
</script>
</head>
<!-- BEGIN HSM_BODY -->
<body onload="var timeStamp = '{BDY_TIMENOW}'; var sessionID = '{BDY_SESSION}';">

  <img src="../images/popup_bg.gif" style="display:none;">

  <div id='blockScreen' class='blockScreen'>
    &nbsp;
  </div>

  <div id='loading_popup' class='popup'>
    <div id='loading_top' class='top'><img src='../images/working.gif'></div>

    <div id='loading_bottom' class='bottom'>
      <br>
      Applying changes...
    </div>
  </div>

  <div id='openbase_popup' class='popup'>
    <div id='openbase_top' class='toptitle'>
      <a href='#' onclick='close_openbase_popup()'>X</a>
    </div>

    <div id='openbase_bottom' class='bottom'>
      <div id="trackstate">
        Opening Base...
      </div><input type="submit" value="Close Base" onclick=
      'boClosing = true;trigger_Req("CLOSED", "{BDY_TIMENOW}", "{BDY_SESSION}" )'>
    </div>
  </div>
<!-- END HSM_BODY -->

  <table class="MMM">
    <tr>
      <td>
        <!-- BEGIN HSM_FORM -->
        <form action="do.hsm.php" method="post" name="ClearInactDay" id=
        "ClearInactDay">
          <blockquote>
            {TITLE}
          </blockquote>
          <table class="F1" align="center" cellspacing="0">
            <tr>
              <td id="{ERROR_ID}_TD" width="85%">{SESSION_ERROR_MESSAGE}</td>
              <td id="f3" align="center" width="140" name="submitButton">
                      {SUBMIT_ENTRY}
              </td>
            </tr>
            </table>
          <table class="M1" align="center" border="1" cellspacing=
          "6">
            <tr>
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                    <td class="rb" width="20">#</td>

                    <td width="100" class="rb">{SERIAL_NUMBER}</td>

                    <td class="rb" colspan="3">{NAME}</td>

                    <td width="150" class="rb">{SOFTWARE_VERSION}</td>

                    <td width="100" class="rb">{INACTIVE_DAYS}</td>

                    <td class="rb">{CLEAR}</td>
                  </tr>
                  <!-- BEGIN HSM_ROW -->
                  <tr>
                    <td class="rb" width="20">{ID}.</td>

                    <td class="bb">{HEADSET_SERIAL}
                    </td>

                    <td class="bb2" colspan="1">&nbsp;
                    {HEADSET_NAME}
                    &nbsp;</td>

                    <td class="lb" colspan="1">{ID}.</td>

                    <td class="m4" colspan="1"><input type="text"
                    name="headset[{ID}][Name]" size="13" maxlength="12"
                    id="headset_{ID}_Name"
                    value="{HEADSET_NAME}"></td>

                    <td class="bb">{HEADSET_SW_VERSION}
                    </td>

                    <td class="bb">{HEADSET_DAYS_INACTIVE}
                    </td>

                    <td class="m4"><input type="checkbox" name=
                    "headset[{ID}][Clear]" value="true"></td>
                  </tr>
                  <!-- END HSM_ROW -->
                </table>

                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                    <td class="th1a" colspan="5">&nbsp;</td>
                  </tr>

                  <tr>
                    <td width="200" class="rb">{BASE_STATUS_LABEL}</td>

                    <td class="bb">{BASE_IS_OPEN}
                    </td>

                    <td class="m4" width="250"><input type='submit'
                    onclick='open_openbase_popup("{HIDDEN_TIMENOW}","{HIDDEN_SESSION}");return false;'
                    value='{BASE_STATUS_CAPTION}'></td>

                    <td width="200" class="rb">{DEREGISTER_HANDSET}#</td>

                    <td class="m4" width="120"><select name=
                    "deregisterHeadset" size="1">
                      <option value="">
                        -{SELECT_HANDSET}-
                      </option>
                      <!-- BEGIN HSM_OPTION -->
                      <option value="{DEREGISTER_ID}">
                        {DEREGISTER_ID}
                      </option>
                      <!-- END HSM_OPTION -->
                    </select></td>
                  </tr>
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
        <!-- END HSM_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
