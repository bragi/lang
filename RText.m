//
//  RText.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-27.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "RText.h"
#import "LExecution.h"
#import "LText.h"

@implementation RText

+ (void) addCellsTo: (LObject*)object
{
    /* Add methods */
	[object setCell:[[UpcaseMethod alloc] init] withName:@"upcase"];
}

@end


@implementation UpcaseMethod

- (LObject*) activate: (LExecution*)execution
{
	return [(LText*)execution.target upcaseWithExecution:execution];
}

@end
