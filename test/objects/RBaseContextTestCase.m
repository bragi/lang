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
    STAssertEqualObjects([lang run:@"BaseContext"], lang.runtime.theBaseContext, @"BaseContext value is not theBaseContext");
    STAssertEqualObjects([lang run:@"Call"], lang.runtime.theCall, @"Call value is not theCall");
    STAssertEqualObjects([lang run:@"Executable"], lang.runtime.theExecutable, @"Executable value is not theExecutable");
    STAssertEqualObjects([lang run:@"False"], lang.runtime.theFalse, @"False value is not theFalse");
    STAssertEqualObjects([lang run:@"LangExecutable"], lang.runtime.theLangExecutable, @"LangExecutable value is not theLangExecutable");
    STAssertEqualObjects([lang run:@"List"], lang.runtime.theList, @"List value is not theList");
    STAssertEqualObjects([lang run:@"Object"], lang.runtime.theObject, @"Object value is not theObject");
    STAssertEqualObjects([lang run:@"Macro"], lang.runtime.theMacro, @"Macro value is not theMacro");
    STAssertEqualObjects([lang run:@"Message"], lang.runtime.theMessage, @"Message value is not theMessage");
    STAssertEqualObjects([lang run:@"Method"], lang.runtime.theMethod, @"Method value is not theMethod");
    STAssertEqualObjects([lang run:@"Nil"], lang.runtime.theNil, @"Nil value is not theNil");
    STAssertEqualObjects([lang run:@"Number"], lang.runtime.theNumber, @"Number value is not theNumber");
    STAssertEqualObjects([lang run:@"Text"], lang.runtime.theText, @"Text value is not theText");
    STAssertEqualObjects([lang run:@"True"], lang.runtime.theTrue, @"True value is not theTrue");
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

- (void)testKinds
{
    STAssertEqualObjects([(LText*)[lang run:@"BaseContext kind"] text], @"BaseContext", @"BaseContext kind is not BaseContext");
    STAssertEqualObjects([(LText*)[lang run:@"Call kind"] text], @"Call", @"Call kind is not Call");
    STAssertEqualObjects([(LText*)[lang run:@"Executable kind"] text], @"Executable", @"Executable kind is not Executable");
    STAssertEqualObjects([(LText*)[lang run:@"False kind"] text], @"False", @"False kind is not False");
    STAssertEqualObjects([(LText*)[lang run:@"LangExecutable kind"] text], @"LangExecutable", @"LangExecutable kind is not LangExecutable");
    STAssertEqualObjects([(LText*)[lang run:@"List kind"] text], @"List", @"List kind is not List");
    STAssertEqualObjects([(LText*)[lang run:@"Object kind"] text], @"Object", @"Object kind is not Object");
    STAssertEqualObjects([(LText*)[lang run:@"Macro kind"] text], @"Macro", @"Macro kind is not Macro");
    STAssertEqualObjects([(LText*)[lang run:@"Message kind"] text], @"Message", @"Message kind is not Message");
    STAssertEqualObjects([(LText*)[lang run:@"Method kind"] text], @"Method", @"Method kind is not Method");
    STAssertEqualObjects([(LText*)[lang run:@"Nil kind"] text], @"Nil", @"Nil kind is not Nil");
    STAssertEqualObjects([(LText*)[lang run:@"Number kind"] text], @"Number", @"Number kind is not Number");
    STAssertEqualObjects([(LText*)[lang run:@"Text kind"] text], @"Text", @"Text kind is not Text");
    STAssertEqualObjects([(LText*)[lang run:@"True kind"] text], @"True", @"True kind is not True");
}

@end
