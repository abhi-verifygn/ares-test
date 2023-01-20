/******************************************************************************
**
**  COMPONENT:          do.lca.js - support functions for Venus
**
**  REVISION:           $Revision:  $
**  LAST MODIFIED BY:   $Author:  $
**  DATE:               $Date:  $
**
**  AJAX support for location (lca) page data update
**
*******************************************************************************
**
**  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
**
*******************************************************************************/

/******************************************************************************
** Function:    BuildQuery
** Parameters:      none
** Returns:         JSON formatted response, or null
**
** NB: Called by SubmitAjaxQuery defined in Venus_Helper.js.
**
** Collects data from various elements from the form and formats them
** first into an array of name value object pairs, then converts the
** array into a JSON representation for sending to the web-server.
**
*/
function BuildQuery()
{
    var aResult = null;

    var table = document.getElementById("tableData");
    if ( table != null )
    {
        var rows= table.getElementsByTagName("tr");
        var aData = new Array( rows.length );

        for ( var i=0; i < rows.length; i++ )
        {
            inputs = rows[i].getElementsByTagName( "input" );
            if ( inputs.length > 0 )
            {
                aData[ i ] = new Object();
                aData[ i ].name = inputs[0].name;
                aData[ i ].value = inputs[0].value;
            }
        }

        var aHelper = new Array( 2 );
        // Add in session and timestamp
        if ( timestamp = document.getElementById( "timestamp_INPUT" ) )
        {
            aHelper[ 0 ] = new Object();
            aHelper[ 0 ].name = timestamp.name;
            aHelper[ 0 ].value = timestamp.value;
        }
        if ( sessionID = document.getElementById( "sessionID_INPUT" ) )
        {
            aHelper[ 1 ] = new Object();
            aHelper[ 1 ].name = sessionID.name;
            aHelper[ 1 ].value = sessionID.value;
        }

        aResult = aHelper.concat( aData );
    }
    return aResult.toJSONString();
}

/******************************************************************************
** Function:    OnData
** Parameters:      none
** Returns:         none
**
** NB: accesses GLOBAL httpObj defined in Venus_Helper.js script file.
** Called by SubmitAjaxQuery also defined in Venus_Helper.js
**
** This routine updates the page content based on an incoming JSON
** object. The operations with the content is dependent on the page
**
** Elements interacted with are typically defined in the .tpl template
** for this page.
**
*/
function OnData()
{
    if ( httpObj == null )
    {
        return;
    }
    if ( httpObj.readyState==4 )
    {
        var errorText = null;
        var disableSubmit = false;
        var table = document.getElementById("tableData");

        if (httpObj.status==200 ) {
            try {
                // Safe consumption of JSON using json.js parseJSON.
                var objects =
                  new String(httpObj.responseText).parseJSON( null );
                for ( var i = 0; i < objects.length; i++ )
                {
                    var nameValuePair = objects[i];
                    try
                    {
                        if ( nameValuePair.ID == "error" )
                        {
                            disableSubmit = true;
                        }
                        var element = document.getElementById( nameValuePair.ID + "_TD" );
                        if ( element != null )
                        {
                            element.innerText = nameValuePair.Value;
                        }
                        var element = document.getElementById( nameValuePair.ID + "_INPUT" );
                        if ( element != null )
                        {
                            element.value = nameValuePair.Value;
                        }
                    }
                    catch (e) {
                        // ignore - most likely an unused parameter
                    }
                }

                var element = document.getElementById( "submitFormButton" );
                if ( element != null )
                {
                    element.disabled = disableSubmit;
                }
          }
          catch (e)
          {
            errorText = "Response is expecting to be JSON. Error given: '"
                        + e.message + "'\n";
            if ( httpObj.responseText != null )
            {
                // Reveal up to a maximum of 200 characters (or as
                // many in the string) from the decoded response -
                // would reveal error messages from the server (if sent)
                errorText += httpObj.responseText.substring( 0, 200 );
            }
          }
        }
        else
        {
            errorText = "Web-page, is unavailable.";
        }

        // Null object to prevent memory leaks and browser slow down
        httpObj = null;

        if ( errorText != null )
        {
            alert( errorText );
        }
    }
}


