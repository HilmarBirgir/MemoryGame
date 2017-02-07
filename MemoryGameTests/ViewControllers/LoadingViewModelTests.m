//
//  LoadingViewModelTests.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 18/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "LoadingViewModel.h"
#import "RoutingService.h"
#import "NetworkingService.h"
#import "Artwork.h"
#import "Constants.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface LoadingViewModelTests : UnitTestCase

@property (readwrite, nonatomic) LoadingViewModel *viewModel;

@property (readwrite, nonatomic) RACSubject *trackDataSignal;
@property (readwrite, nonatomic) RACSubject *imageSignal;

@end

@implementation LoadingViewModelTests

- (void)setUp
{
    [super setUp];
    
    self.trackDataSignal = [RACSubject subject];
    self.imageSignal = [RACSubject subject];
    
    [[[self.mockNetworkingService stub] andReturn:self.trackDataSignal] getJsonFromPath:OCMOCK_ANY];
    
    [[[self.mockNetworkingService stub] andReturn:self.imageSignal] downloadImageFromPath:OCMOCK_ANY];

    self.viewModel = [[LoadingViewModel alloc] initWithNetworkingService:self.mockNetworkingService
                                                          routingService:self.mockRoutingService];
}

- (void)test_if_api_returns_track_data_and_image_downloads_are_successful_we_go_to_the_game_view_controller_on_routing_serivice
{
    UIImage *image = [UIImage new];

    Artwork *artwork1 = [[Artwork alloc] initWithID:@"http://a.com" image:image];
    Artwork *artwork2 = [[Artwork alloc] initWithID:@"http://b.com" image:image];
    Artwork *artwork3 = [[Artwork alloc] initWithID:@"http://c.com" image:image];
    Artwork *artwork4 = [[Artwork alloc] initWithID:@"http://d.com" image:image];
    Artwork *artwork5 = [[Artwork alloc] initWithID:@"http://e.com" image:image];
    Artwork *artwork6 = [[Artwork alloc] initWithID:@"http://f.com" image:image];
    Artwork *artwork7 = [[Artwork alloc] initWithID:@"http://g.com" image:image];
    Artwork *artwork8 = [[Artwork alloc] initWithID:@"http://h.com" image:image];
    
    NSArray *artworks = @[artwork1, artwork2, artwork3, artwork4, artwork5, artwork6, artwork7, artwork8];
    
    [[self.mockRoutingService expect] showGameViewController:artworks];
    
    NSArray *trackData = @[@{@"artwork_url": @"http://a.com"},
                           @{@"artwork_url": @"http://b.com"},
                           @{@"artwork_url": @"http://c.com"},
                           @{@"artwork_url": @"http://d.com"},
                           @{@"artwork_url": @"http://e.com"},
                           @{@"artwork_url": @"http://f.com"},
                           @{@"artwork_url": @"http://g.com"},
                           @{@"artwork_url": @"http://h.com"}];
    
    [self.trackDataSignal sendNext:trackData];
    
    for (Artwork *artwork in artworks)
    {
        [self.imageSignal sendNext:artwork.image];
    }
    
    [self.mockNetworkingService verify];
}

- (void)test_if_api_fails_one_image_download_we_show_correct_error_alert_on_routing_service
{
    [[self.mockRoutingService expect] showErrorAlertWithMessage:@"Image download failed. Please check your internet connection try again later!"];
    
    NSArray *trackData = @[@{@"artwork_url": @"http://a.com"},
                           @{@"artwork_url": @"http://b.com"},
                           @{@"artwork_url": @"http://c.com"},
                           @{@"artwork_url": @"http://d.com"},
                           @{@"artwork_url": @"http://e.com"},
                           @{@"artwork_url": @"http://f.com"},
                           @{@"artwork_url": @"http://g.com"},
                           @{@"artwork_url": @"http://h.com"}];
    
    [self.trackDataSignal sendNext:trackData];

    [self.imageSignal sendError:[NSError errorWithDomain:@"" code:1 userInfo:@{}]];
    
    [self.mockRoutingService verify];
}

@end
