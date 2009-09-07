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

@implementation LRuntimeTestCase
- (void) setUp
{
    runtime = [[LRuntime alloc] init];
}

- (void) testBootstrap
{
    LMessage* objectKind = [runtime parse:@"Object kind"];
    LExecution* execution = [LExecution buildWithRuntime:runtime];
    LText* result = (LText*)[execution runMessage:objectKind withContext:runtime.theBaseContext];
    STAssertNil(result, @"Object kind is not nil");
    [runtime bootstrap];
    result = (LText*)[execution runMessage:objectKind withContext:runtime.theBaseContext];
    STAssertEqualObjects([result text], @"Object", @"Object kind is not Object");
}
@end
