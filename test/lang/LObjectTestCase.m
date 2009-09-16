//
//  LObjectTestCase.m
//  lang-objective-c
//
//  Created by Łukasz Piestrzeniewicz on 09-08-18.
//  Copyright 2009 Ragnarson. All rights reserved.
//

#import "LObjectTestCase.h"


@implementation LObjectTestCase
- (void)setUp
{
    object = [[[LObject alloc] init] retain];
    ancestor = [[[LObject alloc] init] retain];
    olderAncestor = [[[LObject alloc] init] retain];
    cell = [[[LObject alloc] init] retain];
    anotherCell = [[[LObject alloc] init] retain];
}

- (void)tearDown
{
    [object release];
    [ancestor release];
    [olderAncestor release];
    [cell release];
    [anotherCell release];
}

- (void)testSetCell
{
    [object setCell: cell withName: @"cell"];
}

- (void)testGetDirectCell
{
    [object setCell:cell withName: @"cell"];
    STAssertEqualObjects([object cellForName: @"cell"], cell, @"got no cell");
}

- (void)testGetNoCell
{
    STAssertNil([object cellForName:@"cell"], @"cell is not nil");
}

- (void)testAddAncestor
{
    [object addAncestor:ancestor];
}

- (void)testLookupInAncestor
{
    [ancestor setCell:cell withName:@"cell"];
    [object addAncestor:ancestor];
    STAssertEqualObjects([object cellForName:@"cell"], cell, @"got no cell in ancestor");
}

- (void)testPreferYoungerAncestor
{
    [olderAncestor setCell:anotherCell withName:@"cell"];
    [ancestor setCell:cell withName:@"cell"];
    [object addAncestor:olderAncestor];
    [object addAncestor:ancestor];
    STAssertEqualObjects([object cellForName:@"cell"], cell, @"got no cell in ancestor");
}

@end
