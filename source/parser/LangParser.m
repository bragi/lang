//
//  LangParser.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-09.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LangParser.h"
#import "LangBuilder.h"
#import "LangScanner.h"

@implementation LangParser

+ (LMessage*)parse:(NSString*)codeText inRuntime:(LRuntime*)runtime
{
    LangBuilder *builder = [[LangBuilder alloc] initWithRuntime:runtime];
    LangScanner *scanner = [[LangScanner alloc] initWithBuilder:builder];
    [scanner scan:codeText];
    return [builder message];
}
@end
