//
//  ArtworkViewModel.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 16/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "ArtworkViewModel.h"

#import "Artwork.h"

#import <UIKit/UIKit.h>

@interface ArtworkViewModel ()

@property (readwrite, nonatomic) NSString *ID;

@property (readwrite, nonatomic) UIImage *image;

@property (readwrite, nonatomic) BOOL selected;
@property (readwrite, nonatomic) BOOL matched;

@end

@implementation ArtworkViewModel

- (instancetype)initWithArtwork:(Artwork *)artwork
{
    self = [super init];
    
    if (self)
    {
        self.image = artwork.image;
        self.ID = artwork.ID;
    }
    
    return self;
}

- (void)select
{
    self.selected = YES;
}

- (void)deselect
{
    self.selected = NO;
}

- (void)match
{
    self.matched = YES;
}

@end
