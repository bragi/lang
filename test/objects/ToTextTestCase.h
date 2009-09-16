//
//  ToTextTestCase.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-16.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "LText.h"
#import "Lang.h"

@interface ToTextTestCase : SenTestCase {
    Lang *lang;
    LText *result;
    NSString *expected;
}

@end
