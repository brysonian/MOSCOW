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

	dPadOn = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"d-padOn"]];
	dPadOff = [[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:@"d-padOff"]];	

	[searchIndicator startAnimation:self];

	if (![SpaceNavigator isAvailable]) {
		[spaceNavigatorHUD close];
	}
	
	
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

#pragma mark WiiMote Delegate Methods
- (void)WiiRemoteDiscovered:(WiiRemote*)wiimote
{
	[super WiiRemoteDiscovered:wiimote];
	[displayBox setHidden:NO];
	[statusBox setHidden:YES];
	[searchIndicator stopAnimation:self];
}


- (void)accelerationChanged:(WiiAccelerationSensorType)type accX:(unsigned char)accX accY:(unsigned char)accY accZ:(unsigned char)accZ wiiRemote:(WiiRemote*)wiiRemote
{
	[accXField setStringValue:[NSString stringWithFormat:@"%f", accX/255.0]];
	[accYField setStringValue:[NSString stringWithFormat:@"%f", accY/255.0]];
	[accZField setStringValue:[NSString stringWithFormat:@"%f", accZ/255.0]];
	
	[super accelerationChanged:type accX:accX accY:accY accZ:accZ wiiRemote:wiiRemote];
}


- (void)joyStickChanged:(WiiJoyStickType)type tiltX:(unsigned char)tiltX tiltY:(unsigned char)tiltY wiiRemote:(WiiRemote*)wiiRemote
{
	if (type == WiiNunchukJoyStick) {
		[joyXField setStringValue:[NSString stringWithFormat:@"%f", tiltX/255.0]];
		[joyYField setStringValue:[NSString stringWithFormat:@"%f", tiltY/255.0]];
		
		[super joyStickChanged:type tiltX:tiltX tiltY:tiltY wiiRemote:wiiRemote];
	}
}

- (void)buttonChanged:(WiiButtonType)type isPressed:(BOOL)isPressed wiiRemote:(WiiRemote*)wiiRemote
{
	
	switch(type) {
		case WiiRemoteAButton:
			[buttonAImage setImage:isPressed?buttonOn:buttonOff];
			break;
			
		case WiiRemoteBButton:
			[buttonBImage setImage:isPressed?buttonOn:buttonOff];
			break;
			
		case WiiRemoteOneButton:
			[button1Image setImage:isPressed?buttonOn:buttonOff];
			break;
			
		case WiiRemoteTwoButton:
			[button2Image setImage:isPressed?buttonOn:buttonOff];
			break;
			
		case WiiRemoteMinusButton:
			[buttonMinus setImage:isPressed?buttonOn:buttonOff];
			break;
			
		case WiiRemoteHomeButton:
			[buttonHome setImage:isPressed?buttonOn:buttonOff];
			break;
			
		case WiiRemotePlusButton:
			[buttonPlus setImage:isPressed?buttonOn:buttonOff];
			break;
			
		case WiiRemoteUpButton:
			[buttonUp setImage:isPressed?dPadOn:dPadOff];
			break;
			
		case WiiRemoteDownButton:
			[buttonDown setImage:isPressed?dPadOn:dPadOff];
			break;
			
		case WiiRemoteLeftButton:
			[buttonLeft setImage:isPressed?dPadOn:dPadOff];
			break;
			
		case WiiRemoteRightButton:
			[buttonRight setImage:isPressed?dPadOn:dPadOff];
			break;
			
		case WiiNunchukZButton:
			[buttonZ setImage:isPressed?buttonOn:buttonOff];
			break;
			
		case WiiNunchukCButton:
			[buttonC setImage:isPressed?buttonOn:buttonOff];
			break;
			
		default:
			break;
	}
	[super buttonChanged:type isPressed:isPressed wiiRemote:wiiRemote];
	
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
