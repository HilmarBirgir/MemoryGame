//
//  GameViewModelTests.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 19/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "GameViewModel.h"
#import "Artwork.h"
#import "ArtworkViewModel.h"
#import "RACSignal+Delay.h"
#import "Blocks.h"
#import "RoutingService.h" 
#import "ScoreKeeperService.h"

@interface GameViewModel (Testing)

@property (readwrite, nonatomic) NSArray<ArtworkViewModel *> *cellViewModels;

@end

@interface GameViewModelTests : UnitTestCase

@property (readwrite, nonatomic) GameViewModel *viewModel;

@end

@implementation GameViewModelTests

- (void)setUp
{
    [super setUp];
    
    UIImage *image = [UIImage new];
    
    Artwork *artwork1 = [[Artwork alloc] initWithID:@"http://a.com" image:image];
    Artwork *artwork2 = [[Artwork alloc] initWithID:@"http://b.com" image:image];
    Artwork *artwork3 = [[Artwork alloc] initWithID:@"http://c.com" image:image];
    Artwork *artwork4 = [[Artwork alloc] initWithID:@"http://d.com" image:image];
    Artwork *artwork5 = [[Artwork alloc] initWithID:@"http://e.com" image:image];
    Artwork *artwork6 = [[Artwork alloc] initWithID:@"http://f.com" image:image];
    Artwork *artwork7 = [[Artwork alloc] initWithID:@"http://g.com" image:image];
    Artwork *artwork8 = [[Artwork alloc] initWithID:@"http://h.com" image:image];
    
    NSArray *artworks = @[artwork1, artwork2, artwork3, artwork4, artwork5, artwork6, artwork7, artwork8];
    
    self.viewModel = [[GameViewModel alloc] initWithArtworks:artworks
                                              routingService:self.mockRoutingService
                                          scoreKeeperService:self.mockScoreKeeperService];
}

- (void)useCheatViewModels
{
    // In some tests we want to know the order of the cell view models
    
    NSArray *sortedCellViewModels = [self.viewModel.cellViewModels sortedArrayUsingComparator:^NSComparisonResult(ArtworkViewModel *obj1, ArtworkViewModel *obj2) {
        return [obj1.ID compare:obj2.ID options:NSNumericSearch];
    }];
    
    self.viewModel.cellViewModels = sortedCellViewModels;
}

- (void)test_we_build_correct_number_of_cell_view_models
{
    XCTAssertEqual([self.viewModel.cellViewModels count], 16);
}

- (void)test_number_of_moves_string_updates_correctly
{
    XCTAssertEqualObjects(self.viewModel.numberOfMovesString, @"Number of moves: 0");

    [self.viewModel didSelectAtIndex:2];

    XCTAssertEqualObjects(self.viewModel.numberOfMovesString, @"Number of moves: 1");
}

- (void)test_number_of_moves_string_does_not_update_when_selecting_an_already_selected_card
{
    XCTAssertEqualObjects(self.viewModel.numberOfMovesString, @"Number of moves: 0");
    
    [self.viewModel didSelectAtIndex:2];
    
    XCTAssertEqualObjects(self.viewModel.numberOfMovesString, @"Number of moves: 1");
    
    [self.viewModel didSelectAtIndex:2];

    XCTAssertEqualObjects(self.viewModel.numberOfMovesString, @"Number of moves: 1");
}

- (void)test_cell_view_models_get_matched_if_we_match
{
    [self useCheatViewModels];
    
    ArtworkViewModel *viewModel1 = self.viewModel.cellViewModels[0];
    ArtworkViewModel *viewModel2 = self.viewModel.cellViewModels[1];
    
    XCTAssertEqual(viewModel1.matched, NO);
    XCTAssertEqual(viewModel2.matched, NO);
    
    [self.viewModel didSelectAtIndex:0];
    [self.viewModel didSelectAtIndex:1];

    XCTAssertEqual(viewModel1.matched, YES);
    XCTAssertEqual(viewModel2.matched, YES);
}

- (void)test_cell_view_models_get_do_not_get_matched_if_we_do_not
{
    [self useCheatViewModels];
    
    ArtworkViewModel *viewModel1 = self.viewModel.cellViewModels[0];
    ArtworkViewModel *viewModel3 = self.viewModel.cellViewModels[2];
    
    XCTAssertEqual(viewModel1.matched, NO);
    XCTAssertEqual(viewModel3.matched, NO);
    
    [self.viewModel didSelectAtIndex:0];
    [self.viewModel didSelectAtIndex:2];
    
    XCTAssertEqual(viewModel1.matched, NO);
    XCTAssertEqual(viewModel3.matched, NO);
}

- (void)test_can_flip_gets_set_to_no_when_we_do_not_match
{
    [self useCheatViewModels];
    
    XCTAssertEqual(self.viewModel.canFlip, YES);
    
    [self.viewModel didSelectAtIndex:0];
    [self.viewModel didSelectAtIndex:2];

    XCTAssertEqual(self.viewModel.canFlip, NO);
}

