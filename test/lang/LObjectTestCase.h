//
//  LObjectTestCase.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "LObject.h"

@interface LObjectTestCase : SenTestCase {
	LObject* object;
	LObject* ancestor;
	LObject* olderAncestor;
	LObject* cell;
	LObject* anotherCell;
}

@end
