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
    result = [lang run:@"hello = method(\"hello\"). hello"];
    STAssertEqualObjects([(LText*)result text], @"hello", @"Method not called");
}

- (void)testMoreComplexCreateAndCallWithNoArguments
{
    // hello = method("hello" upcase)
    // hello
    result = [lang run:@"hello = method(\"hello\" upcase). hello"];
    STAssertEqualObjects([(LText*)result text], @"HELLO", @"Method not called");
}

- (void)testSelfInMethod
{
    // true hello = method(self)
    // true hello
    result = [lang run:@"true hello = method(self). true hello"];
    STAssertEqualObjects(result, lang.runtime.theTrue, @"Self in invoked method differs");
}

- (void)testReturnInMethod
{
    // hello = method(return(true). false)
    // hello
    result = [lang run:@"hello = method(return(true). false). hello"];
    STAssertEqualObjects(result, lang.runtime.theTrue, @"Return does not return proper value");
}

- (void)testMethodWithArguments
{
    // myUpcase = method(text, text upcase)
    // myUpcase("hello")
    result = [lang run:@"myUpcase = method(text, text upcase). myUpcase(\"hello\")"];
    STAssertEqualObjects([(LText*)result text], @"HELLO", @"Method not called");
}

- (void)testMethodWithEvaluatedArguments
{
    // text = "hello"
    // myUpcase = method(text, text upcase)
    // myUpcase(text)
    result = [lang run:@"text = \"hello\". myUpcase = method(text, text upcase). myUpcase(text)"];
    STAssertEqualObjects([(LText*)result text], @"HELLO", @"Method not called");
}

- (void)testMethodWithDefaultArgument
{
    // myUpcase = method(text "hello", text upcase)
    // myUpcase
    result = [lang run:@"myUpcase = method(text \"hello\", text upcase). myUpcase"];
    STAssertEqualObjects([(LText*)result text], @"HELLO", @"Method not called");
    result = [lang run:@"myUpcase = method(text \"hello\", text upcase). myUpcase(\"xxx\")"];
    STAssertEqualObjects([(LText*)result text], @"XXX", @"Method not called");
}

- (void)testReturnInArguments
{
    // inner = method(a, true)
    // outer = method(inner(return(false))) # This returns false always, inner code is never called
    // outer
    result = [lang run:@"inner = method(a, true). outer = method(inner(return(false))). outer"];
    STAssertEqualObjects(result, lang.runtime.theFalse, @"return not evaluated properly in arguments");
}

- (void)testMessageNameInMacro
{
    // m = macro(call message name)
    // m
    result = [lang run:@"m = macro(call message name). m"];
    STAssertEqualObjects([(LText*)result text], @"m", @"Message name is different");
}

- (void)testMessageArgumentsInMacro
{
    // m = macro(call message arguments first name)
    // m(hello)
    result = [lang run:@"m = macro(call message arguments first name). m(hello)"];
    STAssertEqualObjects([(LText*)result text], @"hello", @"Message name is different");
}
@end
