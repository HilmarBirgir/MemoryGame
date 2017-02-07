//
//  ScoreKeeperServiceTests.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 19/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "ScoreKeeperService.h"

@interface ScoreKeeperServiceTests : UnitTestCase

@property (readwrite, nonatomic) ScoreKeeperService *service;
@property (readwrite, nonatomic) id mockStorage;

@end

@implementation ScoreKeeperServiceTests

- (void)setUp
{
    [super setUp];

    self.mockStorage = [OCMockObject niceMockForClass:[NSUserDefaults class]];
    
    self.service = [[ScoreKeeperService alloc] initWithStorage:self.mockStorage];
}

- (void)test_high_score_gets_read_from_storage
{
    [[self.mockStorage expect] integerForKey:@"ScoreKeeperService:highScore"];
    
    [self.service highScore];
    
    [self.mockStorage verify];
}

- (void)test_game_won_with_high_score_writes_to_storage
{
    [[self.mockStorage expect] setInteger:16 forKey:@"ScoreKeeperService:highScore"];
    [[self.mockStorage expect] synchronize];
    
    [self.service gameWonWithHighScore:16];
    
    [self.mockScoreKeeperService verify];
}

@end
