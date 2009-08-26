//
//  LExecutionTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-25.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LExecutionTestCase.h"
#import "RObject.h"
#import "LMessage.h"


@implementation LExecutionTestCase

- (void) setUp
{
    execution = [[LExecution alloc] initWithRuntime:nil];
    context = [LObject build];
    [RObject addCellsTo:context];
}

- (void) testRunSelf
{
	LMessage* selfMessage = [LMessage buildWithName:@"self"];
    result = [execution runMessage:selfMessage withContext:context];
    STAssertEquals(result, context, @"Different current target");
}

- (void) testRunMimic
{
	LMessage* mimicMessage = [LMessage buildWithName:@"mimic"];
    result = [execution runMessage:mimicMessage withContext:context];
    STAssertFalse(result == context, @"Same current target");
}

- (void) testRunMultipleMimics
{
	LMessage* mimicMessage = [LMessage buildWithName:@"mimic"];
    mimicMessage.nextMessage = [LMessage buildWithName:@"mimic"];
    result = [execution runMessage:mimicMessage withContext:context];
    STAssertFalse(result == context, @"Same current target");
}

@end
