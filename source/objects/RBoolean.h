//
//  RBoolean.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-23.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LRuntime.h"
#import "LObject.h"

/**
 Adds cells and methods to true instance.
 */
@interface RTrue : NSObject {}

+ (void)addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime;

@end


@interface RFalse : NSObject {}

+ (void)addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime;

@end
