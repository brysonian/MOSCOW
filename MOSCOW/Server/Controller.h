/** 
 
 Application Controller for Edric WiiRemote proxy server.
 In addition to normally app controller features,
 The controller holds the state of LEDs for the wiimote. This is due to the WiiRemote Framework only having
 one master method to update all LED's at one time, so we have to save the state of all LEDs to allow the user to
 toggle a single LED.
 
 */

#import <Cocoa/Cocoa.h>
#import "TdxDevEvents.h"
#import "OSCServer.h"

@class SpaceNavigator;

@interface Controller : NSObject
{	
	
	SpaceNavigator *navigator;
	OSCServer *oscserver;
	
	/** User's port */
	int port;

	/** User's host */
	NSString *host;
}


/**
 Respond to navigator values changes
 */
- (void)navigatorValuesChanged:(NSNotification *)notification;
- (void)navigatorRightButtonChanged:(NSNotification *)notification;
- (void)navigatorLeftButtonChanged:(NSNotification *)notification;



@end