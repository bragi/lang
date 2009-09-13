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

+ (void) addCellsTo: (LObject*)object inRuntime:(LRuntime*)runtime
{
    /* Add methods */
	[object setCell:[[ForwardingMethod alloc] initWithName:@"mimic"] withName:@"mimic"];
}

@end
