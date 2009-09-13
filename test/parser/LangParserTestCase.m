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

@implementation LangParserTestCase

- (void)testSkipLastEndMessageInArgument
{
    LMessage* message = [LangParser parse:@"method(a\n,b)"];
    LMessage* argument = (LMessage*)[message.arguments objectAtIndex:0];
    STAssertNil(argument.nextMessage, @"End message before next argument not skipped");
    STAssertTrue([message.arguments count] == 2, @"Not enough arguments");
}

- (void)testSkipLastEndMessageInLastArgument
{
    LMessage* message = [LangParser parse:@"method(a\n)"];
    LMessage* argument = (LMessage*)[message.arguments objectAtIndex:0];
    STAssertNil(argument.nextMessage, @"End message after last argument not skipped");
    STAssertTrue([message.arguments count] == 1, @"Not enough arguments");
}

- (void)testNotSkipExplicitLastEndMessageInArgument
{
    LMessage* message = [LangParser parse:@"method(a.,b)"];
    LMessage* argument = (LMessage*)[message.arguments objectAtIndex:0];
    STAssertNotNil(argument.nextMessage, @"End message before next argument skipped");
    STAssertTrue([message.arguments count] == 2, @"Not enough arguments");
}

- (void)testNotSkipExplicitLastEndMessageInLastArgument
{
    LMessage* message = [LangParser parse:@"method(a.)"];
    LMessage* argument = (LMessage*)[message.arguments objectAtIndex:0];
    STAssertNotNil(argument.nextMessage, @"End message after last argument skipped");
    STAssertTrue([message.arguments count] == 1, @"Not enough arguments");
}
@end
