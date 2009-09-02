//
//  LangScannerTest.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-02.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LangScannerTest.h"


@implementation LangScannerTest

- (void) setUp
{
    scanner = [[LangScanner alloc] init];
}

- (void) testParseSingleMessage
{
    [scanner scan:@"hello"];
}

- (void) testParseTwoMessages
{
    [scanner scan:@"hello world"];
}

- (void) testParseComplexExpression
{
    [scanner scan:@"=(Company, Object new)\n=(company, Company new). company new"];
}

@end
