//
//  GUIController.m
//  MOSCOW
//
//  Created by Chandler McWilliams on 5/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GUIController.h"


@implementation GUIController

# pragma mark UI ACTIONS
- (IBAction)showPreferences:(id)sender
{
	[NSApp beginSheet:prefPane
	   modalForWindow:mainWindow
		modalDelegate:self
	   didEndSelector:NULL
		  contextInfo:nil];	
	
}

- (IBAction)savePreferences:(id)sender
{
	// make sure the port isn't under 1025
	//if ([port intValue] < 1025) {
		NSAlert *alert = [NSAlert alertWithMessageText:@"You must enter a port number greater than 1025."
										 defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
		[alert runModal]; 
		return;
	//}
	
	// make sure to save changes
	[prefsController commitEditing];
	
	[prefPane orderOut:nil];
	[NSApp endSheet:prefPane];
}

@end
