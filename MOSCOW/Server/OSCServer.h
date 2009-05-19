//
//  OSCServer.h
//  MOSCOW
//
//	Class that encapsulates OSC message sending
//
//  Created by Chandler McWilliams on 5/12/09.
//  Copyright 2009 RepetitionRepetition. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <VVOSC/VVOSC.h>


@interface OSCServer : NSObject {
	OSCManager					*manager;
	OSCInPort					*inPort;
	OSCOutPort					*outPort;

	/** User's port */
	int port;
	
	/** User's host */
	NSString *host;
	
}

- (id)initWithHost:(NSString *)host port:(int)port;
- (void)setPort:(int)aport;
- (void)setHost:(NSString *)ahost;

#pragma mark Navigator Actions
- (void)sendNavigatorTranslationX:(float)x Y:(float)y Z:(float)z;
- (void)sendNavigatorRotationX:(float)x Y:(float)y Z:(float)z;
- (void)sendNavigatorButton:(int)button isPressed:(BOOL)down;

#pragma mark WiiMote Actions
- (void)sendWiiMoteAccelerationX:(float)x Y:(float)y Z:(float)z;
- (void)sendWiiMoteJoyStickX:(float)x Y:(float)y;
- (void)sendWiiMoteButton:(NSString *)type isPressed:(BOOL)down;


@end
