//
//  ScoreKeeperService.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 18/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScoreKeeperService : NSObject

- (instancetype)initWithStorage:(NSUserDefaults *)storage;

- (NSInteger)highScore;
- (void)gameWonWithHighScore:(NSInteger)highScore;

@end

NS_ASSUME_NONNULL_END
