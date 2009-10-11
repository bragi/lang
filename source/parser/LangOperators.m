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
     and start message is now '='. We need to return proper start message
     */
    startMessage = message;
    currentMessage = message;
    while (currentMessage) {
        if ([currentMessage.arguments count] > 0) {
            [self shuffleArguments:currentMessage];
        } else {
            if ([currentMessage isAssignment]) {
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
    NSLog(@"+Shuffling arguments of %@", message.name);
    NSMutableArray *shuffledArguments = [NSMutableArray arrayWithCapacity:[message.arguments count]];
    for(LMessage *argument in message.arguments) {
        LangOperators *operators = [[LangOperators alloc] init];
        [shuffledArguments addObject:[operators shuffle:argument]];
    }
    message.arguments = shuffledArguments;
    NSLog(@"-Shuffling arguments of %@", message.name);
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
    NSLog(@"target: %@, cellName: %@, value: %@", target.name, cellName.name, value.name);
    while ([value.name isEqual:@"\n"]) {
        value = value.nextMessage;
    }
    argumentEnd = value;
    NSLog(@"value: %@", value.name);
    while (argumentEnd.nextMessage && ![argumentEnd.nextMessage isKindOfClass:[EndMessage class]]) {
        argumentEnd = argumentEnd.nextMessage;
    }
    NSLog(@"argumentEnd: %@", argumentEnd.name);
    currentMessage.nextMessage = argumentEnd.nextMessage;
    argumentEnd.nextMessage = nil;
    
    if (target == nil) {
        NSLog(@"target is nil");
        startMessage = currentMessage;
        NSLog(@"target is set");
    } else {
        NSLog(@"target is not nil");
        target.nextMessage = currentMessage;
    }
    
    currentMessage.arguments = [NSMutableArray arrayWithCapacity:2];
    [currentMessage.arguments addObject:cellName];
    [currentMessage.arguments addObject:value];
}

@end
