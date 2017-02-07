//
//  ArtworkCollectionViewCell.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ArtworkViewModel.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString *const ARTWORK_CELL_REUSE_IDENTIFIER;

@interface ArtworkCollectionViewCell : UICollectionViewCell

@property (readwrite, nonatomic, nullable) ArtworkViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *cover;

NS_ASSUME_NONNULL_END

@end
