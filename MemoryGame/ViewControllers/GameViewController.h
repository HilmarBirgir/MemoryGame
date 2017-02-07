//
//  GameViewController.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GameViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (readonly, nonatomic) GameViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *numberOfMovesLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *youWinView;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;

- (instancetype)initWithViewModel:(GameViewModel *)viewModel;

NS_ASSUME_NONNULL_END

@end
