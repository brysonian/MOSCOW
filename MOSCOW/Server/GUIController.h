//
//  GUIController.h
//  MOSCOW
//
//  Created by Chandler McWilliams on 5/14/09.
//  Copyright 2009 RepetitionRepetition. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Controller.h"


@interface GUIController : Controller {
	
	/** Outlet for SN HUD */
	IBOutlet id spaceNavigatorHUD;
	
	/** Outlet for preferences window */
	IBOutlet id prefPane;
	
	/** Outlet for prefs controller */
	IBOutlet id prefsController;

	
	/** Monitor View Outlets */
	// space navigator
	IBOutlet id snTranslationX;
	IBOutlet id snTranslationY;
	IBOutlet id snTranslationZ;
	IBOutlet id snRotationX;
	IBOutlet id snRotationY;
	IBOutlet id snRotationZ;
	
	IBOutlet id snButtonLeft;
	IBOutlet id snButtonRight;

	// wiimote
	IBOutlet id statusBox;
	IBOutlet id searchIndicator;
	
	IBOutlet id displayBox;
	IBOutlet id accXField;
	IBOutlet id accYField;
	IBOutlet id accZField;
	
	IBOutlet id buttonAImage;
	IBOutlet id buttonBImage;
	
	IBOutlet id button1Image;
	IBOutlet id button2Image;
	
	IBOutlet id buttonPlus;
	IBOutlet id buttonMinus;
	
	IBOutlet id buttonHome;
	
	IBOutlet id buttonUp;
	IBOutlet id buttonDown;
	IBOutlet id buttonLeft;
	IBOutlet id buttonRight;
	
	// nunchuck outlets
	IBOutlet id monitorNunchuckBox;
	IBOutlet id joyXField;
	IBOutlet id joyYField;
	
	IBOutlet id buttonZ;
	IBOutlet id buttonC;
	
	/** Button Images */
	NSImage *buttonOn;
	NSImage *buttonOff;
	NSImage *dPadOn;
	NSImage *dPadOff;
	
}

/**
 Called by interface to show preferences
 @param id Calling object
 */
- (IBAction)showPreferences:(id)sender;

/**
 Called by interface to save preferences
 @param id Calling object
 */
- (IBAction)savePreferences:(id)sender;


@end
