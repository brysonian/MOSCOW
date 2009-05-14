//
//  SpaceNavigator.m
//  MOSCOW
//
//  Created by Chandler McWilliams on 5/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SpaceNavigator.h"

// define the event codes
#define ENABLE_LED 2
#define DISABLE_LED 3

#define kSNLeftButton 1
#define kSNRightButton 2

#define kLEDOn 0x00010001
#define kLEDOff 0x00010000

#define kValuesChangedNotificationName @"SpaceNavigatorValuesChanged";

NSString const *valuesChangedNotificationName = @"SpaceNavigatorValuesChanged";
NSString const *buttonChangedNotificationFormat = @"SpaceNavigator%@ButtonChanged";
NSString const *genericButtonChangedNotificationName = @"SpaceNavigatorButtonChanged";

int pAxis_values[6];
SpaceNavigator *pNavigator;



// Device configs=========================

#ifndef __TdxDeviceEvents_h__
#define __TdxDeviceEvents_h__

//#import <Carbon/Carbon.h>
//#import <MacTypes.h>
#import "3DconnexionClient/ConnexionClientAPI.h"

// =============================================================================
#pragma mark 3Dconnexion events information

/* 3Dconnexion event class */
enum 
{
	kEventClassTdxDevice = 'tdxE'	
};

/* 3Dconnexion event kinds */
typedef enum 
	{
		kTdxDeviceEventButton = 1,
		kTdxDeviceEventMotion,
		kTdxDeviceEventException,
		kTdxDeviceEventZero
	} TdxDeviceEvent;

/* 3Dconnexion event parameters */
enum {
	kEventParamTX             = 'tpnx', /* typeSInt16 */
	kEventParamTY             = 'tpny', /* typeSInt16 */
	kEventParamTZ             = 'tpnz', /* typeSInt16 */
	kEventParamRX             = 'trtx', /* typeSInt16 */
	kEventParamRY             = 'trty', /* typeSInt16 */
	kEventParamRZ             = 'trtz', /* typeSInt16 */
	kEventParamButtonID       = 'tbtn', /* typeSInt16 */
	kEventParamButtonDown     = 'tbts', /* typeSInt16 */
	kEventParamTime           = 'ttim'  /* typeUInt64 */
};


// =============================================================================
#pragma mark NuLOOQ button, mask, LED enum/constants

/* NuLOOQ button constants */
enum 
{
	kButtonNone = 0,
	kButtonOne = (1L << 2),
	kButtonTwo = (1L << 4),
	kButtonThree = (1L << 3),
	kButtonValue = (1L << 0),
	kButtonPressure = (1L << 1)	
};

/* NuLOOQ button mask constants */
enum 
{
	kButtonMaskNone = 0,
	kButtonMaskOne = (1L << 18),
	kButtonMaskTwo = (1L << 20),
	kButtonMaskThree = (1L << 19),
	kButtonMaskValue = (1L << 16),
	kButtonMaskPressure = (1L << 17)	
};

/* convenience constants for certain LED collections */
enum 
{
    kLEDValueButtonOn = kButtonValue | kButtonMaskValue,
    kLEDValueButtonOff = kButtonNone | kButtonMaskValue,
	
    kLEDUserButtons = kButtonOne | kButtonTwo | kButtonThree,
    kLEDValueAndUserButtons = kLEDUserButtons | kButtonValue,
    kLEDPressureAndUserButtons = kLEDUserButtons | kButtonPressure
};


/* NuLOOQ buttons constants synonyms. */
typedef enum 
	{
		kNuLOOQNorthButtonValue         = 1,
		kNuLOOQEastButtonValue          = 4,
		kNuLOOQCenterButtonValue        = 16,
		kNuLOOQWestButtonValue          = 8,
		kNuLOOQSouthButtonValue         = 2,
		kNuLOOQStaticValueButtonValue   = 1,
		kNuLOOQTapButtonValue           = 16
	} NuLOOQButtonValue;

// =============================================================================
#pragma mark Façade to the NuLOOQ framework APIs

