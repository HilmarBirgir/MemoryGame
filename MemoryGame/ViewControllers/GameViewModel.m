//
//  GameViewModel.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "GameViewModel.h"

#import "Application+Singletons.h"
#import "RoutingService.h"
#import "ScoreKeeperService.h"
#import "ArtworkViewModel.h"
#import "NSArray+RandomizeOrder.h"
#import "Artwork.h"
#import "RACSignal+Delay.h"
#import "Constants.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <UIKit/UIKit.h>

@interface GameViewModel ()

@property (readwrite, nonatomic) RoutingService *routingService;
@property (readwrite, nonatomic) ScoreKeeperService *scoreKeeperService;
@property (readwrite, nonatomic) NSArray<Artwork *> *artworks;

@property (readwrite, nonatomic) NSArray<ArtworkViewModel *> *cellViewModels;
@property (readwrite, nonatomic) ArtworkViewModel *selectedArtworkViewModel;

@property (readwrite, nonatomic) NSInteger numberOfMoves;
@property (readwrite, nonatomic) NSInteger numberOfMatches;

@property (readwrite, nonatomic) NSString *numberOfMovesString;

@property (readwrite, nonatomic) BOOL canFlip;
@property (readwrite, nonatomic) BOOL youWin;
@property (readwrite, nonatomic) BOOL highScore;

@end

@implementation GameViewModel

- (instancetype)initWithArtworks:(NSArray<Artwork *> *)artworks
{
    return [self initWithArtworks:artworks
                   routingService:[Application sharedRoutingService]
               scoreKeeperService:[Application sharedScoreKeeperService]];
}

- (instancetype)initWithArtworks:(NSArray<Artwork *> *)artworks
                  routingService:(RoutingService *)routingService
              scoreKeeperService:(ScoreKeeperService *)scoreKeeperService
{
    self = [super init];
    
    if (self)
    {
        self.artworks = artworks;
        self.routingService = routingService;
        self.scoreKeeperService = scoreKeeperService;
        
        [self setup];
        [self bindObservers];
    }
    
    return self;
}

- (void)setup
{
    self.cellViewModels = [self buildCellViewModels:self.artworks];
    self.numberOfMoves = 0;
    self.numberOfMatches = 0;
    self.canFlip = YES;
}

- (void)bindObservers
{
    @weakify(self);
    RAC(self, youWin) = [[RACObserve(self, numberOfMatches) map:^id _Nullable(NSNumber *numberOfMatches) {
        return @(numberOfMatches.integerValue == NUMBER_OF_PAIRS);
    }] doNext:^(NSNumber *youWin) {
        @strongify(self);
        [self updateHighScore:[youWin boolValue]];
    }];
    
    RAC(self, numberOfMovesString) = [RACObserve(self, numberOfMoves) map:^id _Nullable(NSString *numberOfMoves) {
        return [NSString stringWithFormat:@"Number of moves: %@", numberOfMoves];
    }];
}

- (void)updateHighScore:(BOOL)youWin
{
    if (youWin)
    {
        NSInteger highScore = [self.scoreKeeperService highScore];
        
        if (self.numberOfMoves < highScore || highScore == 0)
        {
            self.highScore = YES;
            [self.scoreKeeperService gameWonWithHighScore:self.numberOfMoves];
        }
    }
}

- (NSArray<ArtworkViewModel *> *)buildCellViewModels:(NSArray<Artwork *> *)artworks
{
    // We need 2 viewmodels for each artwork.
    
    NSMutableArray *viewModels = [NSMutableArray new];
    
    NSInteger index = 0;
    
    for (NSInteger i = 0; i < [artworks count] * 2; i++)
    {
        Artwork *artwork = artworks[index];
        ArtworkViewModel *viewModel = [[ArtworkViewModel alloc] initWithArtwork:artwork];
        [viewModels addObject:viewModel];
        
        if (i % 2 != 0)
        {
            index++;
        }
    }
    
    return [viewModels randomizeOrder];
}

- (void)didSelectAtIndex:(NSInteger)index
{
    ArtworkViewModel *selectedArtworkViewModel = self.cellViewModels[index];
    
    if (selectedArtworkViewModel.selected)
    {
        return;
    }
    else
    {
        self.numberOfMoves++;
    }
    
    [selectedArtworkViewModel select];
    
    if ([self.selectedArtworkViewModel.ID isEqualToString:selectedArtworkViewModel.ID])
    {
        [self matchArtworkViewModel:selectedArtworkViewModel];
    }
    else
    {
        if (self.selectedArtworkViewModel)
        {
            [self tempDisableFlippingAndDeselectArtworkViewModel:selectedArtworkViewModel];
        }
        else
        {
            self.selectedArtworkViewModel = selectedArtworkViewModel;
        }
    }
}

- (void)matchArtworkViewModel:(ArtworkViewModel *)viewModel
{
    self.numberOfMatches++;
    [viewModel match];
    [self.selectedArtworkViewModel match];
    self.selectedArtworkViewModel = nil;
}

- (void)tempDisableFlippingAndDeselectArtworkViewModel:(ArtworkViewModel *)viewModel
{
    self.canFlip = NO;
    
    @weakify(self);
    [RACSignal delay:1 thenDo:^{
        @strongify(self);
        [viewModel deselect];
        [self.selectedArtworkViewModel deselect];
        self.selectedArtworkViewModel = nil;
        self.canFlip = YES;
    }];
}

- (void)close
{
    [self.routingService goBack];
}

@end
