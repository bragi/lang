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


@implementation TrueMethod

- (LObject*) activate: (LExecution*)execution
{
	return execution.runtime.theTrue;
}

@end


@implementation FalseMethod

- (LObject*) activate: (LExecution*)execution
{
	return execution.runtime.theFalse;
}

@end


@implementation NilMethod

- (LObject*) activate: (LExecution*)execution
{
	return execution.runtime.theNil;
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


@implementation ListMethod

- (LObject*)activate:(LExecution*)execution
{
    // Create and return new instance of LList
    return [[LList alloc] initWithEntries:[execution evaluatedArguments]];
}

@end
