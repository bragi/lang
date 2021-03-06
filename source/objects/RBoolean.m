//
//  RBoolean.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-23.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RBoolean.h"
#import "CommonMethods.h"

@implementation RTrue

+ (void)addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime
{
    [object setCell:[runtime withExecutableAncestor:[[EEvaluateFirstArgument alloc] init]] withName:@"ifTrue"];
}

@end


@implementation RFalse

+ (void)addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime
{
    [object setCell:[runtime withExecutableAncestor:[[EEvaluateFirstArgument alloc] init]] withName:@"ifFalse"];
}

@end
