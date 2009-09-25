//
//  LMethod.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-21.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LMessage.h"
#import "LExecution.h"

/** Base class for all executable code. */
@interface LExecutable : LObject {
    LMessage *code;
}

/** Builds context that keeps locals throughout invocation. */
- (id)invocationContextWithExecution:(LExecution*)execution;

@end


#pragma mark Methods

/**
 Represents arguments.
 */
@interface LArguments : NSObject
{
    NSMutableArray *mandatoryArguments;
    NSMutableArray *defaultArguments;
    NSMutableDictionary *defaultArgumentsValues;
}

- (id)initWithMessageArguments:(NSArray *)arguments;

/**
 Parses given argument, checks if it is a mandatory or default argument and updates proper collection.
 */

- (void)parseArgument:(LMessage*)argument;

/**
 Evaluates arguments and puts them in local method context.
 */
- (void)evaluateArgumentsFromExecution:(LExecution*)execution toContext:(LObject*)context;

@end


/** 
 Base class for methods. Evaluates parameters and binds their values
 to names.
 */
@interface LMethod : LExecutable {}
@end


/** Represents methods created in runtime using method(). */
@interface LLangMethod : LExecutable {
    LArguments *arguments;
}

/** Initializes LLangMethod object, parses arguments and stores code to execute when activated. */
- (id)initWithArguments:(NSArray*)theArguments;
@end


#pragma mark Macros

/** Represents macros created in runtime using macro(). */
@interface LLangMacro : LExecutable {}

- (id)initWithCode:(LMessage*)newCode;

@end
