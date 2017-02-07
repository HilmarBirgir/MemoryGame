//
//  NSArrayRandomizerTests.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 20/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "NSArray+RandomizeOrder.h"

@interface NSArrayRandomizerTests : UnitTestCase


@end

@implementation NSArrayRandomizerTests

- (void)test_array_contains_same_objects_after_being_randomized
{
    NSString *first = @"1";
    NSString *second = @"2";
    NSString *third = @"3";
    
    NSArray *array = @[first, second, third];
    
    NSArray *randomizedOrderArray = [array randomizeOrder];
    
    XCTAssertEqual([array count], [randomizedOrderArray count]);
    XCTAssertTrue([randomizedOrderArray containsObject:first]);
    XCTAssertTrue([randomizedOrderArray containsObject:second]);
    XCTAssertTrue([randomizedOrderArray containsObject:third]);
}

@end
