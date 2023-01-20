<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
  <meta name="generator" content=
  "HTML Tidy for Linux (vers 25 March 2009), see www.w3.org">
  <meta http-equiv="Content-Type" content=
  "text/html; charset=ISO-8859-1">
  <link rel="stylesheet" type="text/css" href=
  "../../styles/css.css">

  <title></title>
  <script type="text/javascript" src="load.js">
</script>
  <script type="text/javascript">
var boReload;

  function ConfirmRecord( timestamp, sessionID, msgID )
  {
    if(confirm("Recording a message will delete existing message, do you wish to continue?"))
    {
        boReload=true;
        trigger_Req("RECORD", timestamp, sessionID, msgID );
    }

    return false;
  }

  function open_recplay_popup()
  {
    boReload = false;
    show_popup("recplay_popup");
  }

  function close_recplay_popup()
  {
    hide_popup("recplay_popup");

    if( boReload )
    {
        reload();
    }
  }

  var http;

  function trigger_Req( reqstr, timeStamp, sessionID, msgID )
  {
    var url = "do.act.php";
    var params = "GREETER_OPERATION="+reqstr+"&timestamp="+timeStamp+"&sessionID="+sessionID+"&msgID="+msgID;
    http = null;
    
    document.getElementById("trackstate").innerHTML = "Ready";

    if( window.XMLHttpRequest )
    {// code for IE7+, Firefox, Chrome, Opera, Safari
        http=new XMLHttpRequest();
    }
    else
    {// code for IE6, IE5
        http=new ActiveXObject("Microsoft.XMLHTTP");
    }
    http.open("POST", url, true);

    //Send the proper header information along with the request
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    http.onreadystatechange = on_ReqStateChange;
    http.send(params)
  }

  function on_ReqStateChange()
  {//Call a function when the state changes.
    if(http.readyState == 4 && http.status == 200)
    {
        var doc = http.responseText;
        document.getElementById("trackstate").innerHTML = doc;
    }
  }

  if ( true ) //<?=$938_menuBarAutoRefresh?>)
  {
  parent.menu.window.location.reload();
  }
  </script>
</head>
<!-- BEGIN MSGPROPS_BODY -->
<body onload="var timeStamp = '{BDY_TIMENOW}'; var sessionID = '{BDY_SESSION}';">
  <img src="../../images/popup_bg.gif" style="display:none;">

  <div id='blockScreen' class='blockScreen'>
    &nbsp;
  </div>

  <div id='loading_popup' class='popup'>
    <div id='loading_top' class='top'><img src='../../images/working.gif'></div>

    <div id='loading_bottom' class='bottom'>
      <br>
      Applying changes...
    </div>
  </div>

  <div id='recplay_popup' class='popup'>
    <div id='recplay_top' class='toptitle'>
      <a href='#' onclick='close_recplay_popup()'>X</a>
    </div>

    <div id='recplay_bottom' class='bottom'>
      <div id="trackstate">
        Ready
      </div><input type="submit" style="color:red;" value="Record"
      onclick='return ConfirmRecord("{BDY_TIMENOW}", "{BDY_SESSION}", "{BDY_MSGID}")'> <input type="submit" value=
      "Play" onclick='trigger_Req("PLAY", "{BDY_TIMENOW}", "{BDY_SESSION}", "{BDY_MSGID}")'> <input type="submit"
      value="Stop" onclick='trigger_Req("STOP", "{BDY_TIMENOW}", "{BDY_SESSION}", "{BDY_MSGID}")'>
    </div>
  </div>
