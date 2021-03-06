//
//  RObject.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RObject.h"
#import "CommonMethods.h"

@implementation RObject

+ (void)addCellsTo: (LObject*)object inRuntime:(LRuntime*)runtime
{
    /* Add methods */
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"new"]] withName:@"new"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"isEqual"]] withName:@"=="];
}

@end
