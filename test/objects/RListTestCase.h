//
//  RListTestCase.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-14.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "Lang.h"

@interface RListTestCase : SenTestCase {
    Lang* lang;
    LObject* result;
}

@end
