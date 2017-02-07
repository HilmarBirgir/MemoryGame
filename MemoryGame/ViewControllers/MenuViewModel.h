//
//  MenuViewModel.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoutingService;
@class ScoreKeeperService;

NS_ASSUME_NONNULL_BEGIN

@interface MenuViewModel : NSObject

- (instancetype)initWithRoutingService:(RoutingService *)routingService
                    scoreKeeperService:(ScoreKeeperService *)scoreKeeperService;

- (void)startNewGame;
- (NSString *)highScoreString;

NS_ASSUME_NONNULL_END

@end
