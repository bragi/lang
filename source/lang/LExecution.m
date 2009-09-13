//
//  LExecution.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-24.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LExecution.h"
#import "LMessage.h"
#import "LObject.h"
#import "LRuntime.h"

@implementation LExecution

@synthesize context;
@synthesize message;
@synthesize runtime;
@synthesize target;

+ (id) buildWithRuntime: (LRuntime*)runtime
{
    return [[LExecution alloc] initWithRuntime:runtime];
}

- (id) initWithRuntime: (LRuntime*)nruntime
{
    self = [super init];
    runtime = nruntime;
    return self;
}

- (id) initWithParent:(LExecution*)nparent
{
    self = [super init];
    parent = nparent;
    runtime = parent.runtime;
    return self;
}

- (LObject*) runMessage:(LMessage*)nmessage withContext:(LObject*)ncontext
{
    context = ncontext;
    target = context;
    message = nmessage;
    while (message) {
        // TODO: Rethink. Maybe we should call message's runWithExecution and message decides what to do next
        // Normal messages re-send to target. Literals create instances. Complex...
        NSLog(@"Executing message: %@", message.name);
        // Handle literals
        if([message isKindOfClass: [LLiteral class]]) {
            // For each literal type create proper object and make it a new target
            if([message isKindOfClass:[LTextLiteral class]]) {
                target = [runtime makeTextWithString:message.name];
            } else if([message isKindOfClass:[LNumberLiteral class]]) {
                target = [runtime makeNumberWithString:message.name];
            }
        } else if([message isKindOfClass: [EndMessage class]]) {
            // Handle EndMessage: This messages resets current target back to original context
            target = context;
        } else {
            // End of special cases: send the message to current target, set target to what methods return.
            target = [target send:self];
        }
        message = message.nextMessage;
    }
    return target;
}

- (LObject*) evaluateWithCurrentContext:(LMessage*)code
{
    LExecution* codeExecution = [[LExecution alloc] initWithParent:self];
    return [codeExecution runMessage:code withContext:self.context];
}
@end
