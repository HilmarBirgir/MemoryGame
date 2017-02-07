//
//  RoutingService.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "RoutingService.h"

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "MenuViewController.h"
#import "LoadingViewController.h"
#import "GameViewController.h"

@interface RoutingService()

@property (readwrite, nonatomic, nullable) UINavigationController *navigationController;
@property (readwrite, nonatomic, nullable) UIWindow *window;

@end

@implementation RoutingService

- (void)setupAndShowMenuViewController
{
    MenuViewModel *viewModel = [MenuViewModel new];
    MenuViewController *viewController = [[MenuViewController alloc] initWithViewModel:viewModel];
    
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.navigationController setNavigationBarHidden:YES];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = self.navigationController;
}

- (void)showLoadingViewController
{
    LoadingViewModel *viewModel = [LoadingViewModel new];
    LoadingViewController *viewController = [[LoadingViewController alloc] initWithViewModel:viewModel];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)showGameViewController:(NSArray<Artwork *> *)artworks
{
    GameViewModel *viewModel = [[GameViewModel alloc] initWithArtworks:artworks];
    GameViewController *viewController = [[GameViewController alloc] initWithViewModel:viewModel];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)goBack
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (RACSignal *)showErrorAlertWithMessage:(NSString *)message
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [subscriber sendNext:nil];
                                                       [subscriber sendCompleted];
                                                   }];
        
        [alertController addAction:ok];
        
        [self.navigationController presentViewController:alertController
                                                animated:YES
                                              completion:nil];
        
        return [RACDisposable disposableWithBlock:^{
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        
    }];
}

@end
