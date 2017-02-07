//
//  Application+Singletons.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "Application+Singletons.h"

#import "AppDelegate.h"

#import "RoutingService.h"
#import "NetworkingService.h"
#import "ScoreKeeperService.h"

@implementation Application (Singletons)

+ (Application *)sharedInstance
{
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    return appDelegate.application;
}

+ (RoutingService *)sharedRoutingService
{
    return [self sharedInstance].routingService;
}

+ (NetworkingService *)sharedNetworkingService
{
    return [self sharedInstance].networkingService;
}

+ (ScoreKeeperService *)sharedScoreKeeperService
{
    return [self sharedInstance].scoreKeeperService;
}

@end
