//
//  MenuViewModel.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "MenuViewModel.h"

#import "Application+Singletons.h"
#import "RoutingService.h"
#import "ScoreKeeperService.h"

@interface MenuViewModel ()

@property (readwrite, nonatomic) RoutingService *routingService;
@property (readwrite, nonatomic) ScoreKeeperService *scoreKeeperService;

@end

@implementation MenuViewModel

- (instancetype)init
{
    return [self initWithRoutingService:[Application sharedRoutingService]
                     scoreKeeperService:[Application sharedScoreKeeperService]];
}

- (instancetype)initWithRoutingService:(RoutingService *)routingService
                    scoreKeeperService:(ScoreKeeperService *)scoreKeeperService
{
    self = [super init];
    
    if (self)
    {
        self.routingService = routingService;
        self.scoreKeeperService = scoreKeeperService;
    }
    
    return self;
}

- (NSString *)highScoreString
{
    NSInteger highScore = [self.scoreKeeperService highScore];
    
    if (highScore == 0)
    {
        return @"HIGH SCORE: N/A";
    }
    else
    {
        return [NSString stringWithFormat:@"HIGH SCORE: %@", @(highScore)];
    }
}

- (void)startNewGame
{
    [self.routingService showLoadingViewController];
}

@end