- (void)test_can_flip_gets_set_back_to_yes_1_sec_after_we_do_not_match
{
    [self useCheatViewModels];

    // We mock out the delay signal so it fires immediately
    id mockSignal = [OCMockObject niceMockForClass:[RACSignal class]];
    [[[mockSignal stub] andDo:^(NSInvocation *invocation) {
        id __unsafe_unretained weakArgument = nil;
        [invocation getArgument:&weakArgument atIndex:3];
        VoidBlock completionBlock = weakArgument;
        completionBlock();
    }] delay:1 thenDo:OCMOCK_ANY];
    
    XCTAssertEqual(self.viewModel.canFlip, YES);
    
    [self.viewModel didSelectAtIndex:0];
    [self.viewModel didSelectAtIndex:2];
    
    XCTAssertEqual(self.viewModel.canFlip, YES);
}

- (void)test_you_win_gets_set_to_yes_once_we_match_8_pairs
{
    [self useCheatViewModels];

    XCTAssertEqual(self.viewModel.youWin, NO);

    [self.viewModel didSelectAtIndex:0];
    [self.viewModel didSelectAtIndex:1];
    [self.viewModel didSelectAtIndex:2];
    [self.viewModel didSelectAtIndex:3];
    [self.viewModel didSelectAtIndex:4];
    [self.viewModel didSelectAtIndex:5];
    [self.viewModel didSelectAtIndex:6];
    [self.viewModel didSelectAtIndex:7];
    [self.viewModel didSelectAtIndex:8];
    [self.viewModel didSelectAtIndex:9];
    [self.viewModel didSelectAtIndex:10];
    [self.viewModel didSelectAtIndex:11];
    [self.viewModel didSelectAtIndex:12];
    [self.viewModel didSelectAtIndex:13];
    [self.viewModel didSelectAtIndex:14];
    [self.viewModel didSelectAtIndex:15];

    XCTAssertEqual(self.viewModel.youWin, YES);
}

- (void)test_high_score_gets_set_if_we_win_in_less_moves_than_previous_high_score
{
    [self useCheatViewModels];
    
    XCTAssertEqual(self.viewModel.highScore, NO);
    
    [(ScoreKeeperService *)[[self.mockScoreKeeperService stub] andReturnValue:OCMOCK_VALUE((NSInteger) { 100 })] highScore];
    
    [[self.mockScoreKeeperService expect] gameWonWithHighScore:16];
    
    [self.viewModel didSelectAtIndex:0];
    [self.viewModel didSelectAtIndex:1];
    [self.viewModel didSelectAtIndex:2];
    [self.viewModel didSelectAtIndex:3];
    [self.viewModel didSelectAtIndex:4];
    [self.viewModel didSelectAtIndex:5];
    [self.viewModel didSelectAtIndex:6];
    [self.viewModel didSelectAtIndex:7];
    [self.viewModel didSelectAtIndex:8];
    [self.viewModel didSelectAtIndex:9];
    [self.viewModel didSelectAtIndex:10];
    [self.viewModel didSelectAtIndex:11];
    [self.viewModel didSelectAtIndex:12];
    [self.viewModel didSelectAtIndex:13];
    [self.viewModel didSelectAtIndex:14];
    [self.viewModel didSelectAtIndex:15];
    
    [self.mockScoreKeeperService verify];
    
    XCTAssertEqual(self.viewModel.highScore, YES);
}

- (void)test_high_score_does_not_get_set_if_we_win_in_more_moves_than_previous_high_score
{
    [self useCheatViewModels];
    
    XCTAssertEqual(self.viewModel.highScore, NO);
    
    [(ScoreKeeperService *)[[self.mockScoreKeeperService stub] andReturnValue:OCMOCK_VALUE((NSInteger) { 10 })] highScore];
    
    [[self.mockScoreKeeperService reject] gameWonWithHighScore:16];
    
    [self.viewModel didSelectAtIndex:0];
    [self.viewModel didSelectAtIndex:1];
    [self.viewModel didSelectAtIndex:2];
    [self.viewModel didSelectAtIndex:3];
    [self.viewModel didSelectAtIndex:4];
    [self.viewModel didSelectAtIndex:5];
    [self.viewModel didSelectAtIndex:6];
    [self.viewModel didSelectAtIndex:7];
    [self.viewModel didSelectAtIndex:8];
    [self.viewModel didSelectAtIndex:9];
    [self.viewModel didSelectAtIndex:10];
    [self.viewModel didSelectAtIndex:11];
    [self.viewModel didSelectAtIndex:12];
    [self.viewModel didSelectAtIndex:13];
    [self.viewModel didSelectAtIndex:14];
    [self.viewModel didSelectAtIndex:15];
    
    [self.mockScoreKeeperService verify];
    
    XCTAssertEqual(self.viewModel.highScore, NO);
}

- (void)test_close_goes_back_on_router
{
    [self.mockRoutingService goBack];
    
    [self.viewModel close];
    
    [self.mockRoutingService verify];
}

@end
