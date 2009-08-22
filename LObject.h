//
//  LObject.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LFrame;

/*
 Base building block of the Lang runtime. Keeps data about object: cells and ancestors, provides means to execute methods in response to messages.
 
 Ancestor of all Lang datatypes.
 */
@interface LObject : NSObject {
	NSMutableDictionary* cells;
	NSMutableArray* ancestors;
}

- (id) init;

- (void) setCell: (LObject*)object withName: (NSString*)name;
- (LObject*) cellForName: (NSString *)name;

- (void) addAncestor: (LObject*)ancestor;

- (LObject*) activate: (LFrame*) frame;
- (LObject*) send: (LFrame*) frame;
@end
