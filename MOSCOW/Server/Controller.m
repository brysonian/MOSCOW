#import "Controller.h"
#import "SpaceNavigator.h"

// preference keys
NSString * const kPort			= @"port";

int pAxis_values[6];
Controller *pGlobalControl;


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
		
	 }

    return self;
}

// register for SN notifications
- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(navigatorValuesChanged:)
												 name:@"SpaceNavigatorValuesChanged" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(navigatorLeftButtonChanged:)
												 name:@"SpaceNavigatorLeftButtonChanged" object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(navigatorRightButtonChanged:)
												 name:@"SpaceNavigatorRightButtonChanged" object:nil];
	
}


#pragma mark SpaceNavigator Actions
// when the sn knob changes
- (void)navigatorValuesChanged:(NSNotification *)notification
{	
	float *trans = [navigator translation];
	[oscserver sendNavigatorTranslationX:trans[0]
									   Y:trans[1]
									   Z:trans[2]];

	float *rotation = [navigator rotation];
	[oscserver sendNavigatorRotationX:rotation[0]
									Y:rotation[1]
									Z:rotation[2]];
	
}

// when the SN buttons change
- (void)navigatorRightButtonChanged:(NSNotification *)notification
{
	[oscserver sendNavigatorRightButtonChanged:[(SpaceNavigator *)[notification object] rightButtonDown]];
}

- (void)navigatorLeftButtonChanged:(NSNotification *)notification
{
	[oscserver sendNavigatorLeftButtonChanged:[(SpaceNavigator *)[notification object] leftButtonDown]];
}





// sweet release
- (void)dealloc
{
	[oscserver release], oscserver = nil;
	[navigator release], navigator = nil;
	[super dealloc];
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
	return NSTerminateNow;
}






@end
