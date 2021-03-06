//
//  RMessage.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-25.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LRuntime.h"
#import "LMethod.h"

@interface RMessage : NSObject {}

/** Sets all necessary cells and methods. */
+ (void)addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime;

@end
