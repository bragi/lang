//
//  LFrame.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-21.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LObject.h"
#import "Message.h"

@interface LFrame : NSObject {
	LObject* target;
	LObject* context;
	Message* message;
}

@property (retain) LObject* target;
@property (retain) LObject* context;
@property (retain) Message* message;

- (id) initWithTarget:(LObject*)target context:(LObject*)context andMessage:(Message*)message;

@end
