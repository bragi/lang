//
//  LangObject.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LangObject : NSObject {
	NSMutableDictionary* cells;
	NSMutableArray* ancestors;
}

- (id) init;
- (void) dealloc;

- (void) setCell: (LangObject*)object withName: (NSString*)name;
- (LangObject*) cellForName: (NSString *)name;

- (void) addAncestor: (LangObject*)ancestor;
@end