namespace tdx 
{
	/** Initialization routine for starting a data link to the 3Dconnexion driver 
	 *	@param appID signature of the parent application calling this function
	 */
	bool InitTdxDevice (UInt32 appID, bool showOnlyMyClientEvents, 
                        UInt16 mode=kConnexionClientModePlugin, 
                        UInt32 mask=kConnexionMaskAll);
	
	/** Cleanup rountine to close down the data link with the NuLOOQ driver */
	void TerminateTdxDevice();
	
}	// end of namespace tdx



#endif	// __TdxDeviceEvents_h__





@implementation SpaceNavigator

- (id)init
{
	if (self = [super init]) {
		if (InstallConnexionHandlers != NULL) {
			BOOL ok = tdx::InitTdxDevice(kConnexionClientWildcard, true, kConnexionClientModeTakeOver, kConnexionMaskAll);
			printf("SN device init OK? %d\n", ok);
		}
		pNavigator = self;
	}	
    return self;
}


# pragma mark SpaceNavigator Delegates
- (void) valuesChanged:(int[6])values
{	
	translation[0] = [self normalizeNavigatorValue:values[0]];
	translation[1] = [self normalizeNavigatorValue:values[1]];
	translation[2] = [self normalizeNavigatorValue:values[2]];

	rotation[0] = [self normalizeNavigatorValue:values[3]];
	rotation[1] = [self normalizeNavigatorValue:values[4]];
	rotation[2] = [self normalizeNavigatorValue:values[5]];

	[[NSNotificationCenter defaultCenter] postNotificationName:valuesChangedNotificationName
														object:self];

}

- (void)buttonChanged:(int)button isPressed:(BOOL)isPressed
{
	NSString *notificationName = [NSString stringWithFormat:buttonChangedNotificationFormat, 
								  ((button == kSNLeftButton)?@"Left":@"Right")];

	[[NSNotificationCenter defaultCenter]
	 postNotificationName:notificationName object:self];

}

#pragma mark accessors
- (BOOL)leftButtonDown { return leftButtonDown; }
- (void)setLeftButtonDown:(BOOL)val { leftButtonDown = val; }
- (BOOL)rightButtonDown { return rightButtonDown; }
- (void)setRightButtonDown:(BOOL)val { rightButtonDown = val; }

- (float *)translation { return translation; }
- (float *)rotation { return rotation; }


- (NSDictionary *)translationDictionary
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithFloat:translation[0]], @"x",
			[NSNumber numberWithFloat:translation[1]], @"y",
			[NSNumber numberWithFloat:translation[2]], @"z",
			nil];
}	

- (NSDictionary *)rotationDictionary
{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[NSNumber numberWithFloat:rotation[0]], @"x",
			[NSNumber numberWithFloat:rotation[1]], @"y",
			[NSNumber numberWithFloat:rotation[2]], @"z",
			nil];
}	



# pragma mark utils
- (float)normalizeNavigatorValue:(int)value
{
	return (value + 255) / 512.0;
}


#pragma mark SN Cpp Code
namespace tdx 
{
	
	// =============================================================================
#pragma mark Data structures
	
	typedef struct 
	{
		UInt16 				clientID; // ID assigned by the driver to this connection. 
		EventQueueRef		mainEventQueue;
		
		/* this flag determines whether only events meant for the registered client
		 are processed or if all events from the device to any client will be sent
		 to this registered client */
		bool				showClientEventsOnly;
	} TdxDeviceEventState, *TdxDeviceEventStatePtr;
	
	typedef struct 
	{
		UInt32	appID;
		UInt16	mode;
		UInt32  mask;
	} TdxDeviceInitData, *TdxDeviceInitDataPtr;
	
	// =============================================================================
#pragma mark Globals
	
	TdxDeviceEventState	gDeviceState;
	
	// =============================================================================
#pragma mark Function prototypes
	
	static OSStatus tdxThread (void* param);
	static void messageHandlerProc (io_connect_t connection, natural_t messageType, 
									void *messageArgument);
	
	// =============================================================================
#pragma mark -
#pragma mark Functions definitions
	
