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
#import "LNumber.h"
#import "LList.h"
#import "LCall.h"
#import "LMethod.h"
#import "LExecution.h"
#import "LPair.h"

/**
 Runtime of the Lang. Initializes all basic objects, provides access to them,
 executes code and keeps runtime state.
 */
@interface LRuntime : NSObject {
    /**
     Keeps reference to the topmost execution context (typically the only Kernel 
     instance).
     */
    LObject *theBaseContext;
    
    // Base objects
    
#pragma mark the objects
    /** Object. */
    LObject *theObject;

    /** True */
    LObject *theTrue;
    
    /** False */
    LObject *theFalse;
    
    /** Nil */
    LObject *theNil;
    
    /** Text */
    LText *theText;
    
    /** Number */
    LNumber *theNumber;
    
    /** List */
    LList *theList;

    /** Executable */
    LObject *theExecutable;

    /** LangExecutable */
    LObject *theLangExecutable;

    /** Method */
    LObject *theMethod;

    /** Macro */
    LObject *theMacro;

    /** Message */
    LMessage *theMessage;

    /** Call */
    LObject *theCall;

    /** Pair */
    LPair *thePair;
}

@property (retain) LObject *theBaseContext;
@property (retain) LObject *theObject;
@property (retain) LObject *theTrue;
@property (retain) LObject *theFalse;
@property (retain) LObject *theNil;
@property (retain) LText *theText;
@property (retain) LNumber *theNumber;
@property (retain) LList *theList;
@property (retain) LObject *theExecutable;
@property (retain) LObject *theLangExecutable;
@property (retain) LObject *theMethod;
@property (retain) LObject *theMacro;
@property (retain) LMessage *theMessage;
@property (retain) LObject *theCall;
@property (retain) LPair *thePair;

/**
 Initializes Runtime, creates all necessary runtime objects.
 */
- (id)init;

/**
 Reads bootstrap code and executes it.
 */
- (LRuntime*)bootstrap;

/**
 Creates new instance of Text
 */
- (LText*)makeTextWithString:(NSString*)string;

/**
 Creates new instance of Number
 */
- (LNumber*)makeNumberWithString:(NSString*)string;

/**
 Creates new instance of Number
 */
- (LNumber*)makeNumberWithInteger:(NSInteger)value;

/**
 Creates new instance of List
 */
- (LList*)makeListWithEntries:(NSMutableArray*)entries;

/**
 Adds proper ancestor to native method and returns it
 */
- (LObject*)withExecutableAncestor:(LObject*)nativeMethod;

/**
 Creates new instance of Call
 */
- (LCall*)makeCallWithExecution:(LExecution*)execution;

/**
 Creates new instance of Pair
 */
- (LPair*)makePairWithKey:(LObject*)key andValue:(LObject*)value;
@end
