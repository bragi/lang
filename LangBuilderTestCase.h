//
//  LangBuilderTestCase.h
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-02.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "LangBuilder.h"
#import "LangScanner.h"

@interface LangBuilderTestCase : SenTestCase {
    LangBuilder* builder;
    LangScanner* scanner;
}

@end
