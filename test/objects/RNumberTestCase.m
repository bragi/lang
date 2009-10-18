//
//  RNumber.m
//  lang
//
//  Created by Łukasz Piestrzeniewicz on 09-10-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RNumberTestCase.h"
#import "Lang.h"
#import "LRuntime.h"
#import "LNumber.h"

@implementation RNumberTestCase

- (void)setUp
{
    lang = [[Lang alloc] init];
}

- (void)testTimes
{
    // 1 times("hello")
    result = [lang run:@"1 times(\"hello\")"];
    STAssertEqualObjects([(LNumber*)result number], [NSDecimalNumber numberWithInt:1], @"Times not called");
}

@end
