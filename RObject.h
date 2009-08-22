//
//  RObject.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LMethod.h"

/*
 Represents Lang Object, the most basic datatype.
 */
@interface RObject : LObject {
}

+ (RObject*) build;
@end

/*
 Returns the receiver.
 */
@interface SelfMethod : LMethod {}
@end
