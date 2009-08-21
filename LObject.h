//
//  LObject.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LObject : NSObject {
	NSMutableDictionary* cells;
	NSMutableArray* ancestors;
}

- (id) init;
- (void) dealloc;

- (void) setCell: (LObject*)object withName: (NSString*)name;
- (LObject*) cellForName: (NSString *)name;

- (void) addAncestor: (LObject*)ancestor;
@end
