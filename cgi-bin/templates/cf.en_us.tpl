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
  <script type="text/javascript" src="load.js">
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
      <p>Sending config...</p>
    </div>
  </div>

  <!-- BEGIN CF_BODY -->
  <table class="MMM">
    <tr>
      <td>
        <blockquote>
          {TITLE}
        </blockquote>
        <table class="M1" id="m1b" align="center" border="1"
        cellspacing="6">
          <tr>
            <td class="M2">
            <!-- BEGIN CF_SEND_FORM -->
              <form action="do.cf_upload.php" method="post" enctype=
              "multipart/form-data" accept-charset="ISO-8859-1">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                    <th colspan="3" class="flh">{LabelSendConfig}</th>
                  </tr>

                  <tr>
                    <td class="fl">{LabelSelectFile}
                      <div class="fld">
                        <!-- MAX_FILE_SIZE must precede the file input field -->
                        <!--<input type="hidden" name="MAX_FILE_SIZE" value="{CF_DB_UPLOAD_MAX_FILESIZE}" />-->
                        <input type="file" size="80"
                        name="{DBUploadKey}" style= "{position:relative}" accept="application/gzip,.gz" />
                      </div>
                    </td>

                    <td bgcolor="black">&nbsp;</td>

                    <td class="fl1" align="right">{SendConfigSubmit}&nbsp;</td>
                  </tr>
                </table>
                <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{CF_SEND_CF_HIDDEN_TIMENOW}" >
                <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{CF_SEND_CF_HIDDEN_SESSION}" >
              </form>
            <!-- END CF_SEND_FORM -->
            </td>
          </tr>

          <tr>
            <td class="M2">
            <!-- BEGIN CF_RECEIVE_FORM -->
              <form action="do.cf_download.php" method="post" enctype=
              "multipart/form-data" accept-charset="ISO-8859-1">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                    <th colspan="3" class="flh">{LabelReceiveConfig}</th>
                  </tr>

                  <tr>
                    <td class="fl">{LabelObtainCurrentSetup}
                      <div class="fld"></div>
                    </td>

                    <td bgcolor="black">&nbsp;</td>

                    <td class="fl1" align="right">{ReceiveConfigSubmit}&nbsp;</td>
                  </tr>
                </table>
                <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{CF_RECEIVE_CF_HIDDEN_TIMENOW}" >
                <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{CF_RECEIVE_CF_HIDDEN_SESSION}" >
              </form>
            <!-- END CF_RECEIVE_FORM -->
            </td>
          </tr>
          
          <tr>
            <td class="M2">
            <!-- BEGIN TB_UPGRADE_FORM -->
              <form action="do.cf_upgrade.php" method="post" enctype=
              "multipart/form-data" accept-charset="ISO-8859-1">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                    <th colspan="3" class="flh">{LabelTBUpgrade}</th>
                  </tr>

                  <tr>
                    <td class="fl">{LabelTBFile} ({CF_TB_UPGRADE_FREE_SPACE})
                      <div class="fld">
                        <!-- MAX_FILE_SIZE must precede the file input field -->
                        <input type="hidden" name="MAX_FILE_SIZE" value="{CF_TB_UPGRADE_MAX_FILESIZE}" />
                        <input type="file" size="80"
                        name="{TBUpgradeKey}" style= "{position:relative}" accept="application/gzip,.gz" />
                      </div>
                    </td>

                    <td bgcolor="black">&nbsp;</td>

                    <td class="fl1" align="right">{TBUpgradeSubmit}&nbsp;</td>
                  </tr>
                </table>
                <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{CF_TB_UPGRADE_HIDDEN_TIMENOW}" >
                <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{CF_TB_UPGRADE_HIDDEN_SESSION}" >
              </form>
            <!-- END TB_UPGRADE_FORM -->
            </td>
          </tr>

        </table>

        <table class="F1" align="center" cellspacing="0">
          <tr>
            <td  id="{ERROR_ID}_TD">{SESSION_ERROR_MESSAGE}</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <!-- END CF_BODY -->

  <form name="reboot" action="" method="post" accept-charset=
  "ISO-8859-1" id="reboot">
    <input type="hidden" name="701_BASE_RESTART" value="REBOOT">
  </form>
  <script type="text/javascript">
    if ( false ) {
        parent.menu.window.location.reload();
        var answer = confirm("Configuration Updated. Reboot System Now?");
        if (answer) {
            document.reboot.submit();
        }
    }
  </script>
</body>
</html>
