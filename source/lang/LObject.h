//
//  LObject.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LExecution;

/**
 Base building block of the Lang runtime. Keeps data about object: cells and ancestors, 
 provides means to execute methods in response to messages.
 
 Ancestor of all Lang datatypes.
 */
@interface LObject : NSObject {
    /** Keeps cells provided by this object */
    NSMutableDictionary *cells;
    /** Keeps object's ancestors */
    NSMutableArray *ancestors;
}

/**
 Factory method to build new instances, should be used only during LRuntime initialization.
 */
+ (id)build;

/**
 Builds object with given ancestor.
 */
+ (id)objectWithAncestor:(LObject*)ancestor;

/** Initializes the object */
- (id)init;

// Internal plumbing

/**
 Adds cell to the object with given name.
 */
- (void)setCell:(LObject*)object withName:(NSString*)name;

/**
 Finds cell with given name in the object.
 */
- (LObject*)cellForName:(NSString*)name;

/**
 Adds given object as ancestor. Low level method used only when initializing singletons or 
 from within method calls.
 */
- (void)addAncestor:(LObject*)ancestor;

#pragma mark Public interface

/**
 Final part of processing a message, called when self is in activated cell. Non-executable 
 objects simply return self, only executable descendants like Methods perform more complex 
 tasks. 
 
 Returns result of activation - self for non-executable objects, result of computation
 otherwise.
 */
- (LObject*)activate:(LExecution*)execution;

/**
 First part of processing message. When message is called on object:

 object message
 
 then object will receive send: with message in execution. It needs to decide which cell will
 handle the call and then sends 'activate' to this cell.
 */
- (LObject*)send:(LExecution*)execution;

#pragma mark Lang methods - called by method invocations.

/**
 Assigns cell. First argument is a name, second is value. Name is not evaluated, value is.
 =(name, cell value)
 */
- (LObject*)assignmentWithExecution:(LExecution*)execution;

/**
 Creates a new object with this object as ancestor. Used in running programs.
 */
- (LObject*)newWithExecution:(LExecution*)execution;

/**
 Returns Text representation of this object.
 */
- (LObject*)toTextWithExecution:(LExecution*)execution;

/**
 Returns cell with name given in first argument.
 */
- (LObject*)cellWithExecution:(LExecution*)execution;

/**
 Returns true if self is equal to another object, false otherwise.
 */
- (LObject*)equalsToWithExecution:(LExecution*)execution;

@end
