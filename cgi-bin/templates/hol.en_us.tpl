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
        <!-- BEGIN HOL_FORM -->
        <form onSubmit=''
            action="do.hol.php" method="post" name="FormHolidays"
            id="FormHolidays" accept-charset="ISO-8859-1">
          <blockquote>{TITLE}</blockquote>

          <table class="M1" id="m1a" align="center" border="1"
          cellspacing="6">
            <tr>
              <td class="M2">
                <table class="M3" id="tableData" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                    <th class="th1a" colspan="4">{DATE_NAME}<span class=
                    "th1b">/ dd-mm /</span></th>

                    <th class="th1" colspan="3">{OPEN_NAME}<span class=
                    "th1b">/ hh:mm /</span></th>

                    <th class="th1" colspan="3">{CLOSE_NAME}<span class=
                    "th1b">/ hh:mm /</span></th>
                  </tr>
                  <!-- BEGIN HOL_ROW -->
                  <tr>
                    <td width="16" class="cb">
                        <input type="hidden"
                        name="{HOL_DAY_ID}[HolDayID]"
                        id="{HOL_DAY_ID}_HolDayID"
                        value="{HOL_DAY_ID}" >
                    {HOL_DAY_ID}</td>

                    <td class="bb2"
                    id="{HOL_DAY_ID}_DayValueDisplay">
                    &nbsp;{DAY_VALUE}
                    &nbsp;</td>

                    <td class="lb" width="20">{ENTRY_A}.</td>

                    <td class="m4" width="78"><input type="text"
                    name="{HOL_DAY_ID}[DayValue]" size="7" maxlength="5"
                    id="{HOL_DAY_ID}_DayValue"
                    value="{DAY_VALUE}"></td>

                    <td class="bb1"
                    id="{HOL_DAY_ID}_OpenTimeValueDisplay">
                    &nbsp;{OPEN_TIME_VALUE}
                    </td>

                    <td class="lb" width="20">{ENTRY_B}.</td>

                    <td class="m4" width="78"><input type="text"
                    name="{HOL_DAY_ID}[OpenTimeValue]" size="6" maxlength="5"
                    id="{HOL_DAY_ID}_OpenTimeValue"
                    value="{OPEN_TIME_VALUE}"></td>

                    <td class="bb1"
                    id="{HOL_DAY_ID}_CloseTimeValueDisplay">
                    &nbsp;{CLOSE_TIME_VALUE}
                    </td>

                    <td class="lb" width="20">{ENTRY_C}.</td>

                    <td class="m4" width="78"><input type="text"
                    name="{HOL_DAY_ID}[CloseTimeValue]" size="6" maxlength="5"
                    id="{HOL_DAY_ID}_CloseTimeValue"
                    value="{CLOSE_TIME_VALUE}"></td>
                  </tr>
                  <!-- END HOL_ROW -->
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
        <!-- END HOL_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
