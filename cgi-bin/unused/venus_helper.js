/******************************************************************************
**
**  COMPONENT:          venus_helper.js - support functions for Venus
**
**  REVISION:           $Revision:  $
**  LAST MODIFIED BY:   $Author:  $
**  DATE:               $Date:  $
**
**  Provides a common functionality providing support for the venus platform
**
*******************************************************************************
**
**  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
**
*******************************************************************************/

/******************************************************************************/
/*    GLOBALS                                                                 */
/******************************************************************************/
var httpObj = null;

/******************************************************************************
** Function:    NewHTTP
** Parameters:      none
** Returns:         returns either an XMLHttpRequest() object, or the ActiveX
**                  equivallent
**
** NB: Called by SubmitAjaxQuery.
**
** Common workaround used to work with AJAX on older InternetExplorer browsers
** which do not support the XMLHttpRequest() object used for micro-communications
** between browser and web-server.
**
*/
function NewHTTP()
{
    try
    {
        return new XMLHttpRequest();
    }
    catch ( e )
    {
        return new ActiveXObject( "Microsoft.XMLHTTP" );
    }
}

/******************************************************************************
** Function:    SubmitAjaxQuery
** Parameters:      URL [in] a PHP script file that can process JSON data
**                  BuildQuery [in] the function used to collect data in JSON
**                  OnData [in] the function to be called on server's response
** Returns:         returns false to prevent the form from processing the
**                  submit request, otherwise returns forcing posting to occur
**
** NB: Creates GLOBAL object httpObj in the users browser memory space.
*
** Called by the form submission routine of a web-page typically to
** update data presented in the form.
**
** Coordinates the set-up of a requesting object that sends data in JSON
** format to the script pointed at by URL. The data is collected by the
** BuildQuery function passed in and is page content dependent. The
** function also sets up that the OnData function passed in is the function
** that should be called when the web-server responds.
**
** NB: to prevent memory leaks for the browser the OnData script MUST null the
**     httpObj when done.
**
*/
function SubmitAjaxQuery( URL, BuildQuery, OnData )
{
       if ( httpObj != null )
       {
           return;
       }

       var aResult = BuildQuery();
       if ( aResult == null )
       {
           return;
       }

       httpObj = NewHTTP();
       httpObj.open("POST", URL + "?",true);
       httpObj.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
       httpObj.onreadystatechange = OnData;
       httpObj.send("JSONParams=" + escape( aResult ) );

       return false;
}
