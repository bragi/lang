//
//  LRuntime.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LMessage.h"

/**
 Runtime of the Lang. Initializes all basic objects, provides access to them,
 executes code and keeps runtime state.
 */
@interface LRuntime : NSObject {
    /**
     Pointer to current invocation target. It starts at topContext and keeps what
     last executed method returned. StopMethod is the only method that returns 
     topContext allowing to end message chain and start a new one.
     */
	LObject* currentTarget;
    
    /**
     Keeps reference to the topmost execution context (typically the only Kernel 
     instance).
     */
	LObject* topContext;
    
    // Base objects
    
    /** Object. */
    LObject* theObject;
    /** True */
    LObject* theTrue;
     
}

@property (retain) LObject* currentTarget;
@property (retain) LObject* topContext;

@property (retain) LObject* theObject;
@property (retain) LObject* theTrue;

/**
 Initializes Runtime, creates all necessary runtime objects.
 */
- (id) init;

/**
 Runs message chain, should only be called once. Executes all messages in chain.
 */
- (void) run:(LMessage*) message;

@end
