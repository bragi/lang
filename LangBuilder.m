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
- (id)init
{
    self = [super init];
    messages = [NSMutableArray array];
    return self;
}

- (LMessage*) message
{
    return message;
}

- (void) addMessage:(LMessage*)newMessage
{
    NSLog(@"Adding Message: %@", newMessage);
    if (message == nil) {
        message = newMessage;
        NSLog(@"First message, set to: %@", message);
    } else {
        NSLog(@"Message exists: %@", message);
        if (argumentStarted) {
            NSLog(@"Adding argument");
            argumentStarted = NO;
            [(LMessage*)[messages lastObject] addArgument:newMessage];
        } else {
            NSLog(@"Setting next message");
            currentMessage.nextMessage = newMessage;
        }
    }
    currentMessage = newMessage;
    NSLog(@"Curent message is: %@", currentMessage);
}

- (void) identifier:(NSString*)name
{
    NSLog(@"Identifier: %@", name);
    [self addMessage:[LMessage buildWithName:name]];
}

- (void) argumentsStart
{
    NSLog(@"Curent message is: %@", currentMessage);
    argumentStarted = YES;
    [messages addObject:currentMessage];
}

- (void) argumentsEnd
{
    currentMessage = [messages lastObject];
    [messages removeLastObject];
    argumentStarted = NO;
}

- (void) nextArgument
{
    argumentStarted = YES;
}

- (void) endMessage
{
    [self addMessage:[EndMessage build]];
}

- (void) textLiteral:(NSString*)name
{
    [self addMessage:[LTextLiteral buildWithName:name]];
}

- (void) numberLiteral:(NSString*)name
{
    
}

@end
