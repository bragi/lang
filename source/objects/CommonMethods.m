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


@implementation SelfMethod

- (LObject*) activate: (LExecution*)execution
{
	return execution.target;
}

@end


@implementation ForwardingMethod

- (id) initWithName:(NSString*)newName
{
    self = [super init];
    name = sel_registerName([[newName stringByAppendingString:@"WithExecution:"] UTF8String]);
    return self;
}

- (LObject*) activate: (LExecution*)execution
{
    return (LObject*)objc_msgSend(execution.target, name, execution);
}

@end


@implementation MethodMethod

- (LObject*)activate:(LExecution*)execution
{
    // Create and return new instance of LLangMethod
    NSArray* arguments = [execution.message arguments];
    LMessage* code = (LMessage*)[arguments lastObject];
    return [[LLangMethod alloc] initWithCode:code];
}

@end


@implementation MacroMethod

- (LObject*)activate:(LExecution*)execution
{
    // Create and return new instance of LLangMacro
    NSArray* arguments = [execution.message arguments];
    LMessage* code = (LMessage*)[arguments lastObject];
    return [[LLangMacro alloc] initWithCode:code];
}

@end


@implementation ListMethod

- (LObject*)activate:(LExecution*)execution
{
    // Create and return new instance of LList
    return [execution.runtime makeListWithEntries:[execution evaluatedArguments]];
}

@end


@implementation EvaluateFirstArgumentMethod

- (LObject*) activate: (LExecution*)execution
{
    NSArray* arguments = [execution.message arguments];
    LMessage* code = (LMessage*)[arguments lastObject];
    return [execution evaluateWithCurrentContext:code];
}

@end
