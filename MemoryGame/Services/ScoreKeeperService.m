//
//  ScoreKeeperService.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 18/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "ScoreKeeperService.h"

NSString *const HIGH_SCORE_KEY = @"ScoreKeeperService:highScore";

@interface ScoreKeeperService ()

@property (readwrite, nonatomic) NSUserDefaults *storage;

@end

@implementation ScoreKeeperService

- (instancetype)init
{
    return [self initWithStorage:[NSUserDefaults standardUserDefaults]];
}

- (instancetype)initWithStorage:(NSUserDefaults *)storage
{
    self = [super init];
    
    if (self)
    {
        self.storage = storage;
    }
    
    return self;
}

- (NSInteger)highScore
{
    return [self.storage integerForKey:HIGH_SCORE_KEY];
}

- (void)gameWonWithHighScore:(NSInteger)highScore
{
    [self.storage setInteger:highScore forKey:HIGH_SCORE_KEY];
    [self.storage synchronize];
}

@end
