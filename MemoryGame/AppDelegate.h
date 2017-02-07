//
//  AppDelegate.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Application;

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic, nullable) UIWindow *window;
@property (readonly, nonatomic) Application *application;

NS_ASSUME_NONNULL_END

@end

