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
@interface LExecutable : LObject {}

@end


/** Base class for Methods and Macros. */
@interface LLangExecutable : LExecutable {
    LMessage *code;
}


/** Builds context that keeps locals throughout invocation. */
- (id)invocationContextWithExecution:(LExecution*)execution;

/** Returns code used to build the LLangExecutable. */
- (id)codeWithExecution:(LExecution*)execution;

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


/** Represents methods created in runtime using method(). */
@interface LMethod : LLangExecutable {
    LArguments *arguments;
}

/** Initializes LLangMethod object, parses arguments and stores code to execute when activated. */
- (id)initWithArguments:(NSArray*)theArguments;
@end


#pragma mark Macros

/** Represents macros created in runtime using macro(). */
@interface LMacro : LLangExecutable {}

- (id)initWithCode:(LMessage*)newCode;

@end
