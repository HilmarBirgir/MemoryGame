//
//  MenuViewModelTests.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 18/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "MenuViewModel.h"
#import "ScoreKeeperService.h"
#import "RoutingService.h"

@interface MenuViewModelTests : UnitTestCase

@property (readwrite, nonatomic) MenuViewModel *viewModel;

@end

@implementation MenuViewModelTests

- (void)setUp
{
    [super setUp];
    
    self.viewModel = [[MenuViewModel alloc] initWithRoutingService:self.mockRoutingService
                                                scoreKeeperService:self.mockScoreKeeperService];
}

- (void)test_high_score_string_is_correct_if_no_high_score_has_been_set
{
    [[[self.mockScoreKeeperService stub] andReturnValue:OCMOCK_VALUE((NSInteger) { 0 })] highScore];
    
    NSString *expectedString = @"HIGH SCORE: N/A";
    NSString *string = [self.viewModel highScoreString];
    
    XCTAssertEqualObjects(expectedString, string);
}

- (void)test_high_score_string_is_correct_if_high_score_has_been_set
{
    [[[self.mockScoreKeeperService stub] andReturnValue:OCMOCK_VALUE((NSInteger) { 25 })] highScore];
    
    NSString *expectedString = @"HIGH SCORE: 25";
    NSString *string = [self.viewModel highScoreString];
    
    XCTAssertEqualObjects(expectedString, string);
}

- (void)test_start_new_game_shows_loading_view_controller
{
    [[self.mockRoutingService expect] showLoadingViewController];
    
    [self.viewModel startNewGame];
    
    [self.mockRoutingService verify];
}

@end
