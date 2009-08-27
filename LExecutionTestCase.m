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
#import "LText.h"


@implementation LExecutionTestCase

- (void) setUp
{
    runtime = [[LRuntime alloc] init];
    execution = [[LExecution alloc] initWithRuntime:runtime];
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

- (void) testRunTextLiteral
{
    LMessage* textLiteral = [LTextLiteral buildWithName:@"hello"];
    result = [execution runMessage:textLiteral withContext:context];
    STAssertTrue([result isKindOfClass:[LText class]], @"Different class");
}

- (void) testRunTextUpcase
{
    LMessage* textLiteral = [LTextLiteral buildWithName:@"hello"];
    textLiteral.nextMessage = [LMessage buildWithName:@"upcase"];
    result = [execution runMessage:textLiteral withContext:context];
    STAssertEqualObjects([(LText*)result text], @"HELLO", @"Not upper case");
}

@end
