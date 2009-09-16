//
//  Lang.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-09.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "Lang.h"
#import "LangParser.h"

@implementation Lang

@synthesize runtime;

- (id)init
{
    self = [super init];
    runtime = [[[LRuntime alloc] init] bootstrap];
    execution = [LExecution buildWithRuntime:runtime];
    return self;
}

- (LObject*)run:(NSString*)codeText
{
    code = [LangParser parse:codeText];
    return [execution runMessage:code withContext:runtime.theBaseContext];
}

@end
