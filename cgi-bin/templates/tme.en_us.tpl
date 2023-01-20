<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
  <meta name="generator" content=
  "HTML Tidy for Linux/x86 (vers 25 March 2009), see www.w3.org">
  <meta http-equiv="Content-Type" content=
  "text/html; charset=ISO-8859-1">
  <link rel="stylesheet" type="text/css" href="../../styles/css.css">
  <title></title>
</head>

<body>
  <table class="MMM">
    <tr>
      <td>
        <!-- BEGIN TME_FORM -->
        <form onSubmit=''
            action="do.tme.php" method="post" name="FormWorkingHours"
            id="FormWorkingHours" accept-charset="ISO-8859-1">
          <blockquote>{TITLE}</blockquote>

          <table class="M1" id="m1a" align="center" border="1"
          cellspacing="6">
            <tr>
              <td class="M2">
                <table id="tableData" class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                    <th class="th1a">{DAY_OF_WEEK}</th>

                    <th class="th1" colspan="3">
                    {OPEN_TIME}<span class="th1b">/ hh:mm
                    /</span></th>

                    <th class="th1" colspan="3">
                    {DAY_TIME}&nbsp;&nbsp;<span class="th1b">/ hh:mm
                    /</span></th>

                    <th class="th1" colspan="3">
                    {NIGHT_TIME}&nbsp;&nbsp;<span class="th1b">/
                    hh:mm /</span></th>

                    <th class="th1" colspan="3">
                    {CLOSE_TIME}&nbsp;&nbsp;<span class="th1b">/
                    hh:mm /</span></th>
                  </tr>
                  <!-- BEGIN TME_ROW -->
                  <tr>
                    <td class="rb" width="102">{DAY_NAME}</td>

                    <td class="bb1"
                    id="{DAY_NAME_ID}_OpenTimeDisplay">
                    &nbsp;{OPEN_TIME_VALUE}</td>

                    <td class="lb">{ENTRY_A}.</td>

                    <td class="m4" width="70"><input type="text"
                    name="{DAY_NAME_ID}[OpenTimeValue]" size="6" maxlength="5"
                    id="{DAY_NAME_ID}_OpenTimeValue"
                    value="{OPEN_TIME_VALUE}"></td>

                    <td class="bb1"
                    id="{DAY_NAME_ID}_DayTimeDisplay">
                    &nbsp;{DAY_TIME_VALUE}
                    </td>

                    <td class="lb">{ENTRY_B}.</td>

                    <td class="m4" width="70"><input type="text"
                    name="{DAY_NAME_ID}[DayTimeValue]" size="6" maxlength="5"
                    id="{DAY_NAME_ID}_DayTimeValue"
                    value="{DAY_TIME_VALUE}"></td>

                    <td class="bb1"
                    id="{DAY_NAME_ID}_NightTimeDisplay">
                    &nbsp;{NIGHT_TIME_VALUE}
                    </td>

                    <td class="lb">{ENTRY_C}.</td>

                    <td class="m4" width="70"><input type="text"
                    name="{DAY_NAME_ID}[NightTimeValue]" size="6" maxlength="5"
                    id="{DAY_NAME_ID}_NightTimeValue"
                    value="{NIGHT_TIME_VALUE}"></td>

                    <td class="bb1"
                    id="{DAY_NAME_ID}_CloseTimeDisplay">
                    &nbsp;{CLOSE_TIME_VALUE}
                    </td>

                    <td class="lb">{ENTRY_D}.</td>

                    <td class="m4" width="63"><input type="text"
                    name="{DAY_NAME_ID}[CloseTimeValue]" size="6" maxlength="5"
                    id="{DAY_NAME_ID}_CloseTimeValue"
                    value="{CLOSE_TIME_VALUE}"></td>
                  </tr>
                  <!-- END TME_ROW -->
                </table>
              </td>
            </tr>
          </table>
          <table class="F1" id="f1a" align="center" cellspacing="0">
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
        <!-- END TME_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
