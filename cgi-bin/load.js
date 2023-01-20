/******************************************************************************
**
**  COMPONENT:          load.js - support functions for Venus
**
**  REVISION:           $Revision:  $
**  LAST MODIFIED BY:   $Author:  $
**  DATE:               $Date:  $
**
** Provides pop-up support
**
*******************************************************************************
**
**  Copyright (c) TES Electronic Solutions Ltd, 2012-2013
**
*******************************************************************************/

function reload()
{
    window.location.href = window.location.href;
}

function show_loading_text( txt )
{
    var banner = document.getElementById('loading_bottom');

    if(banner)
    {
        banner.innerHTML = txt;
        show_popup('loading_popup');
    }
}

function show_popup(pname)
{
    var blk = document.getElementById('blockScreen');
    var popup = document.getElementById(pname);
    var pageMetrics = new getPageMetrics();

    if(blk && popup)
    {
        popup.style.display = 'block';
        popup.style.top = ((pageMetrics.windowHeight-popup.offsetHeight)/2)+pageMetrics.yOffset + "px";
        popup.style.left = ((pageMetrics.windowWidth-popup.offsetWidth)/2)+pageMetrics.xOffset + "px";
        blk.style.width = pageMetrics.pageWidth + 'px';
        blk.style.height = pageMetrics.pageHeight + 'px';
        blk.style.display = 'block';
    }
}

function hide_popup(pname)
{
    var blk = document.getElementById('blockScreen');
    var popup = document.getElementById(pname);

    if(blk && popup)
    {
        popup.style.display = 'none';
        blk.style.display = 'none';
    }
}

function getPageMetrics()
{
    if( window.pageYOffset )
    {
        this.yOffset = window.pageYOffset;
        this.xOffset = window.pageXOffset;
    }
    else if( document.body && document.body.scrollTop )
    {
        this.yOffset = document.body.scrollTop;
        this.xOffset = document.body.scrollLeft;
    }
    else
    {
        this.yOffset = document.documentElement.scrollTop;
        this.xOffset = document.documentElement.scrollLeft;
    }

    if (window.innerHeight && window.scrollMaxY)
    {
        this.xScroll = window.innerWidth + window.scrollMaxX;
        this.yScroll = window.innerHeight + window.scrollMaxY;
    } else if (document.body.scrollHeight > document.body.offsetHeight){ // all but Explorer Mac
        this.xScroll = document.body.scrollWidth;
        this.yScroll = document.body.scrollHeight;
    } else { // Explorer Mac...would also work in Explorer 6 Strict, Mozilla and Safari
        this.xScroll = document.body.offsetWidth;
        this.yScroll = document.body.offsetHeight;
    }

    if (self.innerHeight)
    {   // all except Explorer
        if(document.documentElement.clientWidth)
        {
            this.windowWidth = document.documentElement.clientWidth;
        } else
        {
            this.windowWidth = self.innerWidth;
        }
        this.windowHeight = self.innerHeight;
    } else if (document.documentElement && document.documentElement.clientHeight)
    { // Explorer 6 Strict Mode
        this.windowWidth = document.documentElement.clientWidth;
        this.windowHeight = document.documentElement.clientHeight;
    } else if (document.body)
    { // other Explorers
        this.windowWidth = document.body.clientWidth;
        this.windowHeight = document.body.clientHeight;
    }

        // for small pages with total height less then height of the viewport
    if(this.yScroll < this.windowHeight)
    {
        this.pageHeight = this.windowHeight;
    } else {
        this.pageHeight = this.yScroll;
    }

    // for small pages with total width less then width of the viewport
    if(this.xScroll < this.windowWidth)
    {
        this.pageWidth = this.xScroll;
    } else {
        this.pageWidth = this.windowWidth;
    }
}
