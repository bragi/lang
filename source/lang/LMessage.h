//
//  LMessage.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"

@class LRuntime;
@class LExecution;

@interface LMessage : LObject {
    NSString *name;
    LMessage *nextMessage;
    NSMutableArray *arguments;
    NSInteger line;
    NSInteger column;
}

@property (retain) LMessage *nextMessage;
@property (retain) NSString *name;
@property (retain) NSMutableArray *arguments;
@property (assign) NSInteger line;
@property (assign) NSInteger column;

+ (id)messageWithName:(NSString*)newName;
- (id)initWithName:(NSString*)newName;
- (void)addArgument:(LMessage*)argument;
- (NSString*)stringValue;
- (NSMutableString*)stringValueWithoutNested;

/**
 Returns true if is an assignement message, false otherwise.
 */
- (BOOL)isAssignement;

/**
 Returns true if is an operator message, false otherwise.
 */
- (BOOL)isOperator;

/**
 Gives access to the next message within execution.
 */
- (LObject*)nextWithExecution:(LExecution*)execution;

/**
 Gives access to the arguments within execution.
 */
- (LObject*)argumentsWithExecution:(LExecution*)execution;

/**
 Gives access to the name within execution.
 */
- (LObject*)nameWithExecution:(LExecution*)execution;

@end


@interface EndMessage : LMessage {}
+ (id)build;
- (id)init;
@end


/** Represents operator. */
@interface OperatorMessage : LMessage {}
@end


/** Base class for all literals. */
@interface LLiteral : LMessage {}
@end


/** Text literal. */
@interface LTextLiteral : LLiteral {}
@end


/**Number literal. */
@interface LNumberLiteral : LLiteral {}
@end
