//
//  Application+Singletons.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Application.h"

@class RoutingService;
@class NetworkingService;

NS_ASSUME_NONNULL_BEGIN

@interface Application (Singletons)

+ (RoutingService *)sharedRoutingService;
+ (NetworkingService *)sharedNetworkingService;
+ (ScoreKeeperService *)sharedScoreKeeperService;

NS_ASSUME_NONNULL_END

@end
