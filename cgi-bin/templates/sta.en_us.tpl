<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="../../styles/css.css">
        <title></title>
    </head>
<body>
  <table class="MMM">
    <tr>
      <td>
        <!-- BEGIN STA_PAGE -->
        <blockquote id="sta">
          {TITLE}
        </blockquote>

        <table class="M1" align="center" border="1" cellspacing="6"
        style="{width:75%}">
          <tr>
            <td class="M2">
              <table class="M3" align="center" cellspacing="0"
              cellpadding="4">
                <tr>
                  <td class="flh" colspan="9">{STATUS_FLAGS_HEADING}</td>
                </tr>

                <!-- BEGIN STA_LANE_ROW -->
                <tr>
                  <td class="rb">{LANE_NAME}</td>
                  <td class="rb2">&nbsp;{DET_TEXT}</td>

                  <td class="bb"><span class="ft2">
                  {DET_FLAG}
                  &nbsp;</span></td>

                  <td class="rb2">&nbsp;{PAGE_TEXT}</td>

                  <td class="bb"><span class="ft2">
                  {PAGE_FLAG}
                  &nbsp;</span></td>

                  <td class="rb2">&nbsp;{TALK_TEXT}</td>

                  <td class="bb"><span class="ft2">
                  {TALK_FLAG}
                  &nbsp;</span></td>

                  <td class="rb2">&nbsp;{LIS_TEXT}</td>

                  <td class="bb"><span class="ft2">
                  {LIS_FLAG}
                  &nbsp;</span></td>
                </tr>
                <!-- END STA_LANE_ROW -->

                <tr>
                  <td class="th1a" colspan="9">&nbsp;</td>
                </tr>
                
                <tr>
                  <td class="flh" colspan="9">{UPTIME_HEADING}</td>
                </tr>
                <!-- BEGIN STA_UPTIME_ROW -->
                <tr>
                  <td class="lb">{ENTRY_NO}.</td>

                  <td class="bb3" colspan="8"><span class="ft3">
                  {UPTIME_ENTRY}
                  &nbsp;</span></td>
                </tr>
                <!-- END STA_UPTIME_ROW -->

                <tr>
                  <td class="th1a" colspan="9">&nbsp;</td>
                </tr>

                <tr>
                  <td class="flh" colspan="9">{DIAG_MSGS_HEADING}</td>
                </tr>
                <!-- BEGIN STA_DIAG_ROW -->
                <tr>
                  <td class="lb">{ENTRY_NO}.</td>

                  <td class="bb3" colspan="8"><span class="ft3">
                  {DIAGNOSTIC_ENTRY}
                  &nbsp;</span></td>
                </tr>
                <!-- END STA_DIAG_ROW -->
              </table>
            </td>
          </tr>
        </table>
        <table class="F1" align="center" cellspacing="0">
            <tr>
                <td>&nbsp;</td>
                <td id="f3" align="center" width="140" >
                    <input type="button" value="{REFRESH_LABEL}" onClick="window.location.reload(1)">
                </td>
            </tr>
        </table>
        <!-- END STA_PAGE -->
    </td>
    </tr>
  </table>
</body>
</html>
