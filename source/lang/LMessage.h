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
	LMessage *previousMessage;
	NSMutableArray *arguments;
    NSUInteger line;
    NSUInteger column;
}

+ (id)messageWithName:(NSString*)newName;
- (id)initWithName:(NSString*)newName;

@property LMessage *nextMessage;
@property LMessage *previousMessage;
@property NSString *name;
@property NSMutableArray *arguments;
@property NSUInteger line;
@property NSUInteger column;

- (void)addArgument:(LMessage*)argument;
- (NSString*)stringValue;
- (NSMutableString*)stringValueWithoutNested;
- (BOOL)isTerminator;

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
@end


/**Base class for all literals. */
@interface LLiteral : LMessage {}
@end


/**Text literal. */
@interface LTextLiteral : LLiteral {}
@end


/**Number literal. */
@interface LNumberLiteral : LLiteral {}
@end
