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

- (void) identifier:(NSString*)name
{
    addMessage:[LMessage buildWithName:name];
}

- (void) argumentsStart
{
    argumentStarted = YES;
    [messages addObject:currentMessage];
}

- (void) argumentsEnd
{
    currentMessage = [messages lastObject];
    [messages removeLastObject];
}

- (void) nextArgument
{
    argumentStarted = YES;
}

- (void) endMessage
{
    addMessage:[EndMessage build];
}

- (void) textLiteral:(NSString*)name
{
    addMessage:[LTextLiteral buildWithName:name];
}

- (void) numberLiteral:(NSString*)name
{
    
}

@end
