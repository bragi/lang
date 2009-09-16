//
//  LMessageTest.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-17.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LMessageTestCase.h"

@implementation LMessageTestCase

- (void) setUp
{
    hello = [LMessage buildWithName:@"hello"];
    beautiful = [LMessage buildWithName:@"beautiful"];
    world = [LMessage buildWithName:@"world"];
    lady = [LMessage buildWithName:@"lady"];
    more = [LMessage buildWithName:@"more"];
}

- (void) testLMessageExists
{
    STAssertNotNil(hello, @"hello message is nil");
}

- (void) testHasSimpleStringValue
{
    STAssertEqualObjects([hello stringValue], @"hello", @"wrong simple string value");
}

- (void) testHasStringValueWithArgument
{
    [hello addArgument: beautiful];
    STAssertEqualObjects([hello stringValue], @"hello(beautiful)", @"wrong string value with argument");
}

- (void) testHasStringValueWithArguments
{
    [hello addArgument: beautiful];
    [hello addArgument: world];
    STAssertEqualObjects([hello stringValue], @"hello(beautiful, world)", @"wrong string value with argument");
}

- (void) testHasStringValueWithNext
{
    [hello setNextMessage: world];
    STAssertEqualObjects([hello stringValue], @"hello world", @"wrong string value with argument");
}

- (void) testHasStringValueWithNextAndArguments
{
    [hello addArgument: beautiful];
    [hello addArgument: lady];
    [hello setNextMessage: more];
    [more addArgument: beautiful];
    STAssertEqualObjects([hello stringValue], @"hello(beautiful, lady) more(beautiful)", @"wrong string value with argument");
}

- (void) testEqualSimpleMessages
{
    STAssertTrue([hello isEqual:[LMessage buildWithName:@"hello"]], @"identical messages not equal");
    STAssertFalse([lady isEqual:[LMessage buildWithName:@"hello"]], @"different messages not");
}
@end
