//
//  LCall.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-10-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LCall.h"
#import "LNumber.h"
#import "LMessage.h"
#import "LRuntime.h"

@implementation LCall

+ (LCall*)callWithAncestor:(LObject*)theCall execution:(LExecution*)execution
{
    LCall *call = [[LCall alloc] initWithExecution:execution];
    [call addAncestor:theCall];
    return call;
}

- (id) initWithExecution:(LExecution *)execution
{
    self = [super init];
    callExecution = execution;
    return self;
}

- (LObject*)argumentsWithExecution:(LExecution*)execution
{
    return [execution.runtime makeListWithEntries:callExecution.message.arguments];
}

- (LObject*)evaluatedArgumentWithExecution:(LExecution*)execution
{
    LNumber *argumentPosition = (LNumber *)[execution evaluatedArgumentAtIndex:0];
    return [callExecution evaluatedArgumentAtIndex:[argumentPosition.number integerValue]];
}

@end
