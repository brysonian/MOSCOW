//
//  OSCAddressSpace.h
//  VVOSC
//
//  Created by bagheera on 2/20/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#if IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif
#import "OSCNode.h"




@protocol OSCAddressSpaceDelegateProtocol
	- (void) newNodeCreated:(OSCNode *)n;
@end




#define AddressSpaceUpdateMenus @"AddressSpaceUpdateMenus"




id _mainAddressSpace;




@interface OSCAddressSpace : OSCNode {
	id			delegate;
}

+ (OSCAddressSpace *) mainSpace;
+ (void) refreshMenu;
+ (NSMenu *) makeMenuForNode:(OSCNode *)n withTarget:(id)t action:(SEL)a;

- (void) renameAddress:(NSString *)before to:(NSString *)after;
- (void) renameAddressArray:(NSArray *)before toArray:(NSArray *)after;

- (void) setNode:(OSCNode *)n forAddress:(NSString *)a;
- (void) setNode:(OSCNode *)n forAddressArray:(NSArray *)a;

//	this method is called whenever a new node is added to the address space- subclasses can override this for custom notifications
- (void) newNodeCreated:(OSCNode *)n;

//	unlike a normal node: first finds the destination node, then dispatches the msg
- (void) dispatchMessage:(OSCMessage *)m;

- (void) addDelegate:(id)d forPath:(NSString *)p;
- (void) removeDelegate:(id)d forPath:(NSString *)p;

@property (assign, readwrite) id delegate;


@end
