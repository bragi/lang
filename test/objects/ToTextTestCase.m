//
//  ToTextTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "ToTextTestCase.h"
#import "Lang.h"
#import "LRuntime.h"

@implementation ToTextTestCase
- (void)setUp
{
    lang = [[Lang alloc] init];
}

- (void)testObjectToText
{
    result = (LText*)[lang run:@"Object toText"];
    expected = [NSString stringWithFormat:@"%@", lang.runtime.theObject];
    STAssertEqualObjects([result text], expected, @"Object toText is not formatted object");
}

- (void)testNilToText
{
    result = (LText*)[lang run:@"nil toText"];
    expected = @"nil";
    STAssertEqualObjects([result text], expected, @"nil toText is not \"nil\"");
}

- (void)testFalseToText
{
    result = (LText*)[lang run:@"false toText"];
    expected = @"false";
    STAssertEqualObjects([result text], expected, @"false toText is not \"false\"");
}

- (void)testTrueToText
{
    result = (LText*)[lang run:@"true toText"];
    expected = @"true";
    STAssertEqualObjects([result text], expected, @"true toText is not \"true\"");
}

- (void)testTextToText
{
    result = (LText*)[lang run:@"Text toText"];
    expected = @"";
    STAssertEqualObjects([result text], expected, @"Text toText is not \"\"");
}

- (void)testTextLiteralToText
{
    result = (LText*)[lang run:@"\"text\" toText"];
    expected = @"text";
    STAssertEqualObjects([result text], expected, @"\"text\" toText is not \"text\"");
}

- (void)testNumberLiteralToText
{
    result = (LText*)[lang run:@"9 toText"];
    expected = @"9";
    STAssertEqualObjects([result text], expected, @"9 toText is not \"9\"");
}
@end
