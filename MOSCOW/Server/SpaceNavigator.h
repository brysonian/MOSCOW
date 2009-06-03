//
//  SpaceNavigator.h
//  MOSCOW
//
//  Created by Chandler McWilliams on 5/14/09.
//  Copyright 2009 RepetitionRepetition. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#import "TdxDevEvents.h"


typedef UInt16 SpaceNavigatorButtonType;
enum {
	SpaceNavigatorRightButton,
	SpaceNavigatorLeftButton
};


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
	
	id delegate;
	
	/** find out what our delegate wants */
	BOOL delegateWantsValues;
	BOOL delegateWantsButtons;

}

@property (nonatomic, retain) id delegate;
@property (assign) BOOL leftButtonDown;
@property (assign) BOOL rightButtonDown;

@property (readonly) float translationX;
@property (readonly) float translationY;
@property (readonly) float translationZ;

@property (readonly) float rotationX;
@property (readonly) float rotationY;
@property (readonly) float rotationZ;

+ (BOOL)isAvailable;

/**
 Accessors for state
 */
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
- (void)valuesChanged:(int[6])values;

/**
 Normalizes the SN values to 0-1
 */
- (float)normalizeNavigatorValue:(int)value;



@end

@interface NSObject( SpaceNavigatorDelegate )

- (void)spaceNavigatorButtonChanged:(SpaceNavigatorButtonType)type isPressed:(BOOL)isPressed;
- (void)spaceNavigatorValuesChanged:(float *)translation rotation:(float *)rotation;

@end
