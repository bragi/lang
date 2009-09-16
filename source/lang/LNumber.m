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

@end
