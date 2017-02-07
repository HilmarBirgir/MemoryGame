//
//  ArtworkCollectionViewCell.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "ArtworkCollectionViewCell.h"

#import <ReactiveObjC/ReactiveObjC.h>

NSString *const ARTWORK_CELL_REUSE_IDENTIFIER = @"artworkCell";

@implementation ArtworkCollectionViewCell

@synthesize viewModel = _viewModel;

- (void)setViewModel:(ArtworkViewModel *)viewModel
{
    _viewModel = viewModel;
    
    self.imageView.image = viewModel.image;
    [self bindObservers];
}

- (ArtworkViewModel *)viewModel
{
    return _viewModel;
}

- (void)bindObservers
{
    [RACObserve(self.viewModel, selected) subscribeNext:^(NSNumber *selected) {
        if ([selected boolValue])
        {
            [UIView transitionWithView:self
                              duration:0.65f
                               options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                                   self.cover.hidden = YES;
                                   self.imageView.hidden = NO;
                               } completion:nil];
        }
        else
        {
            [UIView transitionWithView:self
                              duration:0.65f
                               options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                                   self.cover.hidden = NO;
                                   self.imageView.hidden = YES;
                               } completion:nil];
        }
    }];
}

@end
