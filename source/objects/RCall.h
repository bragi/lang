//
//  RCall.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-10-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LRuntime.h"

@interface RCall : NSObject {}

/** Sets all necessary cells and methods. */
+ (void)addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime;

@end
