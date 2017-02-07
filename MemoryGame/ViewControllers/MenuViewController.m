//
//  MenuViewController.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@property (readwrite, nonatomic) MenuViewModel *viewModel;

@end

@implementation MenuViewController

- (instancetype)initWithViewModel:(MenuViewModel *)viewModel
{
    self = [super init];
    
    if (self)
    {
        self.viewModel = viewModel;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setupLabels];
}

- (void)setupLabels
{
    self.highScoreLabel.text = [self.viewModel highScoreString];
}

- (IBAction)startNewGame:(id)sender
{
    [self.viewModel startNewGame];
}

@end
