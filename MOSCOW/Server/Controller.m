//
//  Controller.m
//  MOSCOW
//
//  Created by Chandler McWilliams on 5/14/09.
//  Copyright 2009 RepetitionRepetition. All rights reserved.
//


#import "Controller.h"
#import "OSCServer.h"


@implementation Controller

- (id)init
{
	if (self = [super init]) {
		 // create our OSCServer
		port = 9000;
		host = @"127.0.0.1";
		oscserver = [[OSCServer alloc] initWithHost:host port:port];
		
		// and our navigator
		navigator = [[SpaceNavigator alloc] init];
		[navigator setDelegate:self];
		
		// auto discover the wiimote
		discovery = [[WiiRemoteDiscovery alloc] init];
		[discovery setDelegate:self];
		[discovery start];
	 }

    return self;
}


// sweet release
- (void)dealloc
{
	[oscserver release], oscserver = nil;
	[navigator release], navigator = nil;

	if (wii) {
		[wii closeConnection];
		[wii release], wii = nil;
	}
	if (discovery) [discovery release], discovery = nil;
	
	[super dealloc];
}



#pragma mark SpaceNavigator Delegate Methods
// when the sn knob changes
- (void)spaceNavigatorButtonChanged:(SpaceNavigatorButtonType)type isPressed:(BOOL)isPressed
{
	[oscserver sendNavigatorButton:((type == SpaceNavigatorRightButton)?2:1) isPressed:isPressed];
}

- (void)spaceNavigatorValuesChanged:(float *)translation rotation:(float *)rotation
{
	
	[oscserver sendNavigatorTranslationX:translation[0]
									   Y:translation[1]
									   Z:translation[2]];
	
	[oscserver sendNavigatorRotationX:rotation[0]
									Y:rotation[1]
									Z:rotation[2]];	
}


#pragma mark WiiMote Delegate Methods
- (void)WiiRemoteDiscovered:(WiiRemote*)wiimote
{
	NSLog(@"Connected to WiiRemote.");	
	[discovery stop];
	
	// just one for now...
	wii = wiimote;
	[wii setDelegate:self];
	[wii setLEDEnabled1:NO enabled2:NO enabled3:NO enabled4:NO];
	[wii setMotionSensorEnabled:YES];
}

- (void)WiiRemoteDiscoveryError:(int)code
{
	NSLog(@"Discovery error: %d.", code);
}

- (void)wiiRemoteDisconnected:(IOBluetoothDevice*)device
{
	NSLog(@"Disconnected from WiiMote: %@", wii);
	[wii release], wii = nil;
}

#pragma mark WiiMote input handlers
- (void)accelerationChanged:(WiiAccelerationSensorType)type accX:(unsigned char)accX accY:(unsigned char)accY accZ:(unsigned char)accZ wiiRemote:(WiiRemote*)wiiRemote
{
	[oscserver sendWiiMoteAccelerationX:(float)accX/255.0
									  Y:(float)accY/255.0
									  Z:(float)accZ/255.0];	
}


- (void)joyStickChanged:(WiiJoyStickType)type tiltX:(unsigned char)tiltX tiltY:(unsigned char)tiltY wiiRemote:(WiiRemote*)wiiRemote
{
	NSLog(@"joyStickChanged");
	if (type == WiiNunchukJoyStick) {
		NSLog(@"yes");
		[oscserver sendWiiMoteJoyStickX:(float)tiltX/255.0
									  Y:(float)tiltY/255.0];
	}
}

- (void)buttonChanged:(WiiButtonType)type isPressed:(BOOL)isPressed wiiRemote:(WiiRemote*)wiiRemote
{
	NSString *typeName;
	switch(type) {
		case WiiRemoteAButton:
			typeName = @"A";
			break;
			
		case WiiRemoteBButton:
			typeName = @"B";
			break;
			
		case WiiRemoteOneButton:
			typeName = @"1";
			break;
			
		case WiiRemoteTwoButton:
			typeName = @"2";			
			break;
			
		case WiiRemoteMinusButton:
			typeName = @"Minus";			
			break;
			
		case WiiRemoteHomeButton:
			typeName = @"Home";			
			break;
			
		case WiiRemotePlusButton:
			typeName = @"Plus";			
			break;
			
		case WiiRemoteUpButton:
			typeName = @"Up";			
			break;
			
		case WiiRemoteDownButton:
			typeName = @"Down";			
			break;
			
		case WiiRemoteLeftButton:
			typeName = @"Left";			
			break;
			
		case WiiRemoteRightButton:
			typeName = @"Right";			
			break;
			
		case WiiNunchukZButton:
			typeName = @"Z";			
			break;
			
		case WiiNunchukCButton:
			typeName = @"C";			
			break;
			
		default:
			break;
	}
	
	[oscserver sendWiiMoteButton:typeName isPressed:isPressed];
}






/*
 TODO talk back
- (void)byteReceived:(uint8_t)byte
{
	SInt32 result;

	switch (byte) {
		case ENABLE_LED:
			ledState = YES;
			ConnexionControl(kConnexionCtlSetLEDState, kLEDOn, &result);
			break;

		case DISABLE_LED:
			ledState = NO;
			ConnexionControl(kConnexionCtlSetLEDState, kLEDOff, &result);
			break;

		default:
			break;
	}
}
*/


#pragma mark MISC
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
	return NO;
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
	[wii closeConnection];
	return NSTerminateNow;
}


@end
