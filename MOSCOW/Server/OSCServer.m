//
//  OSCServer.m
//  MOSCOW
//
//  Created by Chandler McWilliams on 5/12/09.
//  Copyright 2009 RepetitionRepetition. All rights reserved.
//

#define kNavigatorTranslationAddress @"/sp/1/trans/xyz"
#define kNavigatorRotationAddress @"/sp/1/rot/xyz"
#define kNavigatorLeftButtonAddress @"/sp/1/button/1"
#define kNavigatorRightButtonAddress @"/sp/1/button/2"


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

- (void)sendNavigatorLeftButtonChanged:(BOOL)down
{
	OSCMessage *msg = [OSCMessage createWithAddress:kNavigatorLeftButtonAddress];	
	[msg addFloat:(down?1.0:0.0)];
	[outPort sendThisMessage:msg];
}

- (void)sendNavigatorRightButtonChanged:(BOOL)down
{
	OSCMessage *msg = [OSCMessage createWithAddress:kNavigatorRightButtonAddress];	
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
