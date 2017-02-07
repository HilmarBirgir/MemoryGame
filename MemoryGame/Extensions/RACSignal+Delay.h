//
//  RACSignal+Delay.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 16/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <ReactiveObjC/ReactiveObjC.h>

#import "Blocks.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACSignal (Delay)

+ (void)delay:(NSTimeInterval)delay thenDo:(VoidBlock)completedBlock;

NS_ASSUME_NONNULL_END

@end
