//
//  LList.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LNumber.h"

@interface LList : LObject {
    NSMutableArray* list;
}

@property (readonly) NSMutableArray* list;

+ (id) listWithAncestor:(LObject*)ancestor entries:(NSMutableArray*)entries;
- (id) initWithEntries:(NSMutableArray*)entries;

// Messages forwarded by runtime execution.

/** Return length of the list. */
- (LNumber*) lengthWithExecution:(LExecution*)execution;
@end
