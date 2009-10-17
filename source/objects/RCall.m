//
//  RCall.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-10-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RCall.h"
#import "CommonMethods.h"

@implementation RCall

+ (void)addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime
{
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"arguments"]] withName:@"arguments"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"evaluatedArgument"]] withName:@"evaluatedArgument"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"message"]] withName:@"message"];
}

@end
