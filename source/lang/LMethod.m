//
//  LMethod.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-21.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LMethod.h"
#import "LExecution.h"
#import "CommonMethods.h"

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
    return [execution evaluateCode:code inContext:[self methodContextWithExecution:execution]];
}

- (id)methodContextWithExecution:(LExecution*)execution
{
    /** 
     Execution context forwards all cell access to execution target.
     We use normal inheritance model to achieve that. Simple.
     */
    LObject *context = [execution.target newWithExecution:execution];
    /**
     Self in execution context must point to execution target, not the
     context itself. We need to redefine self then.
     */
    [context setCell:execution.target withName:@"self"];
    [context setCell:[[ReturnMethod alloc] init] withName:@"return"];
    return context;
}
@end


@implementation LLangMacro

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
