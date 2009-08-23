//
//  RObject.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RObject.h"


@implementation RObject

+ (void) addCellsTo: (LObject*)object
{
    /* Add methods */
	[object setCell:[[SelfMethod alloc] init] withName:@"self"];
	[object setCell:[[MimicMethod alloc] init] withName:@"mimic"];
}

@end


@implementation SelfMethod

- (LObject*) activate: (LFrame*)frame
{
	return [frame target];
}

@end


@implementation MimicMethod

- (LObject*) activate: (LFrame*)frame
{
	return [[frame target] mimicWithFrame:frame];
}

@end
