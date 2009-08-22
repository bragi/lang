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
	hello = [[LMessage alloc] initWithName:@"hello"];
	beautiful = [[LMessage alloc] initWithName:@"beautiful"];
	world = [[LMessage alloc] initWithName:@"world"];
	lady = [[LMessage alloc] initWithName:@"lady"];
	more = [[LMessage alloc] initWithName:@"more"];
}

- (void) tearDown
{
	[hello release];
	[beautiful release];
	[world release];
	[lady release];
	[more release];
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
@end
