//
//  LCall.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-10-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LExecution.h"

/**
 Represents call made to macro. Provides methods to access call arguments, sent message.
 */
@interface LCall : LObject {
    LExecution *callExecution;
}

+ (LCall*)callWithAncestor:(LObject*)theCall execution:(LExecution*)execution;

- (id)initWithExecution:(LExecution*)execution;

/**
 Returns arguments.
 */
- (LObject*)argumentsWithExecution:(LExecution*)execution;

/**
 Returns evaluated argument of call with position given as argument.
 */
- (LObject*)evaluatedArgumentWithExecution:(LExecution*)execution;

/**
 Returns message sent.
 */
- (LObject*)messageWithExecution:(LExecution*)execution;

@end
