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
        <!-- BEGIN VOIP_FORM -->
        <form action="do.voip.php" method="post" name="FormVoIPConfiguration" id=
        "FormVoIPConfiguration" accept-charset="ISO-8859-1">
          <blockquote>
            {TITLE}
          </blockquote>

          <table class="M1" align="center" border="1" cellspacing=
          "6">
            <tr>
              <td class="M2">
                <table class="M3" align="center" cellspacing="0"
                cellpadding="4">
                  <tr>
                  <th class="th1a"></th>
                  <th class="th1a" colspan="3"><span class="th1b">{L1HEAD}</span></th>
                  <th class="th1a" colspan="3"><span class="th1b">{L2HEAD}</span></th>
                  </tr>
                <!-- BEGIN VOIP_ENTRY -->
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_ENABLED}</td>

                    <td class="bb">{PARAM_DISPLAY_ENABLED_VALUE_L1}
                    &nbsp;</td>

                    <td width="20" class="lb">1.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[Lane1VoIPEnabled]" {PARAM_ENABLED_L1} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[Lane1VoIPEnabled]" {PARAM_DISABLED_L1} value="RADIO_NO">NO
                    </td>

                    <td class="bb">{PARAM_DISPLAY_ENABLED_VALUE_L2}
                    &nbsp;</td>

                    <td width="20" class="lb">2.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[Lane2VoIPEnabled]" {PARAM_ENABLED_L2} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[Lane2VoIPEnabled]" {PARAM_DISABLED_L2} value="RADIO_NO">NO
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_REG_STATUS}</td>

                    <td class="bb">{PARAM_DISPLAY_REG_STATUS_VALUE_L1}&nbsp;</td>

                    <td width="20" class="lb"></td>

                    <td width="130" class="m4">
                    </td>

                    <td class="bb">{PARAM_DISPLAY_REG_STATUS_VALUE_L2}&nbsp;</td>

                    <td width="20" class="lb"></td>
                    
                    <td width="130" class="m4">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_CALL_STATUS}</td>

                    <td class="bb">{PARAM_DISPLAY_CALL_STATUS_VALUE_L1}&nbsp;</td>

                    <td width="20" class="lb"></td>

                    <td width="130" class="m4">
                    </td>

                    <td class="bb">{PARAM_DISPLAY_CALL_STATUS_VALUE_L2}&nbsp;</td>

                    <td width="20" class="lb"></td>
                    
                    <td width="130" class="m4">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_SERVER}</td>

                    <td class="bb">{PARAM_DISPLAY_SERVER_VALUE_L1}&nbsp;</td>

                    <td width="20" class="lb">3.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[Lane1VoIPServer]" size="40" maxlength="80" value="{PARAM_DISPLAY_SERVER_VALUE_L1}">
                    </td>

                    <td class="bb">{PARAM_DISPLAY_SERVER_VALUE_L2}&nbsp;</td>

                    <td width="20" class="lb">4.</td>
                    
                    <td width="130" class="m4">
                    <input type="text" name="params[Lane2VoIPServer]" size="40" maxlength="80" value="{PARAM_DISPLAY_SERVER_VALUE_L2}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_SERVER_PORT}</td>

                    <td class="bb">{PARAM_DISPLAY_SERVER_PORT_VALUE_L1}&nbsp;</td>

                    <td width="20" class="lb">5.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[Lane1VoIPServerPort]" size="40" maxlength="80" value="{PARAM_DISPLAY_SERVER_PORT_VALUE_L1}">
                    </td>

                    <td class="bb">{PARAM_DISPLAY_SERVER_PORT_VALUE_L2}&nbsp;</td>

                    <td width="20" class="lb">6.</td>
                    
                    <td width="130" class="m4">
                    <input type="text" name="params[Lane2VoIPServerPort]" size="40" maxlength="80" value="{PARAM_DISPLAY_SERVER_PORT_VALUE_L2}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_REGISTRAR}</td>

                    <td class="bb">{PARAM_DISPLAY_REGISTRAR_VALUE_L1}&nbsp;</td>

                    <td width="20" class="lb">7.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[Lane1VoIPRegistrar]" size="40" maxlength="80" value="{PARAM_DISPLAY_REGISTRAR_VALUE_L1}">
                    </td>

                    <td class="bb">{PARAM_DISPLAY_REGISTRAR_VALUE_L2}&nbsp;</td>

                    <td width="20" class="lb">8.</td>
                    
                    <td width="130" class="m4">
                    <input type="text" name="params[Lane2VoIPRegistrar]" size="40" maxlength="80" value="{PARAM_DISPLAY_REGISTRAR_VALUE_L2}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_REGISTRAR_PORT}</td>

                    <td class="bb">{PARAM_DISPLAY_REGISTRAR_PORT_VALUE_L1}&nbsp;</td>

                    <td width="20" class="lb">9.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[Lane1VoIPRegistrarPort]" size="40" maxlength="80" value="{PARAM_DISPLAY_REGISTRAR_PORT_VALUE_L1}">
                    </td>

                    <td class="bb">{PARAM_DISPLAY_REGISTRAR_PORT_VALUE_L2}&nbsp;</td>

                    <td width="20" class="lb">10.</td>
                    
                    <td width="130" class="m4">
                    <input type="text" name="params[Lane2VoIPRegistrarPort]" size="40" maxlength="80" value="{PARAM_DISPLAY_REGISTRAR_PORT_VALUE_L2}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_EXTENSION}</td>

                    <td class="bb">{PARAM_DISPLAY_EXTENSION_VALUE_L1}&nbsp;</td>

                    <td width="20" class="lb">11.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[Lane1VoIPExtension]" size="40" maxlength="80" value="{PARAM_DISPLAY_EXTENSION_VALUE_L1}">
                    </td>

                    <td class="bb">{PARAM_DISPLAY_EXTENSION_VALUE_L2}&nbsp;</td>

                    <td width="20" class="lb">12.</td>
                    
                    <td width="130" class="m4">
                    <input type="text" name="params[Lane2VoIPExtension]" size="40" maxlength="80" value="{PARAM_DISPLAY_EXTENSION_VALUE_L2}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_AUTHENTICATION}</td>

                    <td class="bb">{PARAM_DISPLAY_AUTHENTICATION_VALUE_L1}&nbsp;</td>

                    <td width="20" class="lb">11.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[Lane1VoIPAuthentication]" size="40" maxlength="80" value="{PARAM_DISPLAY_AUTHENTICATION_VALUE_L1}">
                    </td>

                    <td class="bb">{PARAM_DISPLAY_AUTHENTICATION_VALUE_L2}&nbsp;</td>

                    <td width="20" class="lb">12.</td>
                    
                    <td width="130" class="m4">
                    <input type="text" name="params[Lane2VoIPAuthentication]" size="40" maxlength="80" value="{PARAM_DISPLAY_AUTHENTICATION_VALUE_L2}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_PASSWORD}</td>

                    <td class="bb">{PARAM_DISPLAY_PASSWORD_VALUE_L1}&nbsp;</td>

                    <td width="20" class="lb">13.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[Lane1VoIPPassword]" size="40" maxlength="80" value="{PARAM_DISPLAY_PASSWORD_VALUE_L1}">
                    </td>

                    <td class="bb">{PARAM_DISPLAY_PASSWORD_VALUE_L2}&nbsp;</td>

                    <td width="20" class="lb">14.</td>
                    
                    <td width="130" class="m4">
                    <input type="text" name="params[Lane2VoIPPassword]" size="40" maxlength="80" value="{PARAM_DISPLAY_PASSWORD_VALUE_L2}">
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_OUTDIAL}</td>

                    <td class="bb">{PARAM_DISPLAY_OUTDIAL_VALUE_L1}&nbsp;</td>

                    <td width="20" class="lb">15.</td>

                    <td width="130" class="m4">
                    <input type="text" name="params[Lane1VoIPOutDial]" size="40" maxlength="80" value="{PARAM_DISPLAY_OUTDIAL_VALUE_L1}">
                    </td>

                    <td class="bb">{PARAM_DISPLAY_OUTDIAL_VALUE_L2}&nbsp;</td>

                    <td width="20" class="lb">16.</td>
                    
                    <td width="130" class="m4">
                    <input type="text" name="params[Lane2VoIPOutDial]" size="40" maxlength="80" value="{PARAM_DISPLAY_OUTDIAL_VALUE_L2}">
                    </td>
                  </tr>

                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_AUTO_ANSWER_ENABLED}</td>

                    <td class="bb">{PARAM_DISPLAY_AUTO_ANSWER_ENABLED_VALUE_L1}
                    &nbsp;</td>

                    <td width="20" class="lb">17.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[Lane1VoIPAutoAnswer]" {PARAM_AUTO_ANSWER_ENABLED_VALUE_L1} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[Lane1VoIPAutoAnswer]" {PARAM_AUTO_ANSWER_DISABLED_VALUE_L1} value="RADIO_NO">NO
                    </td>

                    <td class="bb">{PARAM_DISPLAY_AUTO_ANSWER_ENABLED_VALUE_L2}
                    &nbsp;</td>

                    <td width="20" class="lb">18.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[Lane2VoIPAutoAnswer]" {PARAM_AUTO_ANSWER_ENABLED_VALUE_L2} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[Lane2VoIPAutoAnswer]" {PARAM_AUTO_ANSWER_DISABLED_VALUE_L2} value="RADIO_NO">NO
                    </td>
                  </tr>
                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_OUTDIAL_ON_SENSOR_ENABLED}</td>

                    <td class="bb">{PARAM_DISPLAY_OUTDIAL_ON_SENSOR_ENABLED_VALUE_L1}
                    &nbsp;</td>

                    <td width="20" class="lb">17.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[Lane1VoIPOutDialOnSensor]" {PARAM_OUTDIAL_ON_SENSOR_ENABLED_VALUE_L1} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[Lane1VoIPOutDialOnSensor]" {PARAM_OUTDIAL_ON_SENSOR_DISABLED_VALUE_L1} value="RADIO_NO">NO
                    </td>

                    <td class="bb">{PARAM_DISPLAY_OUTDIAL_ON_SENSOR_ENABLED_VALUE_L2}
                    &nbsp;</td>

                    <td width="20" class="lb">18.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[Lane2VoIPOutDialOnSensor]" {PARAM_OUTDIAL_ON_SENSOR_ENABLED_VALUE_L2} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[Lane2VoIPOutDialOnSensor]" {PARAM_OUTDIAL_ON_SENSOR_DISABLED_VALUE_L2} value="RADIO_NO">NO
                    </td>
                  </tr>

                  <tr>
                    <td width="335" class="rb">{PARAM_DISPLAY_TITLE_PROXY_ENABLED}</td>

                    <td class="bb">{PARAM_DISPLAY_PROXY_ENABLED_VALUE_L1}
                    &nbsp;</td>

                    <td width="20" class="lb">17.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[Lane1VoIPProxyEnabled]" {PARAM_PROXY_ENABLED_VALUE_L1} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[Lane1VoIPProxyEnabled]" {PARAM_PROXY_DISABLED_VALUE_L1} value="RADIO_NO">NO
                    </td>

                    <td class="bb">{PARAM_DISPLAY_PROXY_ENABLED_VALUE_L2}
                    &nbsp;</td>

                    <td width="20" class="lb">18.</td>

                    <td width="130" class="m4">
                    <input type="radio" name="params[Lane2VoIPProxyEnabled]" {PARAM_PROXY_ENABLED_VALUE_L2} value="RADIO_YES">YES
                    &nbsp;&nbsp;|&nbsp;
                    <input type="radio" name="params[Lane2VoIPProxyEnabled]" {PARAM_PROXY_DISABLED_VALUE_L2} value="RADIO_NO">NO
                    </td>
                  </tr>

                  <!-- END VOIP_ENTRY -->
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
            <input type="hidden" name="timestamp" id="timestamp_INPUT" value="{HIDDEN_TIMENOW}" >
            <input type="hidden" name="sessionID" id="sessionID_INPUT" value="{HIDDEN_SESSION}" >
        </form>
        <!-- END VOIP_FORM -->
      </td>
    </tr>
  </table>
</body>
</html>
