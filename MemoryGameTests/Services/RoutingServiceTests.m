//
//  RoutingServiceTests.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 19/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "RoutingService.h"
#import "LoadingViewController.h"
#import "GameViewController.h"

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

// It is hard to inject those dependencies as they depend on the inital
// view controller. So we do some cheating to be able to mock them.

@interface RoutingService (Testing)

@property (readwrite, nonatomic) UINavigationController *navigationController;

@end

@interface RoutingServiceTests : UnitTestCase

@property (readwrite, nonatomic) RoutingService *service;
@property (readwrite, nonatomic) id mockNavigationController;

@end

@implementation RoutingServiceTests

- (void)setUp
{
    [super setUp];
    
    self.service = [RoutingService new];
    self.mockNavigationController = [OCMockObject niceMockForClass:[UINavigationController class]];
    self.service.navigationController = self.mockNavigationController;
}

- (void)test_show_loading_view_controller_pushes_correct_view_controller
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [[[self.mockNavigationController expect] andDo:^(NSInvocation *invocation) {
        id __unsafe_unretained weakArgument = nil;
        [invocation getArgument:&weakArgument atIndex:2];
        id viewController = weakArgument;
        XCTAssertTrue([viewController isKindOfClass:[LoadingViewController class]]);
        [expectation fulfill];
    }] pushViewController:OCMOCK_ANY
                 animated:YES];
    
    [self.service showLoadingViewController];
    
    [self.mockNavigationController verify];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_show_game_view_controller_pushes_correct_view_controller
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    [[[self.mockNavigationController expect] andDo:^(NSInvocation *invocation) {
        id __unsafe_unretained weakArgument = nil;
        [invocation getArgument:&weakArgument atIndex:2];
        id viewController = weakArgument;
        XCTAssertTrue([viewController isKindOfClass:[GameViewController class]]);
        [expectation fulfill];
    }] pushViewController:OCMOCK_ANY
                 animated:YES];
    
    [self.service showGameViewController:@[]];
    
    [self.mockNavigationController verify];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_go_back_pops_to_root_view_controller_on_navigation_controller
{
    [[self.mockNavigationController expect] popToRootViewControllerAnimated:YES];
    
    [self.service goBack];
    
    [self.mockNavigationController verify];
}

- (void)test_show_error_alert_presents_view_controller_on_navigation_controller
{
    [[self.mockNavigationController expect] presentViewController:OCMOCK_ANY
                                                         animated:YES
                                                       completion:nil];

    [[self.service showErrorAlertWithMessage:@"Test"] subscribeNext:^(id  _Nullable x) {
        
    }];
    
    [self.mockNavigationController verify];
}

- (void)test_show_error_alert_sends_next_when_user_presses_ok
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    UIAlertAction *action = [UIAlertAction new];
    
    id mockAction = [OCMockObject niceMockForClass:[UIAlertAction class]];
    [[[[mockAction stub] andDo:^(NSInvocation *invocation) {
        id __unsafe_unretained weakArgument = nil;
        [invocation getArgument:&weakArgument atIndex:4];
        void (^handler)(UIAlertAction *action) = weakArgument;
        handler(action);
    }] andReturn:action] actionWithTitle:@"Ok"
                                   style:0
                                 handler:OCMOCK_ANY];

    [[self.service showErrorAlertWithMessage:@"Test"] subscribeNext:^(id  _Nullable x) {
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

@end
