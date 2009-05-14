//
//  SpaceNavigator.h
//  MOSCOW
//
//  Created by Chandler McWilliams on 5/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import "TdxDevEvents.h"


@interface SpaceNavigator : NSObject {
	/** Holds the on/off state of the LED */
	BOOL ledState;
	
	/** Holds the on/off state of the left button */
	BOOL leftButtonDown;
	
	/** Holds the on/off state of the right button */
	BOOL rightButtonDown;
		
	/** acceleration data */
	float translation[3];	
	float rotation[3];	
}

/**
 Accessors for state
 */
- (BOOL)leftButtonDown;
- (void)setLeftButtonDown:(BOOL)val;

- (BOOL)rightButtonDown;
- (void)setRightButtonDown:(BOOL)val;

- (float *)translation;
- (float *)rotation;

- (NSDictionary *)translationDictionary;
- (NSDictionary *)rotationDictionary;


/**
 Called if Button 1 or 2 is pressed (or released)
 */
- (void)buttonChanged:(int)type isPressed:(BOOL)isPressed;

/**
 Called when one of the axies values changes
 */
- (void) valuesChanged:(int[6])values;

/**
 Normalizes the SN values to 0-1
 */
- (float)normalizeNavigatorValue:(int)value;



@end
