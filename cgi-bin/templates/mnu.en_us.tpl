<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
  <meta name="generator" content=
  "HTML Tidy for Linux/x86 (vers 25 March 2009), see www.w3.org">
  <meta http-equiv="Content-Type" content=
  "text/html; charset=ISO-8859-1">
  <meta http-equiv="Pragma" content="no-cache">
  <link rel="stylesheet" type="text/css" href="../../styles/mnu.css">
  <script src="do.mnu.js"></script>
</head>

<body>
  <!-- BEGIN MNU_BODY -->

  <h3>{SITE_MENU_TITLE}</h3>

  <ul>
    <li><a href="lca.php" target="infowindow" onclick=
    "resetSel(0);">{SITE_MENU_INFO}</a></li>

    <li><a href="tme.php" target="infowindow" onclick=
    "resetSel(0);">{SITE_MENU_WORKING_HOURS}</a></li>

    <li><a href="hol.php" target="infowindow" onclick=
    "resetSel(0);">{SITE_MENU_HOLIDAY_SCHEDULE}</a></li>

    <li><a href="abt.php" target="infowindow" onclick=
    "resetSel(0);">{SITE_MENU_REVISIONS}</a></li>
  </ul>

  <h3>{STATUS_MENU_TITLE}</h3>

  <ul>
    <li><a href="ltm.php" target="infowindow" onclick=
    "resetSel(0);">{STATUS_ITEM_CURRENT}</a></li>

    <li><a href="sta.php" target="infowindow" onclick=
    "resetSel(0);">{STATUS_ITEM_DIAGNOSTICS}</a></li>

    <li><a href="res.php" target="infowindow" onclick=
    "resetSel(0);">{STATUS_ITEM_RESTART}</a></li>

    <li><a href="ins.php" target="infowindow" onclick=
    "resetSel(0);">{STATUS_ITEM_INSTALLER_OPTIONS}</a></li>
  </ul>

  <h3>{SETTINGS_MENU_TITLE}</h3>

  <ul>
    <li style="text-indent:0px;">
      <form name="volume" id="volume">
        <select onchange=
        "showPage( this.options[this.selectedIndex].value, 1 );"
        name="volist">
          <option value="">
            {SETTINGS_VOL_CB_TITLE}
          </option>

          <option value="vlm.php">
            {SETTINGS_VOL_CB_DRIVETHRU}
          </option>

          <option value="mvl.php">
            {SETTINGS_VOL_CB_MONITOR}
          </option>

          <option value="ngt.php">
            {SETTINGS_VOL_CB_NIGHT}
          </option>
        </select>
      </form>
    </li>

    <li><a href="noi.php" target="infowindow" onclick=
    "resetSel(0);">{SETTINGS_ITEM_NR}</a></li>

    <li><a href="glb.php" target="infowindow" onclick=
    "resetSel(0);">{SETTINGS_ITEM_GLOBAL}</a></li>

    <li><a href="detectors.php" target="infowindow" onclick=
    "resetSel(0);">{SETTINGS_ITEM_DETECTORS}</a></li>

    <li><a href="ord.php" target="infowindow" onclick=
    "resetSel(0);">{SETTINGS_ITEM_ORDER_TAKING}</a></li>

    <li><a href="msc.php" target="infowindow" onclick=
    "resetSel(0);">{SETTINGS_ITEM_NETWORK}</a></li>

    <li><a href="voip.php" target="infowindow" onclick=
    "resetSel(0);">{SETTINGS_ITEM_VOIP}      </a></li>

	<li><a href="device.php" target="infowindow" onclick=
    "resetSel(0);">{SETTINGS_ITEM_LANE_DEVICE}</a></li>

	<li><a href="server.php" target="infowindow" onclick=
    "resetSel(0);">{SETTINGS_ITEM_LANE_SERVER}</a></li>

    <li><a href="cloud.php" target="infowindow" onclick=
    "resetSel(0);">{SETTINGS_ITEM_CLOUD}     </a></li>

    <li><a href="hsm.php" target="infowindow" onclick=
    "resetSel(0);">{OTHER_HW_ITEM_HEADSET}   </a></li>

    <li style="text-indent:0px;">
      <form name="greeter" id="greeter">
        <select onchange=
        "showPage( this.options[this.selectedIndex].value, 5 );"
        name="greeterlist">
          <option value="">
            {OTHER_HW_GREETER_CB_TITLE}
          </option>

          <option value="msg.php">
            {OTHER_HW_GREETER_CB_GLOBAL}
          </option>

          <option value="grd.php">
            {OTHER_HW_GREETER_CB_DAYPARTS}
          </option>

          <option value="msgprops.php?msgprops=1">
            {OTHER_HW_GREETER_CB_MSG_1} {OTHER_HW_GREETER_CB_MSG_1_NAME}
            </option>

          <option value="msgprops.php?msgprops=2">
            {OTHER_HW_GREETER_CB_MSG_2} {OTHER_HW_GREETER_CB_MSG_2_NAME}
            </option>

          <option value="msgprops.php?msgprops=3">
            {OTHER_HW_GREETER_CB_MSG_3} {OTHER_HW_GREETER_CB_MSG_3_NAME}
            </option>

          <option value="msgprops.php?msgprops=4">
            {OTHER_HW_GREETER_CB_MSG_4} {OTHER_HW_GREETER_CB_MSG_4_NAME}
            </option>

          <option value="msgprops.php?msgprops=5">
            {OTHER_HW_GREETER_CB_MSG_5} {OTHER_HW_GREETER_CB_MSG_5_NAME}
            </option>

          <option value="msgprops.php?msgprops=6">
            {OTHER_HW_GREETER_CB_MSG_6} {OTHER_HW_GREETER_CB_MSG_6_NAME}
            </option>

          <option value="msgprops.php?msgprops=7">
            {OTHER_HW_GREETER_CB_MSG_7} {OTHER_HW_GREETER_CB_MSG_7_NAME}
            </option>

          <option value="msgprops.php?msgprops=8">
            {OTHER_HW_GREETER_CB_MSG_8} {OTHER_HW_GREETER_CB_MSG_8_NAME}
            </option>

          <option value="msgprops.php?msgprops=9">
            {OTHER_HW_GREETER_CB_MSG_9} {OTHER_HW_GREETER_CB_MSG_9_NAME}
            </option>

          <option value="msgprops.php?msgprops=10">
            {OTHER_HW_GREETER_CB_MSG_10} {OTHER_HW_GREETER_CB_MSG_10_NAME}
            </option>

          <option value="msgprops.php?msgprops=11">
            {OTHER_HW_GREETER_CB_MSG_11} {OTHER_HW_GREETER_CB_MSG_11_NAME}
            </option>

          <option value="msgprops.php?msgprops=12">
            {OTHER_HW_GREETER_CB_MSG_12} {OTHER_HW_GREETER_CB_MSG_12_NAME}
            </option>

          <option value="msgprops.php?msgprops=13">
            {OTHER_HW_GREETER_CB_MSG_13} {OTHER_HW_GREETER_CB_MSG_13_NAME}
            </option>

          <option value="msgprops.php?msgprops=14">
            {OTHER_HW_GREETER_CB_MSG_14} {OTHER_HW_GREETER_CB_MSG_14_NAME}
            </option>

          <option value="msgprops.php?msgprops=15">
            {OTHER_HW_GREETER_CB_MSG_15} {OTHER_HW_GREETER_CB_MSG_15_NAME}
            </option>

          <option value="msgprops.php?msgprops=16">
            {OTHER_HW_GREETER_CB_MSG_16} {OTHER_HW_GREETER_CB_MSG_16_NAME}
            </option>
        </select>
      </form>
    </li>

    <li><a href="dio.php" target="infowindow" onclick=
    "resetSel(0);">{SETTINGS_ITEM_DIO}</a></li>
  </ul>

  <h3>{FILE_MENU_TITLE}</h3>

  <ul style="{padding-bottom:10px;}">
    <li><a href="cf.php" target="infowindow" onclick=
    "resetSel(0);">{FILE_ITEM_CONFIG}</a></li>
  </ul>

  <script type="text/javascript">
      parent.banner.window.location.reload();
  </script>
  <!-- END MNU_BODY -->
</body>
</html>
