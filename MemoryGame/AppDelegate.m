//
//  AppDelegate.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "AppDelegate.h"

#import "Application.h"

@interface AppDelegate ()

@property (readwrite, nonatomic) Application *application;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.application = [Application new];
    [self.application setup];
    
    return YES;
}

- (UIWindow *)window
{
    return [self.application window];
}

@end
