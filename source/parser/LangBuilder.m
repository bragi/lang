//
//  LangBuilder.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-02.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LangBuilder.h"
#import "LMessage.h"

@implementation LangBuilder

@synthesize message;

- (id)initWithRuntime:(LRuntime*)aRuntime
{
    self = [super init];
    runtime = aRuntime;
    messages = [NSMutableArray array];
    return self;
}

- (void)addMessage:(LMessage*)newMessage
{
    [newMessage addAncestor:runtime.theMessage];
    if (message == nil) {
        message = newMessage;
    } else {
        if (argumentStarted) {
            argumentStarted = NO;
            [(LMessage*)[messages lastObject] addArgument:newMessage];
        } else {
            currentMessage.nextMessage = newMessage;
        }
    }
    currentMessage = newMessage;
}

- (void)identifier:(NSString*)name
{
    [self addMessage:[LMessage messageWithName:name]];
}

- (void)argumentsStart
{
    argumentStarted = YES;
    [messages addObject:currentMessage];
}

- (void)argumentsEnd
{
    currentMessage = [messages lastObject];
    [messages removeLastObject];
    argumentStarted = NO;
}

- (void)nextArgument
{
    argumentStarted = YES;
}

- (void)endMessage
{
    [self addMessage:[EndMessage build]];
}

- (void)textLiteral:(NSString*)name
{
    [self addMessage:[LTextLiteral messageWithName:name]];
}

- (void)numberLiteral:(NSString*)name
{
  [self addMessage:[LNumberLiteral messageWithName:name]];
}

@end
