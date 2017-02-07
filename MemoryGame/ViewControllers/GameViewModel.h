//
//  GameViewModel.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Artwork;
@class ArtworkViewModel;
@class RoutingService;
@class ScoreKeeperService;

NS_ASSUME_NONNULL_BEGIN

@interface GameViewModel : NSObject

@property (readonly, nonatomic) NSArray<ArtworkViewModel *> *cellViewModels;

@property (readonly, nonatomic) BOOL canFlip;
@property (readonly, nonatomic) BOOL youWin;
@property (readonly, nonatomic) BOOL highScore;

@property (readonly, nonatomic) NSString *numberOfMovesString;

- (instancetype)initWithArtworks:(NSArray<Artwork *> *)artworks;

- (instancetype)initWithArtworks:(NSArray<Artwork *> *)artworks
                  routingService:(RoutingService *)routingService
              scoreKeeperService:(ScoreKeeperService *)scoreKeeperService;

- (void)didSelectAtIndex:(NSInteger)index;
- (void)close;

NS_ASSUME_NONNULL_END

@end
