//
//  LoadingViewModel.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NetworkingService;
@class RoutingService;

NS_ASSUME_NONNULL_BEGIN

@interface LoadingViewModel : NSObject

@property (readonly, nonatomic) CGFloat progress;

- (instancetype)initWithNetworkingService:(NetworkingService *)networkingService
                           routingService:(RoutingService *)routingService;

NS_ASSUME_NONNULL_END

@end
