//
//  LangParserTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-09.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LangParserTestCase.h"
#import "LangParser.h"
#import "LMessage.h"
#import "LRuntime.h"

@implementation LangParserTestCase

- (void)setUp
{
    runtime = [[LRuntime alloc] init];
}

- (void)testSkipLastEndMessageInArgument
{
    message = [LangParser parse:@"method(a\n,b)" inRuntime:runtime];
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
    STAssertTrue([message.arguments count] == 2, @"Not enough arguments");
    argument = (LMessage*)[message.arguments objectAtIndex:0];
    STAssertEqualObjects(argument.name, @"a", @"Assignement not shuffled properly");
    argument = (LMessage*)[message.arguments objectAtIndex:1];
    STAssertEqualObjects(argument.name, @"1", @"Assignement not shuffled properly");
}

- (void)testComplexMessageNames
{
    message = [LangParser parse:@"hello? hello:world! some:complex:message!(argument?, arg:ument!)" inRuntime:runtime];
    LMessage * current = message;
    STAssertEqualObjects(current.name, @"hello?", @"Message with question mark not parsed properly");

    current = current.nextMessage;
    STAssertEqualObjects(current.name, @"hello:world!", @"Message with colon and exclamation mark not parsed properly");

    current = current.nextMessage;
    STAssertEqualObjects(current.name, @"some:complex:message!", @"Message with colons, exclamation mark and arguments not parsed properly");
    
    STAssertTrue([current.arguments count] == 2, @"Wrong number of arguments for complex message");
    
    argument = [current.arguments objectAtIndex:0];
    STAssertEqualObjects(argument.name, @"argument?", @"Argument with question mark not parsed properly");

    argument = [current.arguments objectAtIndex:1];
    STAssertEqualObjects(argument.name, @"arg:ument!", @"Argument with colon and exclamation mark not parsed properly");
}
@end
