//
//  LRuntimeTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LRuntimeTestCase.h"
#import "LExecution.h"
#import "LMessage.h"
#import "LObject.h"

#import "LangParser.h"

@implementation LRuntimeTestCase
- (void) setUp
{
    runtime = [[LRuntime alloc] init];
    execution = [LExecution buildWithRuntime:runtime];
}

- (LObject*) executeText:(NSString*)text
{
    code = [LangParser parse:text];
    return [self executeCode];
}

- (LObject*) executeCode
{
    result = [execution runMessage:code withContext:runtime.theBaseContext];
    return result;
}

- (void) testBootstrap
{
    [self executeText:@"Object kind"];
    STAssertNil(result, @"Object kind is not nil");
    [runtime bootstrap];
    [self executeText:@"Object kind"];
    STAssertEqualObjects([(LText*)result text], @"Object", @"Object kind is not Object");
}

- (void) testTypes
{
    STAssertEqualObjects([self executeText:@"Object"], runtime.theObject, @"Object value is not theObject");
    STAssertEqualObjects([self executeText:@"Text"], runtime.theText, @"Text value is not theText");
    STAssertEqualObjects([self executeText:@"Nil"], runtime.theNil, @"Nil value is not theNil");
    STAssertEqualObjects([self executeText:@"False"], runtime.theFalse, @"False value is not theFalse");
    STAssertEqualObjects([self executeText:@"True"], runtime.theTrue, @"True value is not theTrue");
    STAssertEqualObjects([self executeText:@"Number"], runtime.theNumber, @"Number value is not theNumber");
}
@end
