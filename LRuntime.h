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
#import "LText.h"

/**
 Runtime of the Lang. Initializes all basic objects, provides access to them,
 executes code and keeps runtime state.
 */
@interface LRuntime : NSObject {
    /**
     Keeps reference to the topmost execution context (typically the only Kernel 
     instance).
     */
	LObject* theBaseContext;
    
    // Base objects
    
    /** Object. */
    LObject* theObject;
    /** True */
    LObject* theTrue;
    /** False */
    LObject* theFalse;
    /** Nil */
    LObject* theNil;
    /** Text */
    LText* theText;
}

@property (retain) LObject* theBaseContext;

@property (retain) LObject* theObject;
@property (retain) LObject* theTrue;
@property (retain) LObject* theFalse;
@property (retain) LObject* theNil;
@property (retain) LText* theText;

/**
 Initializes Runtime, creates all necessary runtime objects.
 */
- (id) init;

/**
 Creates new instance of Text
 */
- (LText*) makeTextWithString:(NSString*)string;

@end
