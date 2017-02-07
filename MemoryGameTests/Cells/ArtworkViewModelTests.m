//
//  ArtworkViewModelTests.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 20/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "ArtworkViewModel.h"
#import "Artwork.h"

@interface ArtworkViewModelTests : UnitTestCase

@property (readwrite, nonatomic) ArtworkViewModel *viewModel;

@property (readwrite, nonatomic) UIImage *image;

@end

@implementation ArtworkViewModelTests

- (void)setUp
{
    [super setUp];
    
    self.image = [UIImage new];
    
    Artwork *artwork = [[Artwork alloc] initWithID:@"http://a.com" image:self.image];
    
    self.viewModel = [[ArtworkViewModel alloc] initWithArtwork:artwork];
}

- (void)test_view_model_correctly_sets_up_image
{
    XCTAssertEqual(self.image, self.viewModel.image);
}

- (void)test_view_model_correctly_sets_up_id
{
    XCTAssertEqualObjects(@"http://a.com", self.viewModel.ID);
}

- (void)test_select_sets_selected_to_yes
{
    XCTAssertFalse(self.viewModel.selected);
    
    [self.viewModel select];
    
    XCTAssertTrue(self.viewModel.selected);
}

- (void)test_deselect_sets_selected_to_no
{
    [self.viewModel select];
    
    XCTAssertTrue(self.viewModel.selected);
    
    [self.viewModel deselect];
    
    XCTAssertFalse(self.viewModel.selected);
}

- (void)test_match_sets_matched_to_yes
{
    XCTAssertFalse(self.viewModel.matched);
    
    [self.viewModel match];
    
    XCTAssertTrue(self.viewModel.matched);
}

@end
