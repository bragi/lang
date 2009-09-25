//
//  RList.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-14.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RList.h"
#import "LExecution.h"
#import "LList.h"
#import "CommonMethods.h"

@implementation RList

+ (void)addCellsTo: (LObject*)object inRuntime:(LRuntime*)runtime
{
    /* Add methods */
    [object setCell:[[ForwardingMethod alloc] initWithName:@"length"] withName:@"length"];
    [object setCell:[[ForwardingMethod alloc] initWithName:@"first"] withName:@"first"];
}

@end
