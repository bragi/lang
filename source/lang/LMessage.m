//
//  LMessage.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LMessage.h"
#import "LRuntime.h"

@implementation LMessage

@synthesize nextMessage;
@synthesize previousMessage;
@synthesize arguments;
@synthesize name;
@synthesize line;
@synthesize column;

+ (id)messageWithName:(NSString*) newName
{
    return [[LMessage alloc] initWithName:newName];
}

- (id)initWithName:(NSString*) newName 
{
    self = [super init];
    if(self)
    {
        name = newName;
        arguments = nil;
        nextMessage = nil;
    }
    return self;
}

- (NSMutableString*)stringValueWithoutNested
{
    NSMutableString *value = [NSMutableString stringWithString: name];

    if([arguments count] >  0)
    {
        // add (
        [value appendString: @"("];
        
        LMessage *argument;
        BOOL first = YES;

        for(argument in arguments) {
            // add argument's name
            if(first) {
                first = NO;
            } else {
                [value appendString: @", "];
            }
            [value appendString: [argument stringValue]];
        }
        // add )
        [value appendString: @")"];
    }
    return value;
}

- (NSString*)stringValue
{
    NSMutableString *value = [NSMutableString stringWithString: [self stringValueWithoutNested]];
    if(nextMessage) {
        LMessage *message = self;
        while (message = [message nextMessage]) {
            [value appendString: @" "];
            [value appendString: [message stringValueWithoutNested]];
        }
    }
    return value;
}

- (void)addArgument:(LMessage*) argument
{
    if(arguments == nil)
    {
        arguments = [NSMutableArray arrayWithObject:argument];
    }
    else
    {
        [arguments addObject: argument];
    }
}

- (BOOL)isAssignment
{
    return NO;
}

- (BOOL)isOperator
{
    return NO;
}

- (BOOL)isTerminal
{
    return NO;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[LMessage class]]) {
        NSLog(@"Object is of wrong kind: %@", [object class]);
        return NO;
    }
    LMessage *other = (LMessage*)object;
    if (name != other.name) {
        NSLog(@"Names differ: %@, %@", name, other.name);
        return NO;
    }
    if ((arguments != nil || other.arguments !=nil) && ![arguments isEqualTo:other.arguments]) {
        NSLog(@"Arguments differ: %@, %@", arguments, other.arguments);
        return NO;
    }
    if ((nextMessage != nil || other.nextMessage != nil) && ![nextMessage isEqual:other.nextMessage]) {
        NSLog(@"nextMessage differ");
        return NO;
    }
    return YES;
}

- (LObject*)nextWithExecution:(LExecution*)execution
{
    return nextMessage;
}

- (LObject*)argumentsWithExecution:(LExecution*)execution
{
    return [execution.runtime makeListWithEntries:arguments];
}

- (LObject*)nameWithExecution:(LExecution*)execution
{
    return [execution.runtime makeTextWithString:name];
}
@end

@interface OperatorMessage (OperatorShuffling)

- (LMessage*)argumentStart;
- (LMessage*)argumentEndFromStart:(LMessage*)start;

@end



@implementation OperatorMessage

@synthesize level;

+ (id)messageWithName:(NSString*)newName
{
    return [[OperatorMessage alloc] initWithName:newName];
}

- (LMessage*)shuffleWithStartMessage:(LMessage*)startMessage
{
    LMessage* start = [self argumentStart];
    LMessage* end = [self argumentEndFromStart:start];
    LMessage* next = end.nextMessage;
    
    nextMessage = next;
    if (next) {
        next.previousMessage = self;
    }
    
    start.previousMessage = nil;
    end.nextMessage = nil;
    arguments = [NSMutableArray arrayWithObject:start];
    
    return startMessage;
}

- (BOOL)isOperator
{
    return YES;
}

- (LMessage*)argumentStart
{
    LMessage *start = nextMessage;
    // Skip all terminal messages to determine start of arguments
    while(start && [start isTerminal]) {
        start = start.nextMessage;
    }
    return start;
}

- (LMessage*)argumentEndFromStart:(LMessage*)start
{
    LMessage *end = start;
    LMessage *next = end.nextMessage;
    
    while(next && ![next isTerminal] && !([next isOperator] && ([next.arguments count] != 0) && [(OperatorMessage*)next level] == level)) {
        end = next;
        next = next.nextMessage;
    }
    return end;
}

@end


@implementation AssignmentOperatorMessage

+ (id)messageWithName:(NSString*)newName
{
    return [[AssignmentOperatorMessage alloc] initWithName:newName];
}

- (BOOL)isAssignment
{
    return YES;
}

- (LMessage*)shuffleWithStartMessage:(LMessage*)startMessage
{
    LMessage *start = [self argumentStart];
    LMessage *end = [self argumentEndFromStart:start];
    LMessage *next = end.nextMessage;
    LMessage *cellName = self.previousMessage;
    LMessage *target = cellName.previousMessage;
    
    nextMessage = next;
    if (next) {
        next.previousMessage = self;
    }
    
    start.previousMessage = nil;
    end.nextMessage = nil;
    arguments = [NSMutableArray arrayWithObject:cellName];
    [arguments addObject:start];
    
    cellName.nextMessage = nil;
    cellName.previousMessage = nil;
    
    if (target) {
        target.nextMessage = self;
        previousMessage = target;
        return startMessage;
    } else {
        return self;
    }
}

@end


@implementation EndMessage

+ (id)build
{
    return [[EndMessage alloc] init];
}

- (id)init
{
    self = [super initWithName:@"\n"];
    return self;
}

- (BOOL)isTerminal
{
    return YES;
}

@end


@implementation LLiteral
@end

@implementation LTextLiteral

+ (id)messageWithName:(NSString*) newName
{
    return [[LTextLiteral alloc] initWithName:newName];
}

@end


@implementation LNumberLiteral

+ (id)messageWithName:(NSString*) newName
{
    return [[LNumberLiteral alloc] initWithName:newName];
}

@end
