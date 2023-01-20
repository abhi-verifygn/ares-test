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
</head>

<body>
  <table class="MMM">
    <tr>
      <td>
        <!-- BEGIN GRD_FORM -->
        <form action="do.grd.php" method="post" name="FormHolidays" id=
        "FormHolidays" accept-charset="ISO-8859-1">
          <blockquote>{TITLE}            
          </blockquote>

          <table class="M1" id="m1a" align="center" border="1"
          cellspacing="6">
            <tr>
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                    <th class="th1" width="16">&nbsp;</th>

                    <th class="th1" colspan="3">{DAY_PART_NAME}</th>

                    <th class="th1" colspan="3">{START_TIME}
                    <span class="th1b">/ hh:mm /</span></th>

                    <th class="th1" colspan="3">{END_TIME}
                    <span class="th1b">/ hh:mm /</span></th>
                  </tr>
                  <!-- BEGIN GRD_ENTRY -->  
                  <tr>
                    <td class="rb" width="16">#{ROW_NO}</td>

                    <td class="bb1">&nbsp;
                    {ROW_DAY_PART_NAME}
                    &nbsp;</td>

                    <td class="lb" width="20">{ENTRY_A}.</td>

                    <td class="m4" width="78"><input type="text"
                    name="dayPart[{ROW_DAY_PART_ID}][Name]" size="13"
                    maxlength="12" value=
                    "{ROW_DAY_PART_NAME}"></td>

                    <td class="bb1">&nbsp;
                    {ROW_DAY_PART_START_TIME}
                    </td>

                    <td class="lb" width="20">{ENTRY_B}.</td>

                    <td class="m4" width="78"><input type="text"
                    name="dayPart[{ROW_DAY_PART_ID}][StartTime]" size="6"
                    maxlength="5" value=
                    "{ROW_DAY_PART_START_TIME}"></td>

                    <td class="bb1">&nbsp;{ROW_DAY_PART_END_TIME}
                    </td>

                    <td class="lb" width="20">{ENTRY_C}.</td>

                    <td class="m4" width="78"><input type="text"
                    name="dayPart[{ROW_DAY_PART_ID}][EndTime]" size="6" maxlength=
                    "5" value=
                    "{ROW_DAY_PART_END_TIME}"></td>
                  </tr>
                  <!-- END GRD_ENTRY -->  
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
        <!-- END GRD_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
