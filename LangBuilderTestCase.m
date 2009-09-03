//
//  LangBuilderTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-02.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LangBuilderTestCase.h"


@implementation LangBuilderTestCase
- (void)setUp
{
    builder = [[LangBuilder alloc] init];
    scanner = [[LangScanner alloc] initWithBuilder:builder];
}


@end
