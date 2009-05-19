//
//  GUIController.m
//  MOSCOW
//
//  Created by Chandler McWilliams on 5/14/09.
//  Copyright 2009 RepetitionRepetition. All rights reserved.
//

#import "GUIController.h"


@implementation GUIController

- (void)awakeFromNib
{	
	buttonOn = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"ButtonOn"]];
	buttonOff = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"ButtonOff"]];
}


#pragma mark SpaceNavigator Delegate Methods
- (void)spaceNavigatorButtonChanged:(SpaceNavigatorButtonType)type isPressed:(BOOL)isPressed
{
	switch(type) {
		case SpaceNavigatorLeftButton:
			[buttonLeft setImage:isPressed?buttonOn:buttonOff];
			break;
			
		case SpaceNavigatorRightButton:
			[buttonRight setImage:isPressed?buttonOn:buttonOff];
			break;
	}	
	
	[super spaceNavigatorButtonChanged:type isPressed:isPressed];
}

- (void)spaceNavigatorValuesChanged:(float *)translation rotation:(float *)rotation
{
	[snTranslationX setStringValue:[NSString stringWithFormat:@"%f", translation[0]]];
	[snTranslationY setStringValue:[NSString stringWithFormat:@"%f", translation[1]]];
	[snTranslationZ setStringValue:[NSString stringWithFormat:@"%f", translation[2]]];

	[snRotationX setStringValue:[NSString stringWithFormat:@"%f", rotation[0]]];
	[snRotationY setStringValue:[NSString stringWithFormat:@"%f", rotation[1]]];
	[snRotationZ setStringValue:[NSString stringWithFormat:@"%f", rotation[2]]];
	
	[super spaceNavigatorValuesChanged:translation rotation:rotation];
}




# pragma mark UI ACTIONS
//- (IBAction)showPreferences:(id)sender
//{
//	[NSApp beginSheet:prefPane
//	   modalForWindow:mainWindow
//		modalDelegate:self
//	   didEndSelector:NULL
//		  contextInfo:nil];	
//	
//}
//
//- (IBAction)savePreferences:(id)sender
//{
//	// make sure the port isn't under 1025
//	//if ([port intValue] < 1025) {
//		NSAlert *alert = [NSAlert alertWithMessageText:@"You must enter a port number greater than 1025."
//										 defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@""];
//		[alert runModal]; 
//		return;
//	//}
//	
//	// make sure to save changes
//	[prefsController commitEditing];
//	
//	[prefPane orderOut:nil];
//	[NSApp endSheet:prefPane];
//}

@end
