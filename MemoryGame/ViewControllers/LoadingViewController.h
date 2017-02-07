//
//  LoadingViewController.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoadingViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoadingViewController : UIViewController

@property (readonly, nonatomic) LoadingViewModel *viewModel;

- (instancetype)initWithViewModel:(LoadingViewModel *)viewModel;

@property (weak, nonatomic) IBOutlet UIView *loadingBar;
@property (weak, nonatomic) IBOutlet UIView *loadingBarFill;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loadingBarWidthConstant;

NS_ASSUME_NONNULL_END

@end

