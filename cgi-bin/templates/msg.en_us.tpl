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
  <script type="text/javascript" src="../load.js">
</script>
  <script type="text/javascript">
if (<?=$938_menuBarAutoRefresh?>)
  {
  parent.menu.window.location.reload();
  }
  </script>
</head>

<body>
  <img src="popup_bg.gif" style="display:none;">

  <div id='blockScreen' class='blockScreen'>
    &nbsp;
  </div>

  <div id='loading_popup' class='popup'>
    <div id='loading_top' class='top'><img src='working.gif'></div>

    <div id='loading_bottom' class='bottom'>
      <p>Applying changes...</p>
    </div>
  </div>

  <table class="MMM">
    <tr>
      <td>
        <!-- BEGIN MSG_FORM -->
        <form action="do.msg.php" method="post" name="FormGreeterSetup" id=
        "FormGreeterSetup" accept-charset="ISO-8859-1">
          <blockquote>{TITLE}
          </blockquote>

          <!--<table class="F1" align="center" cellspacing="0">
            <tr>
              <td><?=$477_LAST_ERROR_MESSAGE?>
              </td>

              <td id="f3" align="center" width="140"><input type=
              "submit" name="936_GrtAction" value="Apply Changes"
              onclick='show_popup("loading_popup")'></td>
            </tr>
          </table> -->
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
                    <td class="rb" colspan="3">{LABEL_GREETER_INSTALLED}</td>

                    <td class="bb" colspan="5">
                    {GREETER_PRESENT}
                    &nbsp;</td>

                    <td class="lb">&nbsp;</td>

                    <td class="m4" colspan="3">&nbsp;</td>
                  </tr>

                  <tr>
                    <td class="rb" colspan="3">{LABEL_PLAYBACK_DELAY}<span class="th1c">*</span></td>

                    <td class="bb" colspan="5">
                    {PLAYBACK_DELAY_VALUE}
                    &nbsp;</td>

                    <td class="lb">1.</td>

                    <td class="m4" colspan="3"><input type="text"
                    name="msg[playbackDelay]" size="3" maxlength=
                    "3" value=
                    "{PLAYBACK_DELAY_VALUE}"></td>
                  </tr>

                  <tr>
                    <td class="rb" colspan="3">{LABEL_PLAYBACK_TO_HEADSETS}</td>

                    <td class="bb" colspan="5">
                    {PLAYBACK_TO_HEADSETS_VALUE}
                    &nbsp;</td>

                    <td class="lb">2.</td>

                    <td class="m4" colspan="3"><input type="radio"
                    name=
                    "msg[playbackToHeadsets]" {PLAYBACK_TO_HEADSETS_YES}
                    value="1">{RADIO_YES}&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "msg[playbackToHeadsets]" {PLAYBACK_TO_HEADSETS_NO}
                    value="0">{RADIO_NO}</td>
                  </tr>

                  <tr>
                    <td class="rb" colspan="3">{LABEL_PLAYBACK_THRU_MONITOR}</td>

                    <td class="bb" colspan="5">
                    {PLAYBACK_THRU_MONITOR_VALUE}
                    &nbsp;</td>

                    <td class="lb">3.</td>

                    <td class="m4" colspan="3"><input type="radio"
                    name=
                    "msg[playbackThruMonitor]" {PLAYBACK_THRU_MONITOR_YES}
                    value="1">{RADIO_YES}&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "msg[playbackThruMonitor]" {PLAYBACK_THRU_MONITOR_NO}
                    value="0">{RADIO_NO}</td>
                  </tr>

                  <tr>
                    <td class="rb" colspan="3">{LABEL_TONE_DURING_PLAYBACK}</td>

                    <td class="bb" colspan="5">
                    {TONE_DURING_PLAYBACK_VALUE}
                    &nbsp;</td>

                    <td class="lb">4.</td>

                    <td class="m4" colspan="3"><input type="radio"
                    name=
                    "msg[toneDuringPlayback]" {TONE_DURING_PLAYBACK_YES}
                    value="1">{RADIO_YES}&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "msg[toneDuringPlayback]" {TONE_DURING_PLAYBACK_NO}
                    value="0">{RADIO_NO}</td>
                  </tr>

                  <tr>
                    <td class="rb" colspan="3">{LABEL_PLAY_RESTAURANT_CLOSED_MSG}</td>

                    <td class="bb" colspan="5">
                    {PLAY_RESTAURANT_CLOSED_MSG_VALUE}
                    &nbsp;</td>

                    <td class="lb">5.</td>

                    <td class="m4" colspan="3"><input type="radio"
                    name=
                    "msg[playClosedMsg]" {PLAY_RESTAURANT_CLOSED_MSG_YES}
                    value="1">{RADIO_YES}&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "msg[playClosedMsg]" {PLAY_RESTAURANT_CLOSED_MSG_NO}
                    value="0">{RADIO_NO}</td>
                  </tr>

                  <tr>
                    <td class="rb" colspan="3">{LABEL_PLAY_EXT_DET_MSG}</td>

                    <td class="bb" colspan="5">
                    {PLAY_EXT_DET_MSG_VALUE}
                    &nbsp;</td>

                    <td class="lb">6.</td>

                    <td class="m4" colspan="3"><select name=
                    "msg[playExtDetMsg]" size="1">
                      <option value="">
                        -- {LABEL_SELECT_HERE} --
                      </option>

                      <option value="0">
                        {PLAY_EXT_DET_MSG_OFF}
                      </option>
                    <!-- BEGIN PLAY_EXT_DET_MSG_OPTION -->
                      <option value="{PEDM_MSG_ID}">
                        {PEDM_MSG_NAME}
                      </option>
                    <!-- END PLAY_EXT_DET_MSG_OPTION -->
                    <!--
                      <option value="1">
                        Message #1
                      </option>

                      <option value="2">
                        Message #2
                      </option>

                      <option value="3">
                        Message #3
                      </option>

                      <option value="4">
                        Message #4
                      </option>

                      <option value="5">
                        Message #5
                      </option>

                      <option value="6">
                        Message #6
                      </option>

                      <option value="7">
                        Message #7
                      </option>

                      <option value="8">
                        Message #8
                      </option>

                      <option value="9">
                        Message #9
                      </option>

                      <option value="10">
                        Message #10
                      </option>

                      <option value="11">
                        Message #11
                      </option>

                      <option value="12">
                        Message #12
                      </option>

                      <option value="13">
                        Message #13
                      </option>

                      <option value="14">
                        Message #14
                      </option>

                      <option value="15">
                        Message #15
                      </option>

                      <option value="16">
                        Message #16
                      </option>   -->
                    </select></td>
                  </tr>

                  <tr>
                    <td class="rb" colspan="3">{LABEL_TANDEM_PULL_AHEAD_MSG}<span class="th1c">**</span></td>

                    <td class="bb" colspan="5">
                    {TANDEM_PULL_AHEAD_MSG_VALUE}
                    &nbsp;</td>

                    <td class="lb">7.</td>

                    <td class="m4" colspan="3"><input type="radio"
                    name=
                    "msg[tandemPullHead]" {TANDEM_PULL_AHEAD_MSG_YES}
                    value="1">{RADIO_YES}&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "msg[tandemPullHead]" {TANDEM_PULL_AHEAD_MSG_NO}
                    value="0">{RADIO_NO}</td>
                  </tr>

                  <tr>
                    <td class="rb" colspan="3">{LABEL_PLAYBACK_MODE}</td>

                    <td class="bb" colspan="5">
                    {PLAYBACK_MODE_VALUE}
                    &nbsp;</td>

                    <td class="lb">8.</td>

                    <td class="m4" colspan="3"><select name=
                    "msg[playbackMode]" size="1">
                      <option value="">
                        -- {LABEL_SELECT_HERE} --
                      </option>

                      <option value="0">
                        {PLAY_MODE_ALTERNATING}
                      </option>

                      <option value="1">
                        {PLAY_MODE_ONCE_EACH}
                      </option>
                    </select></td>
                  </tr>

                  <tr>
                    <td class="bg2" colspan="12">* <span class=
                    "th1d">{LABEL_ONE_STAR}</span><br>
                    **<span class="th1d">{LABEL_TWO_STARS}</span></td>
                  </tr>
                </table>

                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <!--************************************************* Message 1 *****************************************************-->
                  <!-- BEGIN MSG_ROW -->
                  <tr>
                    <th class="th1">
                      <center>
                        {LABEL_MSG}
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_NAME}
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        {LABEL_TYPE}
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        {LABEL_DURATION}<span class="th1b">{LABEL_SECONDS}</span>
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_ENABLED}
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="rb">
                      <center>
                        #{ROW_MSG_ID}&nbsp;
                      </center>
                    </td>

                    <td class="bb" colspan="3">
                    {ROW_MSG_NAME}
                    &nbsp;</td>

                    <td class="bb" colspan="2">
                    {ROW_MSG_TYPE}
                    &nbsp;</td>

                    <td class="bb" colspan="2">
                    {ROW_MSG_DURATION}
                    &nbsp;</td>

                    <td class="bb">
                    {ROW_MSG_ENABLED}
                    &nbsp;</td>

                    <td class="lb">{ROW_MSG_ENTRY}.</td>

                    <td class="m4"><input type="radio" name=
                    "msg[enabled][{ROW_MSG_ID}]" {ROW_MSG_ENABLED_YES}
                    value="1">{MSG_RADIO_YES}&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "msg[enabled][{ROW_MSG_ID}]" {ROW_MSG_ENABLED_NO}
                    value="0">{MSG_RADIO_NO}</td>
                  </tr>
                  <!-- END MSG_ROW -->
                </table>
              </td>
            </tr>
          </table>

          <!--<table class="F1" align="center" cellspacing="0">
            <tr>
              <td><?=$477_LAST_ERROR_MESSAGE?>
              </td>

              <td id="f3" align="center" width="140"><input type=
              "submit" name="936_GrtAction" value="Apply Changes"
              onclick='show_popup("loading_popup")'></td>
            </tr> -->
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
        <!-- END MSG_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
