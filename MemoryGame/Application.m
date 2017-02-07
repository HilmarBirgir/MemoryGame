//
//  Application.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "Application.h"

#import "RoutingService.h"
#import "NetworkingService.h"
#import "ScoreKeeperService.h"

@interface Application ()

@property (readwrite, nonatomic) RoutingService *routingService;
@property (readwrite, nonatomic) NetworkingService *networkingService;
@property (readwrite, nonatomic) ScoreKeeperService *scoreKeeperService;

@end

@implementation Application

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.routingService = [RoutingService new];
        self.networkingService = [NetworkingService new];
        self.scoreKeeperService = [ScoreKeeperService new];
    }
    
    return self;
}

- (void)setup
{
    [self.routingService setupAndShowMenuViewController];
}

- (nullable UIWindow *)window
{
    return self.routingService.window;
}

@end
