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

- (void)setUp
{
    runtime = [[LRuntime alloc] init];
    execution = [[LExecution alloc] initWithRuntime:runtime];
    context = runtime.theBaseContext;
}

- (void)testRunSelf
{
    // self
    LMessage *selfMessage = [LMessage messageWithName:@"self"];
    result = [execution runMessage:selfMessage withContext:context];
    STAssertEquals(result, context, @"Different result: %@ (context: %@)", result, context);
}

- (void)testRunNew
{
    // mimic
    LMessage *objectMessage = [LMessage messageWithName:@"Object"];
    objectMessage.nextMessage = [LMessage messageWithName:@"new"];
    result = [execution runMessage:objectMessage withContext:context];
    STAssertFalse(result == runtime.theObject, @"Same current target");
}

- (void)testRunMultipleNew
{
    // mimic mimic
    LMessage *objectMessage = [LMessage messageWithName:@"Object"];
    LMessage *mimicMessage = [LMessage messageWithName:@"new"];
    objectMessage.nextMessage = mimicMessage;
    mimicMessage.nextMessage = [LMessage messageWithName:@"new"];
    result = [execution runMessage:objectMessage withContext:context];
    STAssertFalse(result == context, @"Same current target");
}

- (void)testRunTextLiteral
{
    // "hello"
    LMessage *textLiteral = [LTextLiteral messageWithName:@"hello"];
    result = [execution runMessage:textLiteral withContext:context];
    STAssertTrue([result isKindOfClass:[LText class]], @"Different class");
}

- (void)testRunTextUpcase
{
    // "hello" upcase
    LMessage *textLiteral = [LTextLiteral messageWithName:@"hello"];
    textLiteral.nextMessage = [LMessage messageWithName:@"upcase"];
    result = [execution runMessage:textLiteral withContext:context];
    STAssertEqualObjects([(LText*)result text], @"HELLO", @"Not upper case");
}

- (void)testRunEndMessage
{
    // "hello"
    //
    LMessage *textLiteral = [LTextLiteral messageWithName:@"hello"];
    textLiteral.nextMessage = [EndMessage build];
    result = [execution runMessage:textLiteral withContext:context];
    STAssertEquals(result, context, @"Different current target");
}

- (void)testAssignement
{
    // hello = "Hello Cell"
    // hello
    LMessage *assignment = [LMessage messageWithName:@"="];
    [assignment addArgument:[LMessage messageWithName:@"hello"]];
    [assignment addArgument:[LTextLiteral messageWithName:@"Hello Cell"]];
    
    LMessage *end = [EndMessage build];
    assignment.nextMessage = end;
    
    end.nextMessage = [LMessage messageWithName:@"hello"];
    
    result = [execution runMessage:assignment withContext:context];
    STAssertEqualObjects([(LText*)result text], @"Hello Cell", @"Target not evaluated");
}

- (void)testRunNumberLiteral
{
    // 9
    LMessage *numberLiteral = [LNumberLiteral messageWithName:@"9"];
    result = [execution runMessage:numberLiteral withContext:context];
    STAssertTrue([result isKindOfClass:[LNumber class]], @"Different class");
}

@end
