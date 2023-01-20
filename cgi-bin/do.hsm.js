/******************************************************************************
**
**  COMPONENT:          do.hsm.js - support functions for Venus
**
**  REVISION:           $Revision:  $
**  LAST MODIFIED BY:   $Author:  $
**  DATE:               $Date:  $
**
**  Support JavaScript for the headset configuration page
**
*******************************************************************************
**
**  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
**
*******************************************************************************/

var boClosing = false;


/******************************************************************************
** Function:    open_openbase_popup
** Parameters:      none
** Returns:         none
**
**
*/
function open_openbase_popup( timeStamp, sessionID )
{
    show_popup("openbase_popup");
    trigger_Req("OPENED", timeStamp, sessionID );
}

/******************************************************************************
** Function:    close_openbase_popup
** Parameters:      none
** Returns:         none
**
**
*/
function close_openbase_popup()
{
    hide_popup("openbase_popup");
    show_loading_text("Updating...");
    reload();
}

var http;

/******************************************************************************
** Function:    trigger_Req
** Parameters:      reqste [IN] (Values OPENED or CLOSED)
** Returns:         none
**
**
*/
function trigger_Req(reqstr, timeStamp, sessionID)        // OPENED or CLOSED
{
    var url = "do.act.php";
    var params = "BASE_OPEN="+reqstr+"&timestamp="+timeStamp+"&sessionID="+sessionID;
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

/******************************************************************************
** Function:    on_ReqStateChange
** Parameters:      none
** Returns:         none
**
**
*/
function on_ReqStateChange()
{//Call a function when the state changes.
    if(http.readyState == 4 && http.status == 200)
    {
        var doc = http.responseText;
        document.getElementById( "trackstate" ).innerHTML = doc;

        if( boClosing )
        {
            close_openbase_popup();
        }
    }
}
