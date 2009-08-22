//
//  LRuntime.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-22.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "Message.h"

@interface LRuntime : NSObject {
	LObject* currentTarget;
	LObject* topContext;
}

@property (retain) LObject* currentTarget;
@property (retain) LObject* topContext;

- (void) run:(Message*) message;

@end
