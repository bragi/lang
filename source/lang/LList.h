//
//  LList.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"

@interface LList : LObject {
    NSMutableArray* list;
}

@property (readonly) NSMutableArray* list;

+ (id) buildWithAncestor:(LObject*)ancestor;
- (id) initWithEntries:(NSMutableArray*)entries;

@end
