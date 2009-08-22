//
//  LRuntimeTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LRuntimeTestCase.h"
#import "LRuntime.h"
#import "RObject.h"

@implementation LRuntimeTestCase
- (void) testRunSelf
{
	LMessage* selfMessage = [LMessage buildWithName:@"self"];
    LRuntime* runtime = [[LRuntime alloc] init];
    RObject* topContext = [RObject build];
    runtime.topContext = topContext;
    [runtime run:selfMessage];
    STAssertEqualObjects(runtime.currentTarget, topContext, @"Different current target");
}
@end
