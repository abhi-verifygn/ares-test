<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
  <meta name="generator" content=
  "HTML Tidy for Linux/x86 (vers 25 March 2009), see www.w3.org">
  <meta http-equiv="Content-Type" content=
  "text/html; charset=utf-8">
  <link rel="stylesheet" type="text/css" href=
  "../../styles/css.css">

  <title></title>
  <script type="text/javascript" src="load.js">
</script>
  <script type="text/javascript">
var boReload;

  function ConfirmRecord()
  {
    if(confirm("Recording a message will delete existing message, do you wish to continue?"))
    {
        boReload=true;
        trigger_Req("Record");
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
        show_loading_text("Updating...");
        reload();
    }
  }

  var http;

  function trigger_Req( reqstr )
  {
    var url = "act.j";
    var params = "931_gtrMsgSelected=1&936_GrtAction="+reqstr;
    http = null;

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
      onclick="return ConfirmRecord()"> <input type="submit" value=
      "Play" onclick='trigger_Req("Play")'> <input type="submit"
      value="Stop" onclick='trigger_Req("Stop")'>
    </div>
  </div>

  <table class="MMM">
    <tr>
      <td>
        <form action="" method="post" name="FormGreeterSetup" id=
        "FormGreeterSetup">
          <blockquote id="blk1">
            <span class="blk2">MESSAGE</span><span class=
            "bl1">1</span>PROPERTIES
          </blockquote>

          <table class="F1" align="center" cellspacing="0">
            <tr>
              <td><?=$477_LAST_ERROR_MESSAGE?>
              </td>

              <td id="f3" align="center" width="140"><input type=
              'submit' name='936_GrtAction' value='Apply Changes'
              onclick='show_popup("loading_popup")'></td>
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
                        Message
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Name
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Type
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Enabled
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="rb">#1&nbsp;</td>

                    <td class="bb"><?=CLIP_AUDIO[0].szName?>
                    &nbsp;</td>

                    <td class="lb">1.</td>

                    <td class="m4"><input type="text" size="12"
                    maxlength="12" name="CLIP_AUDIO[0].szName"
                    value="&lt;?=CLIP_AUDIO[0].szName?&gt;"></td>

                    <td class="bb"><?=CLIP_AUDIO[0].szType?>
                    &nbsp;</td>

                    <td class="lb">2.</td>

                    <td class="m4"><select name=
                    "CLIP_AUDIO[0].szType" size="1">
                      <option value=
                      "&lt;?=CLIP_AUDIO[0].szType?&gt;">
                        <?=CLIP_AUDIO[0].szType?>
                        </option>

                      <option value="ALERT">
                        ALERT
                      </option>

                      <option value="REMINDER">
                        REMINDER
                      </option>

                      <option value="GREETER">
                        GREETER
                      </option>

                      <option value="CLOSED">
                        CLOSED
                      </option>

                      <option value="FORWARD">
                        FORWARD
                      </option>
                    </select></td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].boEnable)?>
                    &nbsp;</td>

                    <td class="lb">3.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].boEnable" <?=ToChecked(CLIP_AUDIO[0].boEnable)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].boEnable" <?=ToChecked(!(CLIP_AUDIO[0].boEnable))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <th class="rb" colspan="1">&nbsp;</th>

                    <th class="th1" colspan="3">
                      <center>
                        Play To Monitor
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Priority
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Delay<span class="th1b">/ mm:ss /</span>
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="rb" colspan="1">&nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].boMonitor)?>
                    &nbsp;</td>

                    <td class="lb">4.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].boMonitor" <?=ToChecked(CLIP_AUDIO[0].boMonitor)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].boMonitor" <?=ToChecked(!(CLIP_AUDIO[0].boMonitor))?>
                    value="0">No</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].boPriority)?>
                    &nbsp;</td>

                    <td class="lb">5.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].boPriority" <?=ToChecked(CLIP_AUDIO[0].boPriority)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].boPriority" <?=ToChecked(!(CLIP_AUDIO[0].boPriority))?>
                    value="0">No</td>

                    <td class="bb"><?=CLIP_AUDIO[0].tDelay?>
                    &nbsp;</td>

                    <td class="lb">6.</td>

                    <td class="m4"><input type="text" size="12"
                    maxlength="12" name="CLIP_AUDIO[0].tDelay"
                    value="&lt;?=CLIP_AUDIO[0].tDelay?&gt;"></td>
                  </tr>

                  <tr>
                    <th class="rb" colspan="1">&nbsp;</th>

                    <th class="th1" colspan="3">
                      <center>
                        Repeat Interval<span class="th1b">/
                        hh:mm:ss /</span>
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Repeat Count
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Duration<span class="th1b">/ seconds
                        /</span>
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="rb" colspan="1">&nbsp;</td>

                    <td class="bb">
                    <?=CLIP_AUDIO[0].tRepeatInterval?>
                    &nbsp;</td>

                    <td class="lb">7.</td>

                    <td class="m4"><input type="text" size="12"
                    maxlength="12" name=
                    "CLIP_AUDIO[0].tRepeatInterval" value=
                    "&lt;?=CLIP_AUDIO[0].tRepeatInterval?&gt;"></td>

                    <td class="bb"><?=CLIP_AUDIO[0].u8RepeatCount?>
                    &nbsp;</td>

                    <td class="lb">8.</td>

                    <td class="m4"><input type="text" name=
                    "CLIP_AUDIO[0].u8RepeatCount" size="3"
                    maxlength="3" value=
                    "&lt;?=CLIP_AUDIO[0].u8RepeatCount?&gt;"></td>

                    <td class="bb"><?=CLIP_AUDIO[0].u8Duration?>
                    &nbsp;</td>

                    <td class="lb">9.</td>

                    <td class="m4"><input type="text" name=
                    "CLIP_AUDIO[0].u8Duration" size="3" maxlength=
                    "3" value=
                    "&lt;?=CLIP_AUDIO[0].u8Duration?&gt;"></td>
                  </tr>

                  <tr>
                    <th class="rb" colspan="1">&nbsp;</th>

                    <th class="th1" colspan="3">&nbsp;</th>

                    <th class="th1" colspan="3">&nbsp;</th>

                    <th class="th1" colspan="3">
                      <center>
                        Record/Play Action
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="th1a" colspan="4"></td>

                    <td class="th1a" colspan="3"></td>

                    <td class="th1a" colspan="3"><input type=
                    'submit' onclick=
                    'open_recplay_popup();return false;' value=
                    'Open Play/Record Control'></td>
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
                    <td class="th1a" colspan="10">Play to
                    Headsets</td>
                  </tr>

                  <tr>
                    <th class="th1" colspan="2">
                      <center>
                        Headset Name
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Play to headset
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        Headset Name
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Play to headset
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[0].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:0)?>
                    &nbsp;</td>

                    <td class="lb">10.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:0" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:0)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:0" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:0))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[10].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:10)?>
                    &nbsp;</td>

                    <td class="lb">11.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:10" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:10)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:10" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:10))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[1].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:1)?>
                    &nbsp;</td>

                    <td class="lb">12.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:1" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:1)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:1" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:1))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[11].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:11)?>
                    &nbsp;</td>

                    <td class="lb">13.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:11" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:11)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:11" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:11))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[2].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:2)?>
                    &nbsp;</td>

                    <td class="lb">14.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:2" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:2)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:2" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:2))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[12].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:12)?>
                    &nbsp;</td>

                    <td class="lb">15.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:12" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:12)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:12" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:12))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[3].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:3)?>
                    &nbsp;</td>

                    <td class="lb">16.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:3" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:3)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:3" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:3))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[13].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:13)?>
                    &nbsp;</td>

                    <td class="lb">17.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:13" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:13)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:13" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:13))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[4].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:4)?>
                    &nbsp;</td>

                    <td class="lb">18.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:4" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:4)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:4" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:4))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[14].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:14)?>
                    &nbsp;</td>

                    <td class="lb">19.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:14" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:14)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:14" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:14))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[5].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:5)?>
                    &nbsp;</td>

                    <td class="lb">20.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:5" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:5)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:5" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:5))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[15].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:15)?>
                    &nbsp;</td>

                    <td class="lb">21.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:15" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:15)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:15" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:15))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[6].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:6)?>
                    &nbsp;</td>

                    <td class="lb">22.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:6" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:6)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:6" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:6))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[16].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:16)?>
                    &nbsp;</td>

                    <td class="lb">23.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:16" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:16)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:16" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:16))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[7].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:7)?>
                    &nbsp;</td>

                    <td class="lb">24.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:7" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:7)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:7" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:7))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[17].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:17)?>
                    &nbsp;</td>

                    <td class="lb">25.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:17" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:17)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:17" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:17))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[8].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:8)?>
                    &nbsp;</td>

                    <td class="lb">26.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:8" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:8)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:8" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:8))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[18].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:18)?>
                    &nbsp;</td>

                    <td class="lb">27.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:18" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:18)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:18" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:18))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[9].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:9)?>
                    &nbsp;</td>

                    <td class="lb">28.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:9" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:9)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:9" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:9))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=HEADSET_NAME[19].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].u32HeadsetEnable:19)?>
                    &nbsp;</td>

                    <td class="lb">29.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:19" <?=ToChecked(CLIP_AUDIO[0].u32HeadsetEnable:19)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].u32HeadsetEnable:19" <?=ToChecked(!(CLIP_AUDIO[0].u32HeadsetEnable:19))?>
                    value="0">No</td>
                  </tr>
                  <!--*********************************************MONDAY***********************************************************-->

                  <tr>
                    <td class="th1a" colspan="10">Monday dayparts
                    in which this message plays</td>
                  </tr>

                  <tr>
                    <th class="th1" colspan="2">
                      <center>
                        Monday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        Monday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[0].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:0)?>
                    &nbsp;</td>

                    <td class="lb">30.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:0" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:0)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:0" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:0))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[6].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:6)?>
                    &nbsp;</td>

                    <td class="lb">31.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:6" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:6)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:6" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:6))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[1].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:1)?>
                    &nbsp;</td>

                    <td class="lb">32.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:1" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:1)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:1" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:1))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[7].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:7)?>
                    &nbsp;</td>

                    <td class="lb">33.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:7" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:7)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:7" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:7))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[2].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:2)?>
                    &nbsp;</td>

                    <td class="lb">34.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:2" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:2)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:2" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:2))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[8].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:8)?>
                    &nbsp;</td>

                    <td class="lb">35.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:8" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:8)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:8" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:8))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[3].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:3)?>
                    &nbsp;</td>

                    <td class="lb">36.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:3" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:3)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:3" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:3))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[9].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:9)?>
                    &nbsp;</td>

                    <td class="lb">37.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:9" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:9)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:9" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:9))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[4].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:4)?>
                    &nbsp;</td>

                    <td class="lb">38.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:4" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:4)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:4" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:4))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[10].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:10)?>
                    &nbsp;</td>

                    <td class="lb">39.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:10" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:10)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:10" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:10))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[5].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:5)?>
                    &nbsp;</td>

                    <td class="lb">40.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:5" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:5)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:5" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:5))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[11].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[0]:11)?>
                    &nbsp;</td>

                    <td class="lb">41.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:11" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[0]:11)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[0]:11" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[0]:11))?>
                    value="0">No</td>
                  </tr>
                  <!--*******************************************TUESDAY************************************************************-->

                  <tr>
                    <td class="th1a" colspan="10">Tuesday dayparts
                    in which this message plays</td>
                  </tr>

                  <tr>
                    <th class="th1" colspan="2">
                      <center>
                        Tuesday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        Tuesday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[0].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:0)?>
                    &nbsp;</td>

                    <td class="lb">42.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:0" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:0)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:0" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:0))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[6].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:6)?>
                    &nbsp;</td>

                    <td class="lb">43.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:6" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:6)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:6" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:6))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[1].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:1)?>
                    &nbsp;</td>

                    <td class="lb">44.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:1" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:1)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:1" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:1))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[7].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:7)?>
                    &nbsp;</td>

                    <td class="lb">45.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:7" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:7)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:7" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:7))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[2].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:2)?>
                    &nbsp;</td>

                    <td class="lb">46.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:2" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:2)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:2" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:2))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[8].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:8)?>
                    &nbsp;</td>

                    <td class="lb">47.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:8" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:8)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:8" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:8))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[3].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:3)?>
                    &nbsp;</td>

                    <td class="lb">48.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:3" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:3)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:3" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:3))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[9].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:9)?>
                    &nbsp;</td>

                    <td class="lb">49.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:9" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:9)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:9" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:9))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[4].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:4)?>
                    &nbsp;</td>

                    <td class="lb">50.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:4" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:4)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:4" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:4))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[10].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:10)?>
                    &nbsp;</td>

                    <td class="lb">51.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:10" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:10)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:10" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:10))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[5].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:5)?>
                    &nbsp;</td>

                    <td class="lb">52.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:5" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:5)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:5" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:5))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[11].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[1]:11)?>
                    &nbsp;</td>

                    <td class="lb">53.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:11" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[1]:11)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[1]:11" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[1]:11))?>
                    value="0">No</td>
                  </tr>
                  <!--*******************************************WEDNESDAY************************************************************-->

                  <tr>
                    <td class="th1a" colspan="10">Wednesday
                    dayparts in which this message plays</td>
                  </tr>

                  <tr>
                    <th class="th1" colspan="2">
                      <center>
                        Wednesday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        Wednesday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[0].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:0)?>
                    &nbsp;</td>

                    <td class="lb">54.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:0" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:0)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:0" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:0))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[6].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:6)?>
                    &nbsp;</td>

                    <td class="lb">55.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:6" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:6)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:6" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:6))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[1].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:1)?>
                    &nbsp;</td>

                    <td class="lb">56.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:1" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:1)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:1" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:1))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[7].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:7)?>
                    &nbsp;</td>

                    <td class="lb">57.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:7" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:7)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:7" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:7))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[2].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:2)?>
                    &nbsp;</td>

                    <td class="lb">58.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:2" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:2)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:2" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:2))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[8].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:8)?>
                    &nbsp;</td>

                    <td class="lb">59.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:8" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:8)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:8" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:8))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[3].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:3)?>
                    &nbsp;</td>

                    <td class="lb">60.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:3" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:3)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:3" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:3))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[9].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:9)?>
                    &nbsp;</td>

                    <td class="lb">61.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:9" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:9)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:9" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:9))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[4].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:4)?>
                    &nbsp;</td>

                    <td class="lb">62.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:4" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:4)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:4" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:4))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[10].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:10)?>
                    &nbsp;</td>

                    <td class="lb">63.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:10" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:10)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:10" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:10))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[5].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:5)?>
                    &nbsp;</td>

                    <td class="lb">64.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:5" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:5)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:5" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:5))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[11].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[2]:11)?>
                    &nbsp;</td>

                    <td class="lb">65.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:11" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[2]:11)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[2]:11" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[2]:11))?>
                    value="0">No</td>
                  </tr>
                  <!--*******************************************THURSDAY************************************************************-->

                  <tr>
                    <td class="th1a" colspan="10">Thursday dayparts
                    in which this message plays</td>
                  </tr>

                  <tr>
                    <th class="th1" colspan="2">
                      <center>
                        Thursday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        Thursday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[0].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:0)?>
                    &nbsp;</td>

                    <td class="lb">66.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:0" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:0)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:0" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:0))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[6].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:6)?>
                    &nbsp;</td>

                    <td class="lb">67.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:6" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:6)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:6" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:6))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[1].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:1)?>
                    &nbsp;</td>

                    <td class="lb">68.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:1" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:1)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:1" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:1))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[7].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:7)?>
                    &nbsp;</td>

                    <td class="lb">69.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:7" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:7)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:7" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:7))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[2].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:2)?>
                    &nbsp;</td>

                    <td class="lb">70.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:2" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:2)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:2" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:2))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[8].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:8)?>
                    &nbsp;</td>

                    <td class="lb">71.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:8" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:8)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:8" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:8))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[3].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:3)?>
                    &nbsp;</td>

                    <td class="lb">72.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:3" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:3)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:3" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:3))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[9].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:9)?>
                    &nbsp;</td>

                    <td class="lb">73.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:9" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:9)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:9" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:9))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[4].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:4)?>
                    &nbsp;</td>

                    <td class="lb">74.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:4" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:4)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:4" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:4))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[10].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:10)?>
                    &nbsp;</td>

                    <td class="lb">75.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:10" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:10)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:10" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:10))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[5].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:5)?>
                    &nbsp;</td>

                    <td class="lb">76.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:5" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:5)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:5" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:5))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[11].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[3]:11)?>
                    &nbsp;</td>

                    <td class="lb">77.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:11" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[3]:11)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[3]:11" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[3]:11))?>
                    value="0">No</td>
                  </tr>
                  <!--*******************************************FRIDAY************************************************************-->

                  <tr>
                    <td class="th1a" colspan="10">Friday dayparts
                    in which this message plays</td>
                  </tr>

                  <tr>
                    <th class="th1" colspan="2">
                      <center>
                        Friday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        Friday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[0].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:0)?>
                    &nbsp;</td>

                    <td class="lb">78.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:0" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:0)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:0" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:0))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[6].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:6)?>
                    &nbsp;</td>

                    <td class="lb">79.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:6" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:6)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:6" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:6))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[1].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:1)?>
                    &nbsp;</td>

                    <td class="lb">80.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:1" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:1)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:1" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:1))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[7].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:7)?>
                    &nbsp;</td>

                    <td class="lb">81.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:7" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:7)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:7" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:7))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[2].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:2)?>
                    &nbsp;</td>

                    <td class="lb">82.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:2" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:2)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:2" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:2))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[8].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:8)?>
                    &nbsp;</td>

                    <td class="lb">83.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:8" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:8)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:8" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:8))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[3].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:3)?>
                    &nbsp;</td>

                    <td class="lb">84.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:3" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:3)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:3" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:3))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[9].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:9)?>
                    &nbsp;</td>

                    <td class="lb">85.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:9" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:9)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:9" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:9))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[4].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:4)?>
                    &nbsp;</td>

                    <td class="lb">86.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:4" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:4)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:4" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:4))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[10].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:10)?>
                    &nbsp;</td>

                    <td class="lb">87.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:10" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:10)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:10" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:10))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[5].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:5)?>
                    &nbsp;</td>

                    <td class="lb">88.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:5" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:5)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:5" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:5))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[11].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[4]:11)?>
                    &nbsp;</td>

                    <td class="lb">89.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:11" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[4]:11)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[4]:11" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[4]:11))?>
                    value="0">No</td>
                  </tr>
                  <!--*******************************************SATURDAY************************************************************-->

                  <tr>
                    <td class="th1a" colspan="10">Saturday dayparts
                    in which this message plays</td>
                  </tr>

                  <tr>
                    <th class="th1" colspan="2">
                      <center>
                        Saturday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        Saturday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[0].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:0)?>
                    &nbsp;</td>

                    <td class="lb">90.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:0" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:0)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:0" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:0))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[6].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:6)?>
                    &nbsp;</td>

                    <td class="lb">91.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:6" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:6)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:6" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:6))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[1].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:1)?>
                    &nbsp;</td>

                    <td class="lb">92.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:1" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:1)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:1" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:1))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[7].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:7)?>
                    &nbsp;</td>

                    <td class="lb">93.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:7" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:7)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:7" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:7))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[2].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:2)?>
                    &nbsp;</td>

                    <td class="lb">94.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:2" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:2)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:2" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:2))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[8].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:8)?>
                    &nbsp;</td>

                    <td class="lb">95.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:8" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:8)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:8" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:8))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[3].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:3)?>
                    &nbsp;</td>

                    <td class="lb">96.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:3" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:3)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:3" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:3))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[9].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:9)?>
                    &nbsp;</td>

                    <td class="lb">97.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:9" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:9)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:9" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:9))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[4].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:4)?>
                    &nbsp;</td>

                    <td class="lb">98.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:4" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:4)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:4" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:4))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[10].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:10)?>
                    &nbsp;</td>

                    <td class="lb">99.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:10" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:10)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:10" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:10))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[5].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:5)?>
                    &nbsp;</td>

                    <td class="lb">100.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:5" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:5)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:5" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:5))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[11].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[5]:11)?>
                    &nbsp;</td>

                    <td class="lb">101.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:11" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[5]:11)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[5]:11" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[5]:11))?>
                    value="0">No</td>
                  </tr>
                  <!--*********************************************SUNDAY***********************************************************-->

                  <tr>
                    <td class="th1a" colspan="10">Sunday dayparts
                    in which this message plays</td>
                  </tr>

                  <tr>
                    <th class="th1" colspan="2">
                      <center>
                        Sunday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>

                    <th class="th1" colspan="2">
                      <center>
                        Sunday
                      </center>
                    </th>

                    <th class="th1" colspan="3">
                      <center>
                        Message plays
                      </center>
                    </th>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[0].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:0)?>
                    &nbsp;</td>

                    <td class="lb">102.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:0" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:0)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:0" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:0))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[6].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:6)?>
                    &nbsp;</td>

                    <td class="lb">103.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:6" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:6)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:6" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:6))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[1].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:1)?>
                    &nbsp;</td>

                    <td class="lb">104.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:1" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:1)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:1" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:1))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[7].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:7)?>
                    &nbsp;</td>

                    <td class="lb">105.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:7" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:7)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:7" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:7))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[2].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:2)?>
                    &nbsp;</td>

                    <td class="lb">106.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:2" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:2)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:2" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:2))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[8].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:8)?>
                    &nbsp;</td>

                    <td class="lb">107.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:8" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:8)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:8" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:8))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[3].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:3)?>
                    &nbsp;</td>

                    <td class="lb">108.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:3" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:3)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:3" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:3))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[9].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:9)?>
                    &nbsp;</td>

                    <td class="lb">109.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:9" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:9)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:9" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:9))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[4].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:4)?>
                    &nbsp;</td>

                    <td class="lb">110.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:4" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:4)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:4" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:4))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[10].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:10)?>
                    &nbsp;</td>

                    <td class="lb">111.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:10" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:10)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:10" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:10))?>
                    value="0">No</td>
                  </tr>

                  <tr>
                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[5].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:5)?>
                    &nbsp;</td>

                    <td class="lb">112.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:5" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:5)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:5" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:5))?>
                    value="0">No</td>

                    <td class="bb" colspan="2">
                    <?=CLIP_DAYPART[11].szName?>
                    &nbsp;</td>

                    <td class="bb">
                    <?=ToYesNo(CLIP_AUDIO[0].au16DayPart[6]:11)?>
                    &nbsp;</td>

                    <td class="lb">113.</td>

                    <td class="m4"><input type="radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:11" <?=ToChecked(CLIP_AUDIO[0].au16DayPart[6]:11)?>
                    value="1">Yes&nbsp;&nbsp;|&nbsp;<input type=
                    "radio" name=
                    "CLIP_AUDIO[0].au16DayPart[6]:11" <?=ToChecked(!(CLIP_AUDIO[0].au16DayPart[6]:11))?>
                    value="0">No</td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>

          <table class="F1" align="center" cellspacing="0">
            <tr>
              <td><?=$477_LAST_ERROR_MESSAGE?>
              </td>

              <td id="f3" align="center" width="140"><input type=
              "submit" name="936_GrtAction" value="Apply Changes"
              onclick="show_loading()"></td>
            </tr>
          </table>
        </form>
      </td>
    </tr>
  </table>
</body>
</html>
