//
//  RBooleanTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-09.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RBooleanTestCase.h"

@implementation RBooleanTestCase

- (void)setUp
{
    lang = [[Lang alloc] init];
}

- (void)testTrue
{
    result = [lang run:@"true"];
    STAssertEquals(result, lang.runtime.theTrue, @"true not evaluated");
    result = [lang run:@"True"];
    STAssertEquals(result, lang.runtime.theTrue, @"true not evaluated");
}

- (void)testIfTrueOnTrue
{
    result = [lang run:@"true ifTrue(\"hello\")"];
    STAssertEqualObjects([(LText*)result text], @"hello", @"ifTrue does not evaluate properly on true");
}

- (void)testIfFalseOnTrue
{
    result = [lang run:@"true ifFalse(\"hello\")"];
    STAssertEqualObjects(result, lang.runtime.theNil, @"ifFalse does not evaluate properly on true");
}

- (void)testIfFalseOnFalse
{
    result = [lang run:@"false ifFalse(\"hello\")"];
    STAssertEqualObjects([(LText*)result text], @"hello", @"ifFalse does not evaluate properly on false");
}

- (void)testIfTrueOnFalse
{
    result = [lang run:@"false ifTrue(\"hello\")"];
    STAssertEqualObjects(result, lang.runtime.theNil, @"ifTrue does not evaluate properly on false");
}

- (void)testIfWithTrueConditionEvaluatesSecondArgument
{
  result = [lang run:@"if(true, \"hello\")"];
  STAssertEqualObjects([(LText*)result text], @"hello", @"if does not evaluate second argument when condition is true");
}

@end
