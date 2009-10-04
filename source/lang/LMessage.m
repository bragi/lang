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

- (BOOL)isTerminator
{
    return NO;
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

- (BOOL)isTerminator
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
