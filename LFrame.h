//
//  LFrame.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-21.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "LMessage.h"

/*
 Represents a call frame, is given when method is called in activate. Provides access to method receiver, context in which message was sent and the message itself.
 */
@interface LFrame : NSObject {
	LObject* target;
	LObject* context;
	LMessage* message;
}

@property (retain) LObject* target;
@property (retain) LObject* context;
@property (retain) LMessage* message;

- (id) initWithTarget:(LObject*)target context:(LObject*)context andLMessage:(LMessage*)message;

@end
