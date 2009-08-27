//
//  RText.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-27.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LMethod.h"

@interface RText : NSObject {}

/** Sets all necessary cells and methods. */
+ (void) addCellsTo:(LObject*)object;
@end

/**
 Returns upcase text.
 */
@interface UpcaseMethod : LMethod {}
@end
