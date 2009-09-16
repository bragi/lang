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

- (id)init
{
    self = [super init];
    messages = [NSMutableArray array];
    return self;
}

- (void)addMessage:(LMessage*)newMessage
{
    NSLog(@"Builder adding message: %@", newMessage);
    if (message == nil) {
        message = newMessage;
    } else {
        if (argumentStarted) {
            NSLog(@"Builder adding argument");
            argumentStarted = NO;
            [(LMessage*)[messages lastObject] addArgument:newMessage];
        } else {
            NSLog(@"Builder setting next message");
            currentMessage.nextMessage = newMessage;
        }
    }
    currentMessage = newMessage;
}

- (void)identifier:(NSString*)name
{
    NSLog(@"Builder identifier: %@", name);
    [self addMessage:[LMessage buildWithName:name]];
}

- (void)argumentsStart
{
    NSLog(@"Builder argumentsStart");
    argumentStarted = YES;
    [messages addObject:currentMessage];
}

- (void)argumentsEnd
{
    NSLog(@"Builder argumentsEnd");
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
    [self addMessage:[LTextLiteral buildWithName:name]];
}

- (void)numberLiteral:(NSString*)name
{
  [self addMessage:[LNumberLiteral buildWithName:name]];
}

@end
