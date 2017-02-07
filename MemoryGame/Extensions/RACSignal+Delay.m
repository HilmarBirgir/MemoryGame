//
//  RACSignal+Delay.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 16/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "RACSignal+Delay.h"

@implementation RACSignal (Delay)

+ (RACSignal *)delayedSignal:(NSTimeInterval)delay
{
    RACSignal *emptySignal = [RACSignal empty];
    return [emptySignal delay:delay];
}

+ (void)delay:(NSTimeInterval)delay thenDo:(VoidBlock)completedBlock
{
    [[[self delayedSignal:delay] deliverOn:[RACScheduler currentScheduler]] subscribeCompleted:completedBlock];
}

@end