	/** Initialization routine for starting a data link to the NuLOOQ driver 
	 *	@param appID signature of the parent application calling this function
	 */
	bool InitTdxDevice (UInt32 appID, bool showOnlyMyClientEvents, UInt16 mode, UInt32 mask)
	{
		MPTaskID                threadID;
		TdxDeviceInitDataPtr    initData = new TdxDeviceInitData;
		
		if (initData == NULL)
			return false;
		
		/* store the initialization params */
		initData->appID = appID;
		initData->mask = mask;
		initData->mode = mode;
		
		gDeviceState.showClientEventsOnly = showOnlyMyClientEvents;
		
		/* must save the main event queue while we're running within the main thread.
		 * GetMainEventQueue() is not thread-safe and will cause big problems if 
		 * called from the spawned thread
		 */
		gDeviceState.mainEventQueue = GetMainEventQueue();
		return (MPCreateTask(&tdxThread, initData, 512000, NULL, NULL, NULL, 0, &threadID) == noErr);
	}
	
	/** Cleanup rountine to close down the data link with the NuLOOQ driver */
	void TerminateTdxDevice ()
	{
		UnregisterConnexionClient(gDeviceState.clientID);
		CleanupConnexionHandlers();
	}
	
	
	// =============================================================================
#pragma mark -
#pragma mark Local functions
	
	static OSStatus tdxThread (void* param)
	{
		OSStatus 	err = noErr;
		TdxDeviceInitDataPtr 	initData = (TdxDeviceInitDataPtr)param;
		
		if (initData == NULL)
			return 1;
		
		err = InstallConnexionHandlers(messageHandlerProc, 0L, 0L);
		if (err) 
		{
			delete initData;	// we're responsible for releasing this 
			return 2;		
		}
		
		gDeviceState.clientID = RegisterConnexionClient(initData->appID, 0, 
														initData->mode, initData->mask);
		delete initData;	// we're responsible for releasing this                                                 
		
		if (gDeviceState.clientID == 0)
			return 3;		
		
		printf("tdxInit OK.  clientid=%d\n", gDeviceState.clientID);
		RunCurrentEventLoop(kEventDurationForever);
		
		return err;
	}
	
	
	static void messageHandlerProc(io_connect_t connection, natural_t messageType, 
								   void *messageArgument)
	{
		
		NSAutoreleasePool *thePool = [[NSAutoreleasePool alloc] init];
		ConnexionDeviceStatePtr DeviceMsg;
		
		DeviceMsg = (ConnexionDeviceStatePtr)messageArgument;
		
		switch(messageType)
		{
			case kConnexionMsgDeviceState:
				switch (DeviceMsg->command) {
					case kConnexionCmdHandleAxis:
						for(int i = 0; i < 6; i++) {
							pAxis_values[i] = DeviceMsg->axis[i];
						}
						
						[pNavigator valuesChanged:pAxis_values];
						break;
						
					case kConnexionCmdHandleButtons:
						// determine which button changed
						if (DeviceMsg->buttons & kSNLeftButton) {
							if (![pNavigator leftButtonDown]) {
								[pNavigator setLeftButtonDown:YES];
								[pNavigator buttonChanged:kSNLeftButton isPressed:YES];
							}
						} else {
							if ([pNavigator leftButtonDown]) {
								[pNavigator setLeftButtonDown:NO];
								[pNavigator buttonChanged:kSNLeftButton isPressed:NO];
							}
						}
						
						if (DeviceMsg->buttons & kSNRightButton) {
							if (![pNavigator rightButtonDown]) {
								[pNavigator setRightButtonDown:YES];
								[pNavigator buttonChanged:kSNRightButton isPressed:YES];
							}
						} else {
							if ([pNavigator rightButtonDown]) {
								[pNavigator setRightButtonDown:NO];
								[pNavigator buttonChanged:kSNRightButton isPressed:NO];
							}
						}
						
						break;						
				}
				break;
				
			default:
				// other messageTypes can happen and should be ignored
				break;
		}
		[thePool release];
		
	}
	
	
}	// end of namespace tdx

@end
