//
//  Controller.h
//  MOSCOW
//
//  Created by Chandler McWilliams on 5/14/09.
//  Copyright 2009 RepetitionRepetition. All rights reserved.
//

/*
 
 TODO:
 let user set host
 let user set port
	these work via GUI and CLI
 wiimote HUD
 CLI target
 expanded wiimote support  
 
*/

#import <Cocoa/Cocoa.h>
#import "TdxDevEvents.h"

@class OSCServer;
#import "SpaceNavigator.h"
#import <WiiRemote/WiiRemote.h>
#import <WiiRemote/WiiRemoteDiscovery.h>


@interface Controller : NSObject
{	
	
	SpaceNavigator *navigator;
	OSCServer *oscserver;

	/** Object which handles discovery of wiimote, part of the WiiRemote Framework */
	WiiRemoteDiscovery *discovery;
	
	/** Wii object to interface with the remote */
	WiiRemote* wii;	
	
	/** User's OSC port */
	int port;

	/** User's OSC host */
	NSString *host;
	
}


#pragma mark SpaceNavigator Actions
- (void)spaceNavigatorButtonChanged:(SpaceNavigatorButtonType)type isPressed:(BOOL)isPressed;
- (void)spaceNavigatorValuesChanged:(float *)translation rotation:(float *)rotation;


#pragma mark WiiMote Delegate Methods
- (void)WiiRemoteDiscovered:(WiiRemote*)wiimote;
- (void)WiiRemoteDiscoveryError:(int)code;
- (void)wiiRemoteDisconnected:(IOBluetoothDevice*)device;
- (void)accelerationChanged:(WiiAccelerationSensorType)type accX:(unsigned char)accX accY:(unsigned char)accY accZ:(unsigned char)accZ wiiRemote:(WiiRemote*)wiiRemote;
- (void)joyStickChanged:(WiiJoyStickType)type tiltX:(unsigned char)tiltX tiltY:(unsigned char)tiltY wiiRemote:(WiiRemote*)wiiRemote;
- (void)buttonChanged:(WiiButtonType)type isPressed:(BOOL)isPressed wiiRemote:(WiiRemote*)wiiRemote;




@end