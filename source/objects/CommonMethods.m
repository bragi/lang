//
//  CommonMethods.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-05.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <objc/message.h>
#import "CommonMethods.h"
#import "LExecution.h"
#import "LMessage.h"
#import "LObject.h"
#import "LMethod.h"
#import "LRuntime.h"
#import "LList.h"


@implementation ESelf

- (LObject*)activate:(LExecution*)execution
{
    return execution.target;
}

@end


@implementation EForward

- (id)initWithName:(NSString*)newName
{
    self = [super init];
    name = sel_registerName([[newName stringByAppendingString:@"WithExecution:"] UTF8String]);
    return self;
}

- (LObject*)activate:(LExecution*)execution
{
    return (LObject*)objc_msgSend(execution.target, name, execution);
}

@end


@implementation ECreateMethod

- (LObject*)activate:(LExecution*)execution
{
    LObject *result = [[LMethod alloc] initWithArguments:[execution.message arguments]];
    [result addAncestor:execution.runtime.theMethod];
    return result;
}

@end


@implementation ECreateMacro

- (LObject*)activate:(LExecution*)execution
{
    // Create and return new instance of LLangMacro
    NSArray *arguments = [execution.message arguments];
    LMessage *macroCode = (LMessage*)[arguments lastObject];
    LObject *result = [[LMacro alloc] initWithCode:macroCode];
    [result addAncestor:execution.runtime.theMacro];
    return result;
}

@end


@implementation ECreateList

- (LObject*)activate:(LExecution*)execution
{
    // Create and return new instance of LList
    return [execution.runtime makeListWithEntries:[execution evaluatedArguments]];
}

@end


@implementation EEvaluateFirstArgument

- (LObject*)activate:(LExecution*)execution
{
    NSArray *arguments = [execution.message arguments];
    LMessage *methodCode = (LMessage*)[arguments lastObject];
    return [execution evaluateWithCurrentContext:methodCode];
}

@end


@implementation EReturn

- (LObject*)activate:(LExecution*)execution
{
    @throw [super activate:execution];
}

@end
