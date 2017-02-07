//
//  ArtworkViewModel.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 16/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
@class Artwork;

NS_ASSUME_NONNULL_BEGIN

@interface ArtworkViewModel : NSObject

@property (readonly, nonatomic) NSString *ID;

@property (readonly, nonatomic) UIImage *image;

@property (readonly, nonatomic) BOOL selected;
@property (readonly, nonatomic) BOOL matched;

- (instancetype)initWithArtwork:(Artwork *)artwork;

- (void)select;
- (void)deselect;
- (void)match;

NS_ASSUME_NONNULL_END

@end
