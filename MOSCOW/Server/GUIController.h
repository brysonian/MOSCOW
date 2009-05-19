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
	IBOutlet id snTranslationX;
	IBOutlet id snTranslationY;
	IBOutlet id snTranslationZ;
	IBOutlet id snRotationX;
	IBOutlet id snRotationY;
	IBOutlet id snRotationZ;
	
	IBOutlet id buttonLeft;
	IBOutlet id buttonRight;
	
	/** Button Images */
	NSImage *buttonOn;
	NSImage *buttonOff;
	
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
