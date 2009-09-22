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

    mandatoryArguments = [NSMutableArray array];
    defaultArguments = [NSMutableArray array];
    defaultArgumentsValues = [NSMutableDictionary dictionary];

    for(LMessage *argument in arguments) {
        [self parseArgument:argument];
    }
    return self;
}

- (void)parseArgument:(LMessage *)argument
{
    NSString *name = argument.name;
    if (argument.nextMessage == nil) {
        // Looks like we have a mandatory argument, eg:
        // method(mandatoryArgument, ...)
        [mandatoryArguments addObject:name];
    } else {
        // Looks like default argument, eg:
        // method(defaultArgument false or maybe true, ...)
        [defaultArguments addObject:name];
        [defaultArgumentsValues setObject:argument.nextMessage forKey:name];
    }
}

- (void)evaluateArgumentsFromExecution:(LExecution*)execution toContext:(LObject*)context
{
    // TODO: add argument checks, fix return evaluation
    NSEnumerator *mae = [mandatoryArguments objectEnumerator];
    NSEnumerator *ae = [execution.message.arguments objectEnumerator];
    NSEnumerator *dae = [defaultArguments objectEnumerator];
    NSString *name;
    LObject *local;
    LMessage *argumentCode;
    
    // Iterate over mandatory arguments
    while (name = (NSString*)[mae nextObject]) {
        // Get code for argument
        argumentCode = (LMessage*)[ae nextObject];
        // Evaluate code in caller context
        local = [execution evaluateWithCurrentContext:argumentCode];
        // Store value in locals
        [context setCell:local withName:name];
    }
    
    // Iterate over arguments with default values
    while (name = (NSString*)[dae nextObject]) {
        // Check if code for the argument was provided
        if (argumentCode = (LMessage*)[ae nextObject]) {
            // If so then evaluate it in caller context
            local = [execution evaluateWithCurrentContext:argumentCode];
        } else {
            // Otherwise use code provided when method was defined
            argumentCode = (LMessage*)[defaultArgumentsValues objectForKey:name];
            // And evaluate it in calee context
            local = [execution evaluateCode:argumentCode inContext:execution.target];
        }
        // Store value in locals
        [context setCell:local withName:name];
    }
}

@end


@implementation LLangMethod

- (id)initWithArguments:(NSArray*)theArguments
{
    self = [super init];
    // TODO Add range check, documentation
    NSArray *argumentNames;
    
    if([theArguments count] > 1) {
        argumentNames = [theArguments subarrayWithRange:NSMakeRange(0, [theArguments count] -1)];
    } else {
        argumentNames = [NSArray array];
    }
    arguments = [[LArguments alloc] initWithMessageArguments:argumentNames];
    
    code = [theArguments lastObject];
    return self;
}

- (LObject*)activate:(LExecution*)execution
{
    LObject *result;
    @try {
        LObject *methodContext = [self methodContextWithExecution:execution];
        result = [execution evaluateCode:code inContext:methodContext];
    }
    @catch (LObject *e) {
        result = e;
    }
    return result;
}

- (id)methodContextWithExecution:(LExecution*)execution
{
    /** 
     Execution context forwards all cell access to execution target.
     We use normal inheritance model to achieve that. Simple.
     */
    LObject *context = [execution.target newWithExecution:execution];
    /**
     Evaluate arguments form message given in execution and put them as locals in 
     method execution context.
     */
    [arguments evaluateArgumentsFromExecution:execution toContext:context];
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