<!-- END MSGPROPS_BODY -->
  <table class="MMM">
    <tr>
      <td>
        <!-- BEGIN MSGPROPS_FORM -->
        <form action="do.msgprops.php" method="post" name="FormGreeterSetup" id=
        "FormGreeterSetup" accept-charset="ISO-8859-1">
          <blockquote id="blk1">
            <span class="blk2">{TITLE}</span><span class=
            "bl1">{MSGID}</span>
          </blockquote>
          <table class="F1" align="center" cellspacing="0">
            <tr>
              <td id="{ERROR_ID}_TD" width="85%">{SESSION_ERROR_MESSAGE}</td>
              <td id="f3" align="center" width="140" name="submitButton" onclick='show_popup("loading_popup")'>
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
                    <th class="th1" colspan="1">
                      <center>
                        {LABEL_MESSAGE}
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_NAME}
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_TYPE}
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_ENABLED}
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="rb">#{MSGID}&nbsp;</td>

                    <td class="bb">{MESSAGE_NAME}
                    &nbsp;</td>

                    <td class="lb">{ENTRY_A}.</td>

                    <td class="m4"><input type="text" size="12"
                    maxlength="12" name="message[{MSGID}][name]"
                    value="{MESSAGE_NAME}"></td>

                    <td class="bb">{MESSAGE_TYPE}
                    &nbsp;</td>

                    <td class="lb">{ENTRY_B}.</td>

                    <td class="m4"><select name=
                    "message[{MSGID}][type]" size="1">

                      <option value="ALERT" {TYPE_ALERT_SELECTED}>
                        {MSG_TYPE_ALERT}
                      </option>

                      <option value="REMINDER" {TYPE_RMD_SELECTED}>
                        {MSG_TYPE_REMINDER}
                      </option>

                      <option value="GREETER" {TYPE_GRT_SELECTED}>
                        {MSG_TYPE_GREETER}
                      </option>

                      <option value="CLOSED" {TYPE_CLOSED_SELECTED}>
                        {MSG_TYPE_CLOSED}
                      </option>

                      <option value="FORWARD" {TYPE_FWD_SELECTED}>
                        {MSG_TYPE_FORWARD}
                      </option>

                      <option value="NULL"    {TYPE_NULL_SELECTED}>
                        {MSG_TYPE_NULL}
                      </option>
                    </select></td>

                    <td class="bb">
                    {MESSAGE_ENABLED}
                    &nbsp;</td>

                    <td class="lb">{ENTRY_C}.</td>

                    <td class="m4"><input type="radio" name=
                    "message[{MSGID}][enabled]" {MESSAGE_ENABLED_YES}
                    value="1">{RADIO_YES}&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "message[{MSGID}][enabled]" {MESSAGE_ENABLED_NO}
                    value="0">{RADIO_NO}</td>
                  </tr>

                  <tr>
                    <th class="rb" colspan="1">&nbsp;</th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_PLAY_TO_MONITOR}
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_PRIORITY}
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_DELAY}<span class="th1b">/ mm:ss /</span>
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="rb" colspan="1">&nbsp;</td>

                    <td class="bb">
                    {MESSAGE_MONITOR}
                    &nbsp;</td>

                    <td class="lb">{ENTRY_D}.</td>

                    <td class="m4"><input type="radio" name=
                    "message[{MSGID}][monitor]" {MESSAGE_MONITOR_YES}
                    value="1">{RADIO_YES}&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "message[{MSGID}][monitor]" {MESSAGE_MONITOR_NO}
                    value="0">{RADIO_NO}</td>

                    <td class="bb">
                    {MESSAGE_PRIORITY}
                    &nbsp;</td>

                    <td class="lb">{ENTRY_E}.</td>

                    <td class="m4"><input type="radio" name=
                    "message[{MSGID}][priority]" {MESSAGE_PRIORITY_YES}
                    value="1">{RADIO_YES}&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "message[{MSGID}][priority]" {MESSAGE_PRIORITY_NO}
                    value="0">{RADIO_NO}</td>

                    <td class="bb">{MESSAGE_DELAY}
                    &nbsp;</td>

                    <td class="lb">{ENTRY_F}.</td>

                    <td class="m4"><input type="text" size="12"
                    maxlength="12" name="message[{MSGID}][delay]"
                    value="{MESSAGE_DELAY}"></td>
                  </tr>

                  <tr>
                    <th class="rb" colspan="1">&nbsp;</th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_REPEAT_INTERVAL}<span class="th1b">/
                        hh:mm:ss /</span>
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_REPEAT_COUNT}
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_DURATION}<span class="th1b">/ seconds
                        /</span>
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="rb" colspan="1">&nbsp;</td>

                    <td class="bb">
                    {MESSAGE_REPEAT_INTERVAL}
                    &nbsp;</td>

                    <td class="lb">{ENTRY_G}.</td>

                    <td class="m4"><input type="text" size="12"
                    maxlength="12" name=
                    "message[{MSGID}][repeatInterval]" value=
                    "{MESSAGE_REPEAT_INTERVAL}"></td>

                    <td class="bb">{MESSAGE_REPEAT_COUNT}
                    &nbsp;</td>

                    <td class="lb">{ENTRY_H}.</td>

                    <td class="m4"><input type="text" name=
                    "message[{MSGID}][repeatCount]" size="3"
                    maxlength="3" value=
                    "{MESSAGE_REPEAT_COUNT}"></td>

                    <td class="bb">{MESSAGE_DURATION}
                    &nbsp;</td>

                    <td class="lb">{ENTRY_I}.</td>

                    <td class="m4"><input type="text" name=
                    "message[{MSGID}][duration]" size="3" maxlength=
                    "3" value=
                    "{MESSAGE_DURATION}" DISABLED ></td>
                  </tr>

                  <tr>
                    <th class="rb" colspan="1">&nbsp;</th>

                    <th class="th1" colspan="3">&nbsp;</th>

                    <th class="th1" colspan="3">&nbsp;</th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_RECORD_PLAY_ACTION}
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="th1a" colspan="4"></td>

                    <td class="th1a" colspan="3"></td>

                    <td class="th1a" colspan="3"><input type=
                    'submit' onclick=
                    'open_recplay_popup();return false;' value=
                    '{LABEL_RECORD_PLAY_CAPTION}'></td>
                  </tr>
                </table>

                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                    <td class="th1a" colspan="10"></td>
                  </tr>

                  <tr>
                    <td class="th1a" colspan="10"></td>
                  </tr>

                  <tr>
                    <td class="th1a" colspan="10">{LABEL_HEADSETS}</td>
                  </tr>

                  <tr>
                    <th class="th1" colspan="2">
                      <center>
                        {LABEL_HEADSET_NAME}
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_PLAY_TO_HEADSET}
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        {LABEL_HEADSET_NAME}
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_PLAY_TO_HEADSET}
                      </center>
                    </th>
                  </tr>
                  <!-- BEGIN P2H_ROW -->
                  <tr>
                    <!-- BEGIN P2H_ENTRY -->
                    <td class="bb" colspan="2">
                    {P2H_HEADSET_NAME}
                    &nbsp;</td>

                    <td class="bb">
                    {P2H_HEADSET_ENABLED_VALUE}
                    &nbsp;</td>

                    <td class="lb">{P2H_HEADSET_ENTRY_NO}.</td>

                    <td class="m4"><input type="radio" name=
                    "headsets[{P2H_MSG_ID}][{HEADSET_ID}]" {P2H_HEADSET_ENABLED_YES}
                    value="1">{P2H_RADIO_YES}&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "headsets[{P2H_MSG_ID}][{HEADSET_ID}]" {P2H_HEADSET_ENABLED_NO}
                    value="0">{P2H_RADIO_NO}</td>
                    <!-- END P2H_ENTRY -->
                  </tr>
                 <!-- END P2H_ROW -->                  
                  
                    
                  <!--*********************************************MONDAY***********************************************************-->
                  <!-- BEGIN DAY_DAYPART -->  
                  <tr>
                    <td class="th1a" colspan="10">{LABEL_DAY_DAYPARTS}</td>
                  </tr>

                  <tr>
                    <th class="th1" colspan="2">
                      <center>
                        {LABEL_DAY}
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_MSG_PLAYS}
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        {LABEL_DAY}
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        {LABEL_MSG_PLAYS}
                      </center>
                    </th>
                  </tr>
                  <!-- BEGIN DAY_DAYPARTS_ROW -->
                  <tr>
                    <!-- BEGIN DAY_DAYPARTS_CELL -->
                    <td class="bb" colspan="2">
                    {DDC_DAY_PART_NAME}
                    &nbsp;</td>

                    <td class="bb">
                    {DDC_ENABLED_VALUE}
                    &nbsp;</td>

                    <td class="lb">{DDC_ENTRY_NO}.</td>

                    <td class="m4"><input type="radio" name=
                    "dayParts[{DDC_MSG_ID}][{DDC_LABEL_DAY}][{DDC_ID}]" {DDC_ENABLED_YES}
                    value="1">{DDC_RADIO_YES}&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "dayParts[{DDC_MSG_ID}][{DDC_LABEL_DAY}][{DDC_ID}]" {DDC_ENABLED_NO}
                    value="0">{DDC_RADIO_NO}</td>
                    <!-- END DAY_DAYPARTS_CELL -->
                  </tr>
                  <!-- END DAY_DAYPARTS_ROW -->
                  <!-- END DAY_DAYPART -->  
                </table>
              </td>
            </tr>
          </table>
          <table class="F1" align="center" cellspacing="0">
            <tr>
              <td id="{ERROR_ID}_TD" width="85%">{SESSION_ERROR_MESSAGE}</td>
              <td id="f3" align="center" width="140" name="submitButton" onclick='show_popup("loading_popup")'>
                      {SUBMIT_ENTRY}
              </td>
            </tr>
            </table>
            <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{HIDDEN_TIMENOW}" >
            <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{HIDDEN_SESSION}" >
        </form>
        <!-- END MSGPROPS_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
