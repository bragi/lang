//
//  LNumber.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LNumber.h"
#import "LExecution.h"
#import "LRuntime.h"

@implementation LNumber

@synthesize number;

+ (id)numberWithAncestor:(LObject*)ancestor string:(NSString*)string
{
    LNumber *theNumber = [[LNumber alloc] initWithString:string];
    [theNumber addAncestor:ancestor];
    return theNumber;
}

+ (id)numberWithAncestor:(LObject*)ancestor integer:(NSInteger)integer
{
    LNumber *theNumber = [[LNumber alloc] initWithInteger:integer];
    [theNumber addAncestor:ancestor];
    return theNumber;
}

- (id)initWithString:(NSString*)string
{
    self = [super init];
    number = [NSDecimalNumber decimalNumberWithString:string];
    return self;
}

- (id)initWithInteger:(NSInteger)integer
{
    self = [super init];
    number = [NSDecimalNumber decimalNumberWithMantissa:integer exponent:0 isNegative:NO];
    return self;
}

- (LObject*)toTextWithExecution:(LExecution *)execution
{
    return [execution.runtime makeTextWithString:[NSString stringWithFormat:@"%d", [number integerValue]]];
}

- (LObject*)isEqualWithExecution:(LExecution*)execution
{
    LObject *other = [execution evaluatedArgumentAtIndex:0];
    if ([other isKindOfClass:[LNumber class]]) {
        NSDecimalNumber *otherNumber = [(LNumber*)other number];
        if ([number isEqualToNumber:otherNumber]) {
            return execution.runtime.theTrue;
        } else {
            return execution.runtime.theFalse;
        }
    } else {
        return execution.runtime.theFalse;
    }
}

- (LObject*)timesWithExecution:(LExecution*)execution
{
    long long value = [number longLongValue];
    for(long long i = 0; i < value; i++) {
        [execution evaluateWithCurrentContext:[execution.message.arguments objectAtIndex:0]];
    }
    return self;
}

@end
