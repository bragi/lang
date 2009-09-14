//
//  LNumber.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-09-13.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LNumber.h"


@implementation LNumber

@synthesize number;

+ (id) buildWithAncestor:(LObject*)ancestor
{
    LNumber* theNumber = [[LNumber alloc] initWithString:@"0"];
    [theNumber addAncestor:ancestor];
    return theNumber;
}

- (id) initWithString:(NSString*)textValue
{
    self = [super init];
    number = [NSDecimalNumber decimalNumberWithString:textValue];
    return self;
}

- (id) initWithInteger:(NSInteger)integerValue
{
    self = [super init];
    number = [NSDecimalNumber decimalNumberWithMantissa:integerValue exponent:0 isNegative:NO];
    return self;
}

- (LNumber*) mimicWithString:(NSString*)textValue
{
    LNumber* mimic = [[LNumber alloc] initWithString:textValue];
    [mimic addAncestor:self];
    return mimic;
}

- (LNumber*) mimicWithInteger:(NSInteger)integerValue
{
    LNumber* mimic = [[LNumber alloc] initWithInteger:integerValue];
    [mimic addAncestor:self];
    return mimic;
}
@end
