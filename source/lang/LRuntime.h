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
}

@property LObject *theBaseContext;
@property LObject *theObject;
@property LObject *theTrue;
@property LObject *theFalse;
@property LObject *theNil;
@property LText *theText;
@property LNumber *theNumber;
@property LList *theList;

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
@end
