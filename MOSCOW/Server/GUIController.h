//
//  GUIController.h
//  MOSCOW
//
//  Created by Chandler McWilliams on 5/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface GUIController : NSObject {
	
	/** Outlet for main window */
	IBOutlet id mainWindow;
	
	/** Outlet for preferences window */
	IBOutlet id prefPane;
	
	/** Outlet for prefs controller */
	IBOutlet id prefsController;

	
	/** Monitor View Outlets */
	IBOutlet id axis0Field;
	IBOutlet id axis1Field;
	IBOutlet id axis2Field;
	IBOutlet id axis3Field;
	IBOutlet id axis4Field;
	IBOutlet id axis5Field;
	
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
