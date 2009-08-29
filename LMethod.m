//
//  LMethod.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-21.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LMethod.h"
#import "LExecution.h"

@implementation LMethod
@end

@implementation LLangMethod

- (id)initWithCode:(LMessage*)newCode
{
    self = [super init];
    code = newCode;
    return self;
}

- (LObject*)activate:(LExecution*)execution
{
    return [execution evaluateWithCurrentContext:code];
}

@end
