//
//  ArtworkTests.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 20/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "Artwork.h"

@interface ArtworkTests : UnitTestCase

@property (readwrite, nonatomic) Artwork *artwork;
@property (readwrite, nonatomic) UIImage *image;

@end

@implementation ArtworkTests

- (void)setUp
{
    [super setUp];
    
    self.image = [UIImage new];
    
    self.artwork = [[Artwork alloc] initWithID:@"http://a.com" image:self.image];
}

- (void)test_artwork_correctly_sets_up_id
{
    XCTAssertEqualObjects(@"http://a.com", self.artwork.ID);
}

- (void)test_artwork_correctly_sets_up_image
{
    XCTAssertEqual(self.image, self.artwork.image);
}

@end
