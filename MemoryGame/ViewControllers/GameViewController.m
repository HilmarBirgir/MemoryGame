//
//  GameViewController.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "GameViewController.h"

#import "ArtworkCollectionViewCell.h"
#import "UINib+Class.h"
#import "ConfettiLayer.h"
#import "Constants.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface GameViewController ()

@property (readwrite, nonatomic) GameViewModel *viewModel;

@end

@implementation GameViewController

- (instancetype)initWithViewModel:(GameViewModel *)viewModel
{
    self = [super init];
    
    if (self)
    {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self bindObservers];
    [self setupCollectionView];
    [self setupYouWinView];
}

- (void)bindObservers
{
    @weakify(self);
    RAC(self.collectionView, userInteractionEnabled) = RACObserve(self.viewModel, canFlip);
    [[RACObserve(self.viewModel, youWin) ignore:@NO] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self startYouWinAnimation];
    }];
    RAC(self.numberOfMovesLabel, text) = RACObserve(self.viewModel, numberOfMovesString);
}

- (void)setupCollectionView
{
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibFromClass:[ArtworkCollectionViewCell class]] forCellWithReuseIdentifier:ARTWORK_CELL_REUSE_IDENTIFIER];
}

- (void)setupYouWinView
{
    self.youWinView.alpha = 0;
}

- (void)startYouWinAnimation
{
    self.highScoreLabel.hidden = self.viewModel.highScore == NO;
    
    [UIView animateWithDuration:0.5
                          delay:0.5
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.youWinView.alpha = 1;
    } completion:^(BOOL finished) {
        [self showConfetti];
    }];
}

- (void)showConfetti
{
    ConfettiLayer *confetti = [[ConfettiLayer alloc] initWithFrame:self.view.bounds];
    [self.youWinView addSubview:confetti];
}

- (IBAction)close:(id)sender
{
    [self.viewModel close];
}

- (IBAction)backToMenu:(id)sender
{
    [self.viewModel close];
}

# pragma mark - UICollectionViewDataSource 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
{
    return [self.viewModel.cellViewModels count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    ArtworkViewModel *viewModel = self.viewModel.cellViewModels[indexPath.row];
    ArtworkCollectionViewCell *cell = (ArtworkCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ARTWORK_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    cell.viewModel = viewModel;
    
    return cell;
}

# pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel didSelectAtIndex:indexPath.row];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat margin = 20;
    
    CGFloat width = (self.collectionView.frame.size.width - margin) / NUMBER_OF_MEMORY_CELLS_IN_LINE;
    CGFloat height = (self.collectionView.frame.size.height - margin) / NUMBER_OF_MEMORY_CELLS_IN_LINE;
    
    return CGSizeMake(width, height);
}

@end
