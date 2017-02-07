//
//  NSArray+RandomizeOrder.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 16/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "NSArray+RandomizeOrder.h"

@implementation NSArray (RandomizeOrder)

- (NSArray *)randomizeOrder
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    
    NSUInteger count = [array count];
    
    for (NSUInteger i = 0; i < count; ++i)
    {
        NSInteger elements = count - i;
        NSInteger n = (arc4random() % elements) + i;
        [array exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return array;
}

@end
