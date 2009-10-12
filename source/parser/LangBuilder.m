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

+ (NSMutableDictionary*)defaultLevels
{
    NSMutableDictionary *levels = [NSMutableDictionary dictionaryWithCapacity:13];
    [levels setObject:[NSNumber numberWithInt:14] forKey:@"="];
    
    [levels setObject:[NSNumber numberWithInt:6] forKey:@"=="];
    [levels setObject:[NSNumber numberWithInt:6] forKey:@"!="];
    
    [levels setObject:[NSNumber numberWithInt:5] forKey:@"<"];
    [levels setObject:[NSNumber numberWithInt:5] forKey:@">"];
    return levels;
}

- (id)initWithRuntime:(LRuntime*)aRuntime
{
    self = [super init];
    runtime = aRuntime;
    levels = [LangBuilder defaultLevels];
    operators = [NSMutableDictionary dictionary];
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
    previousMessage = currentMessage;
    currentMessage = newMessage;
    currentMessage.previousMessage = previousMessage;
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
    [self nextArgument];
    [messages addObject:currentMessage];
}

- (void)operator:(NSString*)name withLine:(NSUInteger)line andColumn:(NSUInteger)column
{
    OperatorMessage *result;
    if ([name isEqual:@"="] ||
        [name isEqual:@"+="] ||
        [name isEqual:@"-="] ||
        [name isEqual:@"||="] ||
        [name isEqual:@"&&="] ||
        [name isEqual:@"*="] ||
        [name isEqual:@"/="]) {
        result = [AssignmentOperatorMessage messageWithName:name];
    } else {
        result = [OperatorMessage messageWithName:name];
    }
    result.level = [levels objectForKey:name];
    NSLog(@"Result level is %@, name is %@", result.level, name);
    
    NSMutableArray *op = [operators objectForKey:result.level];
    if (!op) {
        op = [NSMutableArray array];
        [operators setObject:op forKey:result.level];
    }
    [op addObject:result];
    
    result.line = line;
    result.column = column;
    [self addMessage:result];
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
    previousMessage = nil;
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
