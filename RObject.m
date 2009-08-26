//
//  RObject.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RObject.h"
#import "LExecution.h"

@implementation RObject

+ (void) addCellsTo: (LObject*)object
{
    /* Add methods */
	[object setCell:[[SelfMethod alloc] init] withName:@"self"];
	[object setCell:[[MimicMethod alloc] init] withName:@"mimic"];
}

@end


@implementation SelfMethod

- (LObject*) activate: (LExecution*)execution
{
	return execution.target;
}

@end


@implementation MimicMethod

- (LObject*) activate: (LExecution*)execution
{
	return [execution.target mimicWithExecution:execution];
}

@end
