using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Math;

class CirclesView extends WatchUi.WatchFace {

	var innerFont = null;
	var outerFont = null;

    function initialize() {
        WatchFace.initialize();        
        Math.srand(System.getTimer());
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
        innerFont = loadResource(Rez.Fonts.londrina_shadow);
        outerFont = loadResource(Rez.Fonts.londrina_solid);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    	dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
		dc.clear();
		
    	var colorArray = [Graphics.COLOR_RED, 
    					  Graphics.COLOR_ORANGE, 
    					  Graphics.COLOR_YELLOW, 
    					  Graphics.COLOR_GREEN, 
    					  Graphics.COLOR_BLUE, 
    					  Graphics.COLOR_PURPLE, 
    					  Graphics.COLOR_PINK];
    					  
    	var circleX = dc.getWidth() / 2;
    	var circleY = dc.getHeight() / 2;
    	var circleR = dc.getWidth() / 2; 
    	var deltaR 	= dc.getWidth() / 50; 
    	var colorIndex = 0; 
    	var prevColorIndex = -1;
    	
    	// Build tables
    	while (circleR > 0) {
    		do {
    			colorIndex = Math.rand() % colorArray.size(); 
    		} while (prevColorIndex == colorIndex);
    		prevColorIndex = colorIndex; 
    		dc.setColor(colorArray[colorIndex], colorArray[colorIndex]);
    		dc.fillCircle(circleX, circleY, circleR); 
    		circleR = circleR - deltaR; 
    	}
    	
    	var clockTime = System.getClockTime();
        var hour = clockTime.hour;
        hour = hour % 12;
        if (hour == 0) {
        	hour = 12; 
        }
        var timeString = Lang.format("$1$:$2$", [hour, clockTime.min.format("%02d")]);
        var timeFontSize = 64;
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, (dc.getHeight() / 2) - (timeFontSize / 2), outerFont, timeString, Graphics.TEXT_JUSTIFY_CENTER); 
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() / 2, (dc.getHeight() / 2) - (timeFontSize / 2), innerFont, timeString, Graphics.TEXT_JUSTIFY_CENTER); 
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
