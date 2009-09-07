//
//  LExecutionTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-25.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LExecutionTestCase.h"
#import "LMessage.h"
#import "LText.h"


@implementation LExecutionTestCase

- (void) setUp
{
    runtime = [[LRuntime alloc] init];
    execution = [[LExecution alloc] initWithRuntime:runtime];
    context = runtime.theBaseContext;
}

- (void) testRunSelf
{
    // self
	LMessage* selfMessage = [LMessage buildWithName:@"self"];
    result = [execution runMessage:selfMessage withContext:context];
    STAssertEquals(result, context, @"Different result: %@ (context: %@)", result, context);
}

- (void) testRunMimic
{
    // mimic
	LMessage* objectMessage = [LMessage buildWithName:@"Object"];
    objectMessage.nextMessage = [LMessage buildWithName:@"mimic"];
    result = [execution runMessage:objectMessage withContext:context];
    STAssertFalse(result == runtime.theObject, @"Same current target");
}

- (void) testRunMultipleMimics
{
    // mimic mimic
	LMessage* objectMessage = [LMessage buildWithName:@"Object"];
	LMessage* mimicMessage = [LMessage buildWithName:@"mimic"];
    objectMessage.nextMessage = mimicMessage;
    mimicMessage.nextMessage = [LMessage buildWithName:@"mimic"];
    result = [execution runMessage:objectMessage withContext:context];
    STAssertFalse(result == context, @"Same current target");
}

- (void) testRunTextLiteral
{
    // "hello"
    LMessage* textLiteral = [LTextLiteral buildWithName:@"hello"];
    result = [execution runMessage:textLiteral withContext:context];
    STAssertTrue([result isKindOfClass:[LText class]], @"Different class");
}

- (void) testRunTextUpcase
{
    // "hello" upcase
    LMessage* textLiteral = [LTextLiteral buildWithName:@"hello"];
    textLiteral.nextMessage = [LMessage buildWithName:@"upcase"];
    result = [execution runMessage:textLiteral withContext:context];
    STAssertEqualObjects([(LText*)result text], @"HELLO", @"Not upper case");
}

- (void) testRunEndMessage
{
    // "hello"
    //
    LMessage* textLiteral = [LTextLiteral buildWithName:@"hello"];
    textLiteral.nextMessage = [EndMessage build];
    result = [execution runMessage:textLiteral withContext:context];
    STAssertEquals(result, context, @"Different current target");
}

- (void) testAssignement
{
    // hello = "Hello Cell"
    // hello
    LMessage* assignment = [LMessage buildWithName:@"="];
    [assignment addArgument:[LMessage buildWithName:@"hello"]];
    [assignment addArgument:[LTextLiteral buildWithName:@"Hello Cell"]];
    
    LMessage* end = [EndMessage build];
    assignment.nextMessage = end;
    
    end.nextMessage = [LMessage buildWithName:@"hello"];
    
    result = [execution runMessage:assignment withContext:context];
    STAssertEqualObjects([(LText*)result text], @"Hello Cell", @"Target not evaluated");
}

@end
