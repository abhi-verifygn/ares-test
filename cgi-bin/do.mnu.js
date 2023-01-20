/******************************************************************************
**
**  COMPONENT:          do.mnu.js - support functions for Venus
**
**  REVISION:           $Revision:  $
**  LAST MODIFIED BY:   $Author:  $
**  DATE:               $Date:  $
**
** Support scripts for menu (mnu) page
**
*******************************************************************************
**
**  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
**
*******************************************************************************/

/******************************************************************************
** Function:    resetSel
** Parameters:      except [in]
** Returns:         nothing
**
**
*/
function resetSel( except )
{
    // Resets the selectors "except" the one passed in, if
    // 0 is passed in then all selectors are reset
    if ( except != 1)
    {
        if (document.getElementById("volume") != null )
        {
            document.volume.volist.selectedIndex=0;
        }
    }
    if ( except != 2)
    {
        if (document.getElementById("detector") != null )
        {
            document.detector.detlist.selectedIndex=0;
        }
    }
    if ( except != 3)
    {
        if (document.getElementById("group") != null )
        {
             document.group.grouplist.selectedIndex=0;
         }
     }
    if ( except != 4)
    {
        if (document.getElementById("goals") != null )
        {
            document.goals.goalslist.selectedIndex=0;
        }
    }
    if ( except != 5)
    {
        if (document.getElementById("greeter") != null )
        {
            document.greeter.greeterlist.selectedIndex=0;
        }
    }
}

/******************************************************************************
** Function:    showPage
** Parameters:      page [in]
**                  exceptIndex [in]
** Returns:         nothing
**
**
*/
function showPage( page, exceptIndex )
{
    if ( page != '' )
    {
        window.top.infowindow.location = page;
        resetSel( exceptIndex );
    }
}
