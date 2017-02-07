//
//  LoadingViewController.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "LoadingViewController.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface LoadingViewController ()

@property (readwrite, nonatomic) LoadingViewModel *viewModel;

@end

@implementation LoadingViewController

- (instancetype)initWithViewModel:(LoadingViewModel *)viewModel
{
    self = [super init];
    
    if (self)
    {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self bindObservers];
}

- (void)bindObservers
{
    @weakify(self);
    [RACObserve(self.viewModel, progress) subscribeNext:^(NSNumber *progress) {
        @strongify(self);
        self.loadingBarWidthConstant.constant = self.loadingBarFill.frame.size.width * [progress floatValue];
        [self.view layoutIfNeeded];
    }];
}

@end
