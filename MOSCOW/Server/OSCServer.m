//
//  OSCServer.m
//  MOSCOW
//
//  Created by Chandler McWilliams on 5/12/09.
//  Copyright 2009 RepetitionRepetition. All rights reserved.
//

#define kNavigatorTranslationAddress @"/sp/1/trans/xyz"
#define kNavigatorRotationAddress @"/sp/1/rot/xyz"
#define kNavigatorButtonAddressFormat @"/sp/1/button/%d"

#define kWiiMoteAccerometerAddress @"/wii/1/accel/xyz"
#define kWiiMoteJoyStickAddress @"/wii/1/nunchuk/pry"

#define kWiiMoteButtonAddressFormat @"/wii/1/button/%@"

#import "OSCServer.h"

@implementation OSCServer

- (id)init
{
	if (self = [super init]) {
		// setup osc server
		manager = [[OSCManager alloc] init];
		[manager setDelegate:self];
	}
    return self;
}

- (id)initWithHost:(NSString *)ahost port:(int)aport
{
	self = [self init];
	if (self) {
		[self setHost:ahost];
		[self setPort:aport];
		outPort = [[manager createNewOutputToAddress:host atPort:port] retain];	
	}
	return self;
}

- (void)dealloc
{
	[manager release], manager = nil;
	[outPort release], outPort = nil;
	[super dealloc];
}

#pragma mark SpaceNavigator methods
- (void)sendNavigatorTranslationX:(float)x Y:(float)y Z:(float)z
{
	OSCMessage *msg = [OSCMessage createWithAddress:kNavigatorTranslationAddress];	
	[msg addFloat:x];
	[msg addFloat:y];
	[msg addFloat:z];
	[outPort sendThisMessage:msg];
}

- (void)sendNavigatorRotationX:(float)x Y:(float)y Z:(float)z
{
	OSCMessage *msg = [OSCMessage createWithAddress:kNavigatorRotationAddress];	
	[msg addFloat:x];
	[msg addFloat:y];
	[msg addFloat:z];
	[outPort sendThisMessage:msg];
}

- (void)sendNavigatorButton:(int)button isPressed:(BOOL)down
{
	OSCMessage *msg = [OSCMessage createWithAddress:[NSString stringWithFormat:kNavigatorButtonAddressFormat, button]];	
	[msg addFloat:(down?1.0:0.0)];
	[outPort sendThisMessage:msg];
}


#pragma mark WiiMote Methods
- (void)sendWiiMoteAccelerationX:(float)x Y:(float)y Z:(float)z
{
	OSCMessage *msg = [OSCMessage createWithAddress:kWiiMoteAccerometerAddress];	
	[msg addFloat:x];
	[msg addFloat:y];
	[msg addFloat:z];
	[outPort sendThisMessage:msg];	
}

- (void)sendWiiMoteJoyStickX:(float)x Y:(float)y
{
	OSCMessage *msg = [OSCMessage createWithAddress:kWiiMoteJoyStickAddress];	
	[msg addFloat:x];
	[msg addFloat:y];
	[outPort sendThisMessage:msg];	
}

- (void)sendWiiMoteButton:(NSString *)type isPressed:(BOOL)down;
{	
	OSCMessage *msg = [OSCMessage createWithAddress:[NSString stringWithFormat:kWiiMoteButtonAddressFormat, type]];	
	[msg addFloat:(down?1.0:0.0)];
	[outPort sendThisMessage:msg];
}


#pragma mark accessors
- (void)setPort:(int)aport
{
	port = aport;
}

- (void)setHost:(NSString *)ahost
{
	[host release];
	[ahost retain];
	host = ahost;
}


@end
