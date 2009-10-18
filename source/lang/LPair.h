//
//  LPair.h
//  lang
//
//  Created by Łukasz Piestrzeniewicz on 09-10-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LExecution.h"


@interface LPair : LObject {
    LObject *key;
    LObject *value;
}

+ (LPair*)pairWithAncestor:(LObject*)ancestor key:(LObject*)key andValue:(LObject*)value;

- (id)initWithKey:(LObject*)aKey andValue:(LObject*)aValue;

/** Returns key. */
- (LObject*)keyWithExecution:(LExecution*)execution;

/** Returns value. */
- (LObject*)valueWithExecution:(LExecution*)execution;

@end
