//
//  RNil.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-07.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "LRuntime.h"
#import "LObject.h"

@interface RNil : NSObject {}

+ (void) addCellsTo:(LObject*)object inRuntime:(LRuntime*)runtime;

@end
