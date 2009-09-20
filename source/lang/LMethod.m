//
//  LMethod.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-21.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LMethod.h"
#import "LExecution.h"
#import "CommonMethods.h"

@implementation LExecutable
@end


#pragma mark Methods

@implementation LMethod
@end


@implementation LArguments

- (id)initWithMessageArguments:(NSArray *)arguments
{
    self = [super init];

    mandatoryArguments = [NSMutableSet set];
    defaultArguments = [NSMutableDictionary dictionary];

    for(LMessage *argument in arguments) {
        [self parseArgument:argument];
    }
}

- (void)parseArgument:(LMessage *)argument
{
    NSString *name = argument.name;
    if (argument.nextMessage == nil) {
        [mandatoryArguments addObject:name];
    } else {
        [defaultArguments setObject:argument.nextMessage forKey:name];
    }

}

@end


@implementation LLangMethod

- (id)initWithArguments:(NSArray*)theArguments
{
    self = [super init];
    // TODO Add range check, documentation
    arguments = [[LArguments alloc] initWithMessageArguments:[theArguments subarrayWithRange:NSMakeRange(0, [theArguments count] -1)]];
    code = [theArguments lastObject];
    return self;
}

- (LObject*)activate:(LExecution*)execution
{
    return [execution evaluateCode:code inContext:[self methodContextWithExecution:execution]];
}

- (id)methodContextWithExecution:(LExecution*)execution
{
    /** 
     Execution context forwards all cell access to execution target.
     We use normal inheritance model to achieve that. Simple.
     */
    LObject *context = [execution.target newWithExecution:execution];
    /**
     Self in execution context must point to execution target, not the
     context itself. We need to redefine self then.
     */
    [context setCell:execution.target withName:@"self"];
    /**
     Allow to return value from method body.
     */
    // TODO: handle returns from method arguments.
    [context setCell:[[ReturnMethod alloc] init] withName:@"return"];
    return context;
}
@end


#pragma mark Macros

@implementation LLangMacro

- (id)initWithCode:(LMessage*)newCode
{
    self = [super init];
    code = newCode;
    return self;
}

- (LObject*)activate:(LExecution*)execution
{
    return [execution evaluateWithCurrentContext:code];
}

@end
