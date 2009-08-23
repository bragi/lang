//
//  LRuntimeTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LRuntimeTestCase.h"

@implementation LRuntimeTestCase
- (void) setUp
{
    runtime = [[LRuntime alloc] init];
}
- (void) testRunSelf
{
	LMessage* selfMessage = [LMessage buildWithName:@"self"];
    LObject* topContext = runtime.topContext;
    [runtime run:selfMessage];
    STAssertEquals(runtime.currentTarget, topContext, @"Different current target");
}

- (void) testRunMimic
{
	LMessage* mimicMessage = [LMessage buildWithName:@"mimic"];
    LObject* topContext = runtime.topContext;
    [runtime run:mimicMessage];
    STAssertFalse(runtime.currentTarget == topContext, @"Same current target");
}

- (void) testRunMultipleMimics
{
	LMessage* mimicMessage = [LMessage buildWithName:@"mimic"];
    mimicMessage.nextMessage = [LMessage buildWithName:@"mimic"];
    LObject* topContext = runtime.topContext;
    [runtime run:mimicMessage];
    STAssertFalse(runtime.currentTarget == topContext, @"Same current target");
}
@end
