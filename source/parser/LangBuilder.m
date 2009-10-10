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

- (void)identifier:(NSString*)name withLine:(NSUInteger)line andColumn:(NSUInteger)column
{
    LMessage *result = [LMessage messageWithName:name];
    result.line = line;
    result.column = column;
    [self addMessage:result];
}

- (void)identifierWithArguments:(NSString*)name withLine:(NSUInteger)line andColumn:(NSUInteger)column
{
    [self identifier:name withLine:line andColumn:column];
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

- (void)endMessageWithLine:(NSUInteger)line andColumn:(NSUInteger)column
{
    LMessage *result = [EndMessage build];
    result.line = line;
    result.column = column;
    [self addMessage:result];
}

- (void)textLiteral:(NSString*)name withLine:(NSUInteger)line andColumn:(NSUInteger)column
{
    LMessage *result = [LTextLiteral messageWithName:name];
    result.line = line;
    result.column = column;
    [self addMessage:result];
}

- (void)numberLiteral:(NSString*)name withLine:(NSUInteger)line andColumn:(NSUInteger)column
{
    LMessage *result = [LNumberLiteral messageWithName:name];
    result.line = line;
    result.column = column;
    [self addMessage:result];
}

@end
