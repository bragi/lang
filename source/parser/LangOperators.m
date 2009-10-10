//
//  LangOperators.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-27.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LangOperators.h"


@implementation LangOperators

- (LMessage*)shuffle:(LMessage *)message
{
    /**
     We may need to change start message in case:
        a = 2
     This becomes:
        =(a, 2)
     and return message is the second one. 
     */
    startMessage = message;
    currentMessage = message;
    NSLog(@"Starting shuffling of: %@", startMessage.name);
    while (currentMessage) {
        if ([currentMessage.arguments count] > 0) {
            [self shuffleArguments:currentMessage];
        } else {
            if ([currentMessage.name isEqual:@"="]) {
                [self shuffleAssignement];
            }
        }
        previousMessage2 = previousMessage;
        previousMessage = currentMessage;
        currentMessage = currentMessage.nextMessage;
    }
    return startMessage;
}

- (LMessage*)shuffleArguments:(LMessage *)message
{
    NSLog(@"Shuffling arguments");
    NSMutableArray *shuffledArguments = [NSMutableArray arrayWithCapacity:[message.arguments count]];
    for(LMessage *argument in message.arguments) {
        LangOperators *operators = [[LangOperators alloc] init];
        [shuffledArguments addObject:[operators shuffle:argument]];
    }
    message.arguments = shuffledArguments;
    NSLog(@"Done shuffling arguments");
    return message;
}

/**
 We have "=" in currentMessage, cell name in previousMessage and potential target in previousMessage2.
 */
- (void)shuffleAssignement
{
    NSLog(@"In shuffleAssignement");
    LMessage *target = previousMessage2;
    LMessage *cellName = previousMessage;
    LMessage *value = currentMessage.nextMessage;
    LMessage *argumentEnd;
    
    if (value == nil) {
        NSLog(@"Value is nil, can not do shuffle");
        return;
    }
    
    NSLog(@"target: %@, cellName: %@, value: %@, currentMessage: %@", target.name, cellName.name, value.name, currentMessage.name);

    // Ignore terminators directly after =
    while (value != nil && [value isTerminator]) {
        value = value.nextMessage;
    }
    // In value we have message that should be used as second argument
    if (value == nil) {
        NSLog(@"Value is nil, can not do shuffle");
        return;
    }
    
    argumentEnd = value;
    NSLog(@"value: %@", value.name);
    while (argumentEnd.nextMessage && ![argumentEnd.nextMessage isTerminator]) {
        argumentEnd = argumentEnd.nextMessage;
    }
    NSLog(@"argumentEnd: %@", argumentEnd.name);
    // Short circut ='s next message to be next message after argumentEnd
    currentMessage.nextMessage = argumentEnd.nextMessage;
    // argumentEnd next message is nil, it's the last message in second argument
    argumentEnd.nextMessage = nil;
    // value is becoming first argument, arguments do not have previous message
    value.previousMessage = nil;
    // cellName is a single message of first argument, it doesn't have nextMessage
    cellName.nextMessage = nil;
    
    if (target == nil) {
        NSLog(@"There was no target yet");
        startMessage = currentMessage;
        currentMessage.previousMessage = nil;
        NSLog(@"Made assignement a start message");
    } else {
        NSLog(@"Target of assignement is: %@", target.name);
        target.nextMessage = currentMessage;
        currentMessage.previousMessage = target;
    }
    
    currentMessage.arguments = [NSMutableArray arrayWithCapacity:2];
    [currentMessage.arguments addObject:cellName];
    [currentMessage.arguments addObject:value];
    NSLog(@"Shuffling done: %@", [currentMessage stringValueWithoutNested]);
}

@end
