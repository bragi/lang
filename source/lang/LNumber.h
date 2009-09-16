//
//  LNumber.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"

@interface LNumber : LObject {
    NSDecimalNumber *number;
}

@property (readonly) NSDecimalNumber *number;

+ (id)numberWithAncestor:(LObject*)ancestor string:(NSString*)string;
+ (id)numberWithAncestor:(LObject*)ancestor integer:(NSInteger)integer;

- (id)initWithString:(NSString*)string;
- (id)initWithInteger:(NSInteger)integer;

@end
