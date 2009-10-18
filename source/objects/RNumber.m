//
//  RNumber.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RNumber.h"
#import "LExecution.h"
#import "CommonMethods.h"

@implementation RNumber

+ (void)addCellsTo: (LObject*)object inRuntime:(LRuntime*)runtime
{
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"times"]] withName:@"times"];
}

@end
