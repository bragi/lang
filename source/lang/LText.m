//
//  LText.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-27.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LText.h"


@implementation LText

@synthesize text;

+ (id) buildWithAncestor:(LObject*)ancestor
{
    LText* theText = [[LText alloc] initWithString:@""];
    [theText addAncestor:ancestor];
    return theText;
}

- (id) initWithString:(NSString*)newText
{
    self = [super init];
    text = newText;
    return self;
}


// TODO: rethink the whole deal with mimicking text

- (LObject*) mimic
{
    LObject* mimic = [[LText alloc] initWithString:self.text];
    [mimic addAncestor:self];
    return mimic;
}

- (LText*) mimicWithString:(NSString*)newText
{
    LText* mimic = [[LText alloc] initWithString:newText];
    [mimic addAncestor:self];
    return mimic;
}

- (LText*) upcaseWithExecution:(LExecution*)execution
{
    return [self mimicWithString:[self.text uppercaseString]];
}

@end
