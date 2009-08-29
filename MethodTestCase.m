//
//  MethodTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-28.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "MethodTestCase.h"
#import "RObject.h"
#import "LMessage.h"
#import "LText.h"


@implementation MethodTestCase
- (void) setUp
{
    runtime = [[LRuntime alloc] init];
    execution = [[LExecution alloc] initWithRuntime:runtime];
    context = [LObject build];
    [RObject addCellsTo:context];
}

- (void) testCreateAndCallWithNoArguments
{
    // hello = method("hello")
    // hello
    LMessage* method = [LMessage buildWithName:@"method"];
    [method addArgument:[LTextLiteral buildWithName:@"hello"]];
    
    LMessage* assignment = [LMessage buildWithName:@"="];
    [assignment addArgument:[LMessage buildWithName:@"hello"]];
    [assignment addArgument:method];
    
    LMessage* end = [EndMessage build];
    assignment.nextMessage = end;
    
    end.nextMessage = [LMessage buildWithName:@"hello"];
    
    result = [execution runMessage:assignment withContext:context];
    STAssertEqualObjects([(LText*)result text], @"hello", @"Method not called");
}

- (void) testMoreComplexCreateAndCallWithNoArguments
{
    // hello = method("hello" upcase)
    // hello
    LMessage* method = [LMessage buildWithName:@"method"];
    LMessage* helloLiteral = [LTextLiteral buildWithName:@"hello"];
    helloLiteral.nextMessage = [LMessage buildWithName:@"upcase"];
    [method addArgument:helloLiteral];
    
    LMessage* assignment = [LMessage buildWithName:@"="];
    [assignment addArgument:[LMessage buildWithName:@"hello"]];
    [assignment addArgument:method];
    
    LMessage* end = [EndMessage build];
    assignment.nextMessage = end;
    
    end.nextMessage = [LMessage buildWithName:@"hello"];
    
    result = [execution runMessage:assignment withContext:context];
    STAssertEqualObjects([(LText*)result text], @"HELLO", @"Method not called");
}

@end
