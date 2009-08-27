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
        // TODO: Rethink. Maybe we should do message runWithExecution and message decides what to do next
        // Normal messages re-send to target. Literals create instances. Complex.
        if([message isKindOfClass: [LLiteral class]]) {
            if([message isKindOfClass:[LTextLiteral class]]) {
                target = [runtime makeTextWithString:message.name];
            }
        } else {
            target = [target send:self];
        }
        message = message.nextMessage;
    }
    return target;
}

@end
