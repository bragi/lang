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

/**
 Factory for adding cells necessery for Object.
 */
@interface RObject : NSObject {}

/** Creates new instance with given runtime, sets all necessary cells and methods. */
+ (void) addCellsTo:(LObject*)object;
@end

/**
 Returns the receiver.
 */
@interface SelfMethod : LMethod {}
@end

/** Mimics receiver. */
@interface MimicMethod : LMethod {}
@end
