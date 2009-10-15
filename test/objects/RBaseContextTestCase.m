//
//  RBaseContextTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-15.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RBaseContextTestCase.h"
#import "LText.h"

@implementation RBaseContextTestCase

- (void)setUp
{
    lang = [[Lang alloc] init];
}

- (void)testTypes
{
    STAssertEqualObjects([lang run:@"Object"], lang.runtime.theObject, @"Object value is not theObject");
    STAssertEqualObjects([lang run:@"Text"], lang.runtime.theText, @"Text value is not theText");
    STAssertEqualObjects([lang run:@"Nil"], lang.runtime.theNil, @"Nil value is not theNil");
    STAssertEqualObjects([lang run:@"False"], lang.runtime.theFalse, @"False value is not theFalse");
    STAssertEqualObjects([lang run:@"True"], lang.runtime.theTrue, @"True value is not theTrue");
    STAssertEqualObjects([lang run:@"Number"], lang.runtime.theNumber, @"Number value is not theNumber");
}

- (void)testMacro
{
    result = [lang run:@"hello = macro(\"hello\" upcase). hello"];
    STAssertEqualObjects([(LText*)result text], @"HELLO", @"Macro not called properly");
}

- (void)testEmptyMessage
{
    result = [lang run:@"(\"hello\")"];
    STAssertEqualObjects([(LText*)result text], @"hello", @"Empty message not called");
}

- (void)testListLiteral
{
    result = [lang run:@"[]"];
    STAssertTrue([result isKindOfClass:[LList class]], @"List message does not return list");
}

- (void)testAssignKind
{
    result = [lang run:@"Test = Object new. Test kind"];
    STAssertEqualObjects([(LText*)result text], @"Test", @"Test kind not assigned");
}

- (void)testTypesKinds
{
    STAssertEqualObjects([(LText*)[lang run:@"Object kind"] text], @"Object", @"Object kind is not Object");
    STAssertEqualObjects([(LText*)[lang run:@"Text kind"] text], @"Text", @"Text kind is not Text");
    STAssertEqualObjects([(LText*)[lang run:@"Nil kind"] text], @"Nil", @"Nil kind is not Nil");
    STAssertEqualObjects([(LText*)[lang run:@"False kind"] text], @"False", @"False kind is not False");
    STAssertEqualObjects([(LText*)[lang run:@"True kind"] text], @"True", @"True kind is not True");
    STAssertEqualObjects([(LText*)[lang run:@"Number kind"] text], @"Number", @"Number kind is not Number");
}

@end
