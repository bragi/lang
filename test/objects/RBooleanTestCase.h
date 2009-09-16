//
//  RBooleanTestCase.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-09.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Lang.h"
#import "LObject.h"

@interface RBooleanTestCase : SenTestCase {
    Lang *lang;
    LObject *result;
}

@end
