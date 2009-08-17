//
//  MessageTest.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-17.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Message.h"


@interface MessageTestCase : SenTestCase {
	Message* hello;
	Message* beautiful;
	Message* world;
	Message* lady;
	Message* more;
}

@end
