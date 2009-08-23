//
//  LObject.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LFrame;
@class Runtime;

/**
 Base building block of the Lang runtime. Keeps data about object: cells and ancestors, 
 provides means to execute methods in response to messages.
 
 Ancestor of all Lang datatypes.
 */
@interface LObject : NSObject {
    /** Keeps cells provided by this object */
	NSMutableDictionary* cells;
    /** Keeps object's ancestors */
	NSMutableArray* ancestors;
    /** Reference to runtime in which the object was created */
    Runtime* runtime;
}

/** Keeps the runtime of this object. */
@property (retain) Runtime* runtime;

/** Initializes the object */
- (id) init;

// Internal plumbing

/**
 Adds cell to the object with given name.
 */
- (void) setCell: (LObject*)object withName: (NSString*)name;
/**
 Finds cell with given name in the object.
 */
- (LObject*) cellForName: (NSString *)name;

- (void) addAncestor: (LObject*)ancestor;

// Public interface

/**
 Final part of processing a message, called when self is in activated cell. Non-executable 
 objects simply return self, only executable descendants like Methods perform more complex 
 tasks. 
 
 Returns result of activation - self for non-executable objects, result of computation
 otherwise.
 */
- (LObject*) activate: (LFrame*) frame;

/**
 Creates new instance with self as ancestor
 */
- (LObject*) mimic;

/**
 First part of processing message. When message is called on object:

 object message
 
 then object will receive send: with message in frame. It needs to decide which cell will
 handle the call and then sends activate to this cell.
 */
- (LObject*) send: (LFrame*) frame;
@end
