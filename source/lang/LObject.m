//
//  LObject.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LObject.h"
#import "LMessage.h"
#import "LExecution.h"
#import "LRuntime.h"

@implementation LObject

+ (id)build
{
    return [[LObject alloc] init];
}

+ (id)objectWithAncestor:(LObject*)ancestor
{
    LObject *object = [LObject build];
    [object addAncestor:ancestor];
    return object;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        cells = [NSMutableDictionary dictionary];
        ancestors = [NSMutableArray array];
    }
    return self;
}

- (void)setCell:(LObject*)object withName:(NSString*)name
{
    [cells setValue: object forKey: name];
}

- (LObject*)cellForName:(NSString*)name
{
    LObject *cell = [cells valueForKey:name];
    if (cell) return cell;
    LObject *ancestor;
    for(ancestor in [ancestors reverseObjectEnumerator])
    {
        cell = [ancestor cellForName:name];
        if (cell) return cell;
    }
    return nil;
}

- (void)addAncestor:(LObject*)ancestor
{
    [ancestors addObject:ancestor];
}

- (LObject*)activate:(LExecution*)execution
{
    // Normal objects do not have to do anything when activated, they just 'are'.
    return self;
}

- (LObject*)send:(LExecution*)execution
{
    LMessage *message = execution.message;
    NSString *name = [message name];
    LObject *cell = [self cellForName:name];
    if (cell == nil) {
        @throw [NSException exceptionWithName:@"Cell not found" reason:[NSString stringWithFormat:@"Could not find cell with name %@ on %@", name, self] userInfo:nil];
    }
    LObject *result = [cell activate:execution];
    // NSLog(@"%@ received %@, returns %@", [cell kind], [message stringValueWithoutNested], [result kind]);
    
    return result;
}

- (LObject*)assignmentWithExecution:(LExecution*)execution
{
    // TODO: validate number of arguments
    NSArray *arguments = [[execution message] arguments];
    NSString *name = [(LMessage*)[arguments objectAtIndex:0] name];
    LObject *value = [execution evaluateWithCurrentContext:[arguments objectAtIndex:1]];
    [self setCell:value withName:name];
    // Check if name starts with uppercase
    if ([name rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location == 0) {
        [value setCell:[execution.runtime makeTextWithString:name] withName:@"kind"];
    }
    
    return value;
}

- (LObject*)newWithExecution:(LExecution*)execution
{
    return [LObject objectWithAncestor:self];
}

- (LObject*)toTextWithExecution:(LExecution*)execution
{
    return [execution.runtime makeTextWithString:[NSString stringWithFormat:@"%@", self]];
}

- (LObject*)cellWithExecution:(LExecution*)execution
{
    NSString *name = [(LText*)[execution evaluatedArgumentAtIndex:0] text];
    return [self cellForName:name];
}

- (LObject*)isEqualWithExecution:(LExecution*)execution
{
    LObject *other = [execution evaluatedArgumentAtIndex:0];
    return [self isEqual:other] ? execution.runtime.theTrue : execution.runtime.theFalse;
}

- (void)logInternals
{
    [self logInternalsWithIndentation:@""];
}

- (void)logInternalsWithIndentation:(NSString*)indentation
{
    NSLog(@"%@Class: %@", indentation, [self class]);
    NSLog(@"%@Kind: %@", indentation, [self kind]);
    [self logClassSpecificInternalsWithIndentation:indentation];
    NSLog(@"%@Cells:", indentation);
    for (NSString *name in [cells keyEnumerator]) {
        NSLog(@"%@  %@", indentation, name);
    }
    NSLog(@"%@Ancestors:", indentation);
    for (LObject *ancestor in ancestors) {
        NSLog(@"%@  %@", indentation, [ancestor kind]);
    }
}

- (void)logClassSpecificInternalsWithIndentation:(NSString*)indentation
{
    
}

- (NSString *)kind
{
    LObject *kindCell = [self cellForName:@"kind"];
    if (kindCell && [kindCell isKindOfClass:[LText class]]) {
        return [(LText*)kindCell text];
    }
    return [NSString stringWithFormat:@"Unknown %@", [kindCell class]];
}

- (NSString *)inspect
{
    return [NSString stringWithFormat:@"<%@(%@)>", [self kind], [self class]];
}

@end

