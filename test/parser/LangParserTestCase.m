//
//  LangParserTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-09.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LangParserTestCase.h"
#import "LangParser.h"
#import "LangParser2.h"
#import "LMessage.h"
#import "LRuntime.h"

@implementation LangParserTestCase

- (void)setUp
{
    runtime = [[LRuntime alloc] init];
}

- testReadAndPeek
{
    LangParser2 *parser = [[LangParser2 alloc] initWithCode:@"012" andRuntime:runtime];
    STAssertEquals([parser peek], '0', @"Peek is not 0");
    STAssertEquals([parser peek2], '1', @"Peek2 is not 1");
    STAssertEquals([parser read], '0', @"Read is not 0");
    
    STAssertEquals([parser peek], '1', @"Peek is not 1");
    STAssertEquals([parser peek2], '2', @"Peek2 is not 2");
    STAssertEquals([parser read], '1', @"Read is not 1");

    STAssertEquals([parser peek], '2', @"Peek is not 2");
    STAssertEquals([parser peek2], -1, @"Peek2 is not -1");
    STAssertEquals([parser read], '2', @"Read is not 2");

    STAssertEquals([parser peek], -1, @"Peek is not -1");
    STAssertEquals([parser peek2], -1, @"Peek2 is not -1");
    STAssertEquals([parser read], -1, @"Read is not -1");
}

- (void)testSkipLastEndMessageInArgument
{
    message = [LangParser2 parse:@"method(a\n,b)" inRuntime:runtime];
    argument = (LMessage*)[message.arguments objectAtIndex:0];
    STAssertNil(argument.nextMessage, @"End message before next argument not skipped");
    STAssertTrue([message.arguments count] == 2, @"Not enough arguments");
}

- (void)testSkipLastEndMessageInLastArgument
{
    message = [LangParser parse:@"method(a\n)" inRuntime:runtime];
    argument = (LMessage*)[message.arguments objectAtIndex:0];
    STAssertNil(argument.nextMessage, @"End message after last argument not skipped");
    STAssertTrue([message.arguments count] == 1, @"Not enough arguments");
}

- (void)testNotSkipExplicitLastEndMessageInArgument
{
    message = [LangParser parse:@"method(a.,b)" inRuntime:runtime];
    argument = (LMessage*)[message.arguments objectAtIndex:0];
    STAssertNotNil(argument.nextMessage, @"End message before next argument skipped");
    STAssertTrue([message.arguments count] == 2, @"Not enough arguments");
}

- (void)testNotSkipExplicitLastEndMessageInLastArgument
{
    message = [LangParser parse:@"method(a.)" inRuntime:runtime];
    argument = (LMessage*)[message.arguments objectAtIndex:0];
    STAssertNotNil(argument.nextMessage, @"End message after last argument skipped");
    STAssertTrue([message.arguments count] == 1, @"Not enough arguments");
}

- (void)testShuffleAssignement
{
    message = [LangParser parse:@"a = 1" inRuntime:runtime];
    STAssertEqualObjects(message.name, @"=", @"Assignement not shuffled properly");
    NSLog(@"Arguments: %d", [message.arguments count]);
    STAssertTrue([message.arguments count] == 2, @"Not enough arguments");
    argument = (LMessage*)[message.arguments objectAtIndex:0];
    STAssertEqualObjects(argument.name, @"a", @"Assignement not shuffled properly");
    argument = (LMessage*)[message.arguments objectAtIndex:1];
    STAssertEqualObjects(argument.name, @"1", @"Assignement not shuffled properly");
}
@end
