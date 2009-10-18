//
//  RPair.m
//  lang
//
//  Created by Łukasz Piestrzeniewicz on 09-10-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RPair.h"
#import "CommonMethods.h"

@implementation RPair

+ (void)addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime
{
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"key"]] withName:@"key"];
    [object setCell:[runtime withExecutableAncestor:[[EForward alloc] initWithName:@"value"]] withName:@"value"];
}

@end
