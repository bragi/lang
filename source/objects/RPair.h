//
//  RPair.h
//  lang
//
//  Created by Łukasz Piestrzeniewicz on 09-10-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LRuntime.h"

@interface RPair : NSObject {}

/** Sets all necessary cells and methods. */
+ (void)addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime;

@end
