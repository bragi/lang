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
- (void)setUp
{
    runtime = [[LRuntime alloc] init];
    execution = [LExecution buildWithRuntime:runtime];
}

- (LObject*)executeText:(NSString*)text
{
    code = [LangParser parse:text inRuntime:runtime];
    return [self executeCode];
}

- (LObject*)executeCode
{
    result = [execution runMessage:code withContext:runtime.theBaseContext];
    return result;
}

- (void)testBootstrap
{
    [self executeText:@"Object cell(\"kind\")"];
    STAssertNil(result, @"Object kind is not nil");
    [runtime bootstrap];
    [self executeText:@"Object kind"];
    STAssertEqualObjects([(LText*)result text], @"Object", @"Object kind is not Object");
}

@end
