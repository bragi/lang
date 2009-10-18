//
//  RPairTestCase.m
//  lang
//
//  Created by Łukasz Piestrzeniewicz on 09-10-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RPairTestCase.h"
#import "Lang.h"
#import "LRuntime.h"

@implementation RPairTestCase

- (void)setUp
{
    lang = [[Lang alloc] init];
}

- (void)testCreatePair
{
    // p = pair("hello", "world")
    // p
    result = [lang run:@"p = pair(\"hello\", \"world\"). p key"];
    STAssertEqualObjects([(LText*)result text], @"hello", @"Method not called");
    result = [lang run:@"p = pair(\"hello\", \"world\"). p value"];
    STAssertEqualObjects([(LText*)result text], @"world", @"Method not called");
    
//    result = [lang run:@"p = (\"hello\" : \"world\"). p key"];
//    STAssertEqualObjects([(LText*)result text], @"hello", @"Method not called");
//    result = [lang run:@"p = (\"hello\" : \"world\"). p value"];
//    STAssertEqualObjects([(LText*)result text], @"world", @"Method not called");
}

@end
