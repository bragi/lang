//
//  RListTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-14.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RListTestCase.h"


@implementation RListTestCase

-(void)setUp
{
    lang = [[Lang alloc] init];
}

-(void)testEmptyList
{
    result = [lang run:@"list()"];
    STAssertTrue([result isKindOfClass:[LList class]], @"Wrong list class");
}

-(void)testListWithTrueAndFalse
{
    result = [lang run:@"list(true, false)"];
    STAssertEqualObjects([[(LList*)result list] objectAtIndex:0], lang.runtime.theTrue, @"First element is not true");
    STAssertEqualObjects([[(LList*)result list] lastObject], lang.runtime.theFalse, @"Last element is not false");
}

-(void)testListLength
{
    STAssertEqualObjects([(LNumber*)[lang run:@"list() length"] number],
                         [NSDecimalNumber decimalNumberWithMantissa:0 exponent:0 isNegative:NO], 
                         @"Empty list has no 0 length");
    STAssertEqualObjects([(LNumber*)[lang run:@"list(true) length"] number], 
                         [NSDecimalNumber decimalNumberWithMantissa:1 exponent:0 isNegative:NO],
                         @"One-element list has no 1 length");
    STAssertEqualObjects([(LNumber*)[lang run:@"list(true, false) length"] number], 
                         [NSDecimalNumber decimalNumberWithMantissa:2 exponent:0 isNegative:NO],
                         @"Two-element list has no 2 length");
}

@end
