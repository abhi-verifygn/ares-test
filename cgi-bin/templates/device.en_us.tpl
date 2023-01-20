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
</head>

<body>
  <table class="MMM">
    <tr>
      <td>

		  <!-- BEGIN DEVICE_FORM -->

		  <blockquote>
            {TITLE}
          </blockquote>

		  <!-- BEGIN DEVICE_FILTER_FORM -->
		  <form action="device.php" method="post" name="FormDeviceFilter"
		  	id="FormDeviceFilter" accept-charset="ISO-8859-1">
			<table class="M1" align="center" border="1" cellspacing=
			"6">
				<tr>
				<td class="M2">
					<label><strong>{FILTER_FIELD_TITLE}:</strong></label>
					<select name="deviceFilter" onchange="this.form.submit()">
						<!-- BEGIN FILTER_OPTION_GROUP_SELECT -->
						<optgroup label="{OPTION_GROUP_LABEL}">
							{OPTION_GROUP_OPTIONS}
						</optgroup>
						<!-- END FILTER_OPTION_GROUP_SELECT -->
					</select>
				</td>
				</tr>
			</table>
		  </form>
		  <!-- END DEVICE_FILTER_FORM -->

		  <form action="do.device.php" method="post" name="FormVoIPConfiguration" id=
			"FormVoIPConfiguration" accept-charset="ISO-8859-1">

          <table class="M1" align="center" border="1" cellspacing=
          "6">
            <tr>
              <td class="M2">

                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                  <th class="th1a" colspan="4"><span class="th1b" style="font-size:18px;">{LINEHEAD}</span></th>
                  </tr>
                <!-- BEGIN DEVICE_ENTRY -->
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_ENABLED}</td>

                    <td class="bb">{PARAM_DISPLAY_ENABLED_VALUE}
                    &nbsp;</td>

                    <td width="20" class="lb">1.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[{PARAM_DISPLAY_ENABLED_KEY}]" {PARAM_ENABLED} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[{PARAM_DISPLAY_ENABLED_KEY}]" {PARAM_DISABLED} value="RADIO_NO">NO
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_REG_STATUS}</td>

                    <td class="bb">{PARAM_DISPLAY_REG_STATUS_VALUE}&nbsp;</td>

                    <td width="20" class="lb"></td>

                    <td width="130" class="m4">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_CALL_STATUS}</td>

                    <td class="bb">{PARAM_DISPLAY_CALL_STATUS_VALUE}&nbsp;</td>

                    <td width="20" class="lb"></td>

                    <td width="130" class="m4">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_SERVER}</td>

                    <td class="bb">{PARAM_DISPLAY_SERVER_VALUE}&nbsp;</td>

                    <td width="20" class="lb">2.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[{PARAM_DISPLAY_SERVER_KEY}]" size="40" maxlength="80" value="{PARAM_DISPLAY_SERVER_VALUE}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_SERVER_PORT}</td>

                    <td class="bb">{PARAM_DISPLAY_SERVER_PORT_VALUE}&nbsp;</td>

                    <td width="20" class="lb">3.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[{PARAM_DISPLAY_SERVER_PORT_KEY}]" size="40" maxlength="80" value="{PARAM_DISPLAY_SERVER_PORT_VALUE}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_REGISTRAR}</td>

                    <td class="bb">{PARAM_DISPLAY_REGISTRAR_VALUE}&nbsp;</td>

                    <td width="20" class="lb">4.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[{PARAM_DISPLAY_REGISTRAR_KEY}]" size="40" maxlength="80" value="{PARAM_DISPLAY_REGISTRAR_VALUE}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_REGISTRAR_PORT}</td>

                    <td class="bb">{PARAM_DISPLAY_REGISTRAR_PORT_VALUE}&nbsp;</td>

                    <td width="20" class="lb">5.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[{PARAM_DISPLAY_REGISTRAR_PORT_KEY}]" size="40" maxlength="80" value="{PARAM_DISPLAY_REGISTRAR_PORT_VALUE}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_EXTENSION}</td>

                    <td class="bb">{PARAM_DISPLAY_EXTENSION_VALUE}&nbsp;</td>

                    <td width="20" class="lb">6.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[{PARAM_DISPLAY_EXTENSION_KEY}]" size="40" maxlength="80" value="{PARAM_DISPLAY_EXTENSION_VALUE}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_AUTHENTICATION}</td>

                    <td class="bb">{PARAM_DISPLAY_AUTHENTICATION_VALUE}&nbsp;</td>

                    <td width="20" class="lb">7.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[{PARAM_DISPLAY_AUTHENTICATION_KEY}]" size="40" maxlength="80" value="{PARAM_DISPLAY_AUTHENTICATION_VALUE}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_PASSWORD}</td>

                    <td class="bb">{PARAM_DISPLAY_PASSWORD_VALUE}&nbsp;</td>

                    <td width="20" class="lb">8.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[{PARAM_DISPLAY_PASSWORD_KEY}]" size="40" maxlength="80" value="{PARAM_DISPLAY_PASSWORD_VALUE}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_OUTDIAL}</td>

                    <td class="bb">{PARAM_DISPLAY_OUTDIAL_VALUE}&nbsp;</td>

                    <td width="20" class="lb">9.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[{PARAM_DISPLAY_OUTDIAL_KEY}]" size="40" maxlength="80" value="{PARAM_DISPLAY_OUTDIAL_VALUE}">
                    </td>
                  </tr>

                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_AUTO_ANSWER_ENABLED}</td>

                    <td class="bb">{PARAM_DISPLAY_AUTO_ANSWER_ENABLED_VALUE}
                    &nbsp;</td>

                    <td width="20" class="lb">10.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[{PARAM_DISPLAY_AUTO_ANSWER_ENABLED_KEY}]" {PARAM_AUTO_ANSWER_ENABLED_VALUE} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[{PARAM_DISPLAY_AUTO_ANSWER_ENABLED_KEY}]" {PARAM_AUTO_ANSWER_DISABLED_VALUE} value="RADIO_NO">NO
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_OUTDIAL_ON_SENSOR_ENABLED}</td>

                    <td class="bb">{PARAM_DISPLAY_OUTDIAL_ON_SENSOR_ENABLED_VALUE}
                    &nbsp;</td>

                    <td width="20" class="lb">11.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[{PARAM_DISPLAY_OUTDIAL_ON_SENSOR_ENABLED_KEY}]" {PARAM_OUTDIAL_ON_SENSOR_ENABLED_VALUE} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[{PARAM_DISPLAY_OUTDIAL_ON_SENSOR_ENABLED_KEY}]" {PARAM_OUTDIAL_ON_SENSOR_DISABLED_VALUE} value="RADIO_NO">NO
                    </td>
                  </tr>

                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_PROXY_ENABLED}</td>

                    <td class="bb">{PARAM_DISPLAY_PROXY_ENABLED_VALUE}
                    &nbsp;</td>

                    <td width="20" class="lb">12.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[{PARAM_DISPLAY_PROXY_ENABLED_KEY}]" {PARAM_PROXY_ENABLED_VALUE} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[{PARAM_DISPLAY_PROXY_ENABLED_KEY}]" {PARAM_PROXY_DISABLED_VALUE} value="RADIO_NO">NO
                    </td>
                  </tr>

                  <!-- END DEVICE_ENTRY -->
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
			<input type="hidden" name="deviceFilter" id="deviceFilter_INPUT" value="{HIDDEN_DEVICE_FILTER}" >
            <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{HIDDEN_TIMENOW}" >
            <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{HIDDEN_SESSION}" >
        </form>
        <!-- END DEVICE_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
