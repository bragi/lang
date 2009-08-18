//
//  LangObjectTestCase.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "LangObject.h"

@interface LangObjectTestCase : SenTestCase {
	LangObject* object;
	LangObject* ancestor;
	LangObject* olderAncestor;
	LangObject* cell;
	LangObject* anotherCell;
}

@end
