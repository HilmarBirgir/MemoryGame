//
//  RoutingService.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class Artwork;
@class UIWindow;

NS_ASSUME_NONNULL_BEGIN

@interface RoutingService : NSObject

@property (readonly, nonatomic, nullable) UIWindow *window;

- (void)setupAndShowMenuViewController;
- (void)showLoadingViewController;
- (void)showGameViewController:(NSArray<Artwork *> *)artworks;
- (void)goBack;

- (RACSignal *)showErrorAlertWithMessage:(NSString *)message;

NS_ASSUME_NONNULL_END

@end
