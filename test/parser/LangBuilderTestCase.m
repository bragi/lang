//
//  LangBuilderTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-02.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LangBuilderTestCase.h"
#import "LMessage.h"
#import "LRuntime.h"

@implementation LangBuilderTestCase
- (void)setUp
{
    builder = [[LangBuilder alloc] initWithRuntime:[[LRuntime alloc] init]];
    name = [LMessage buildWithName:@"name"];
    hello = [LMessage buildWithName:@"hello"];
}

- (void)testSimpleMessage
{
    NSLog(@"testSimpleMesage");
    [builder identifier:@"name" withLine:0 andColumn:0];
    STAssertTrue([[builder message] isEqual:name], 
                 @"Different messages: %@", [builder message]);
}

- (void)testSimpleMessageWithArgument
{
    [builder identifier:@"name" withLine:0 andColumn:0];
    [builder argumentsStart];
    [builder identifier:@"hello" withLine:0 andColumn:0];
    [builder argumentsEnd];
    [name addArgument:hello];
    STAssertTrue([[builder message] isEqual:name], 
                 @"Different messages: %@", [builder message]);
}
@end
