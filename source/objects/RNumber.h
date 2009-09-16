//
//  RNumber.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LRuntime.h"


@interface RNumber : NSObject {}

/** Sets all necessary cells and methods. */
+ (void)addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime;

@end
