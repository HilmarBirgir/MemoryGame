//
//  MenuViewController.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MenuViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuViewController : UIViewController

@property (readonly, nonatomic) MenuViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;

- (instancetype)initWithViewModel:(MenuViewModel *)viewModel;

NS_ASSUME_NONNULL_END

@end
