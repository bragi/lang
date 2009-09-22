//
//  LExecution.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-24.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class LMessage;
@class LRuntime;
@class LObject;


/**
 Executes given code, provides means to evaluate arguments and arbitrary code (usable by methods and macros),
 keeps track of execution state. Gives access to current runtime and allows to create objects programatically.
 */
@interface LExecution : NSObject {
    /** Current context of execution */
    LObject *context;
    
    /** Currently executed message */
    LMessage *message;
    
    /** Parent execution context */
    LExecution *parent;

    /** Keeps current runtime */
    LRuntime *runtime;
    
    /** Current invocation target */
    LObject *target;
    
    /** When set to true execution of messages stop and current target is returned. */
    BOOL stopAndReturn;
}

@property (readonly) LObject *context;
@property (readonly) LMessage *message;
@property (readonly) LRuntime *runtime;
@property (readonly) LObject *target;

/**
 Creates new execution with given runtime, used only from within LRuntime instance.
 */
+ (id)buildWithRuntime:(LRuntime*)runtime;

/** Inits with given runtime */
- (id)initWithRuntime:(LRuntime*)runtime;

/** Inits with given parent */
- (id)initWithParent:(LExecution*)parent;

/**
 Runs code in given message returning value from last message in chain.
 */
- (LObject*)runMessage:(LMessage*)message withContext:(LObject*)context;

#pragma mark Evaluating code

/** Evaluates code within caller */
- (LObject*)evaluateWithCurrentContext:(LMessage*)code;

/** Evaluates code within provided context */
- (LObject*)evaluateCode:(LMessage*)code inContext:(LObject*) context;

/** Returns all arguments evaluated in context of caller */
- (NSMutableArray*)evaluatedArguments;
@end

