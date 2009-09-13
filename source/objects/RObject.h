//
//  RObject.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LMethod.h"
#import "LRuntime.h"

/**
 Adds cells and methods to Object.
 */
@interface RObject : NSObject {}

/** Sets all necessary cells and methods. */
+ (void) addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime;
@end
