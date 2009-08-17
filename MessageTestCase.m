//
//  MessageTest.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-17.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "MessageTestCase.h"

@implementation MessageTestCase

- (void) setUp
{
	hello = [[Message alloc] initWithName:@"hello"];
	beautiful = [[Message alloc] initWithName:@"beautiful"];
	world = [[Message alloc] initWithName:@"world"];
	lady = [[Message alloc] initWithName:@"lady"];
	more = [[Message alloc] initWithName:@"more"];
}

- (void) tearDown
{
	[hello release];
	[beautiful release];
	[world release];
	[lady release];
	[more release];
}

- (void) testMessageExists
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
@end
