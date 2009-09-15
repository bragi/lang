//
//  RBooleanTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-09.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RBooleanTestCase.h"

@implementation RBooleanTestCase

- (void) setUp
{
    lang = [[Lang alloc] init];
}


- (void) testTrue
{
    result = [lang run:@"true"];
    STAssertEquals(result, lang.runtime.theTrue, @"true not evaluated");
    result = [lang run:@"True"];
    STAssertEquals(result, lang.runtime.theTrue, @"true not evaluated");
}

@end
