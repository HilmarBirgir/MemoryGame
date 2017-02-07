//
//  Application.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoutingService;
@class NetworkingService;
@class ScoreKeeperService;
@class UIWindow;

NS_ASSUME_NONNULL_BEGIN

@interface Application : NSObject

@property (readonly, nonatomic) RoutingService *routingService;
@property (readonly, nonatomic) NetworkingService *networkingService;
@property (readonly, nonatomic) ScoreKeeperService *scoreKeeperService;

- (void)setup;
- (nullable UIWindow *)window;

NS_ASSUME_NONNULL_END

@end
