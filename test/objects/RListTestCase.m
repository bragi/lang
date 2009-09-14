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
}

-(void)testListWithTrueAndFalse
{
    result = [lang run:@"list(true, false)"];
    STAssertEqualObjects([[(LList*)result list] objectAtIndex:0], lang.runtime.theTrue, @"First element is not true");
    STAssertEqualObjects([[(LList*)result list] lastObject], lang.runtime.theFalse, @"Last element is not false");
}

@end
