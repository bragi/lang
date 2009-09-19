//
//  MethodTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-19.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "MethodTestCase.h"
#import "Lang.h"
#import "LRuntime.h"


@implementation MethodTestCase
- (void)setUp
{
    lang = [[Lang alloc] init];
}

- (void)testCreateAndCallWithNoArguments
{
    // hello = method("hello")
    // hello
    result = [lang run:@"=(hello, method(\"hello\"))\nhello"];
    STAssertEqualObjects([(LText*)result text], @"hello", @"Method not called");
}

- (void)testMoreComplexCreateAndCallWithNoArguments
{
    // hello = method("hello" upcase)
    // hello
    result = [lang run:@"=(hello, method(\"hello\" upcase))\nhello"];
    STAssertEqualObjects([(LText*)result text], @"HELLO", @"Method not called");
}

- (void)testSelfInMethod
{
    // true hello = method(self)
    // true hello
    result = [lang run:@"true =(hello, method(self))\ntrue hello"];
    STAssertEqualObjects(result, lang.runtime.theTrue, @"Self in invoked method differs");
}
@end
