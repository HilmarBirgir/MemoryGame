//
//  LoadingViewModel.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "LoadingViewModel.h"

#import "Application+Singletons.h"
#import "NetworkingService.h"
#import "RoutingService.h"
#import "Constants.h"
#import "Artwork.h"

#import <ReactiveObjC/ReactiveObjC.h>

@interface LoadingViewModel ()

@property (readwrite, nonatomic) NetworkingService *networkingService;
@property (readwrite, nonatomic) RoutingService *routingService;

@property (readwrite, nonatomic) NSArray<Artwork *> *artworks;
@property (readwrite, nonatomic) CGFloat progress;

@end

@implementation LoadingViewModel

- (instancetype)init
{
    return [self initWithNetworkingService:[Application sharedNetworkingService]
                            routingService:[Application sharedRoutingService]];
}

- (instancetype)initWithNetworkingService:(NetworkingService *)networkingService
                           routingService:(RoutingService *)routingService
{
    self = [super init];
    
    if (self)
    {
        self.networkingService = networkingService;
        self.routingService = routingService;
        
        [self setup];
        [self bindObservers];
    }
    
    return self;
}

- (void)setup
{
    self.artworks = @[];
}

- (NSArray<NSString *> *)generateArtworkUrls
{
    NSMutableArray *urls = [NSMutableArray new];
    NSInteger index = 0;
    
    for (NSInteger i = 0; i < NUMBER_OF_PAIRS; i++)
    {
        index += arc4random() % 100;
        NSString *url = [NSString stringWithFormat:@"%@?image=%@", IMAGE_URL, @(index)];
        [urls addObject:url];
    }
    
    return urls;
}

- (void)bindObservers
{
    @weakify(self);
    
    [[self artworkSignal:[self generateArtworkUrls]] subscribeNext:^(Artwork *artwork) {
        @strongify(self);
        self.artworks = [self.artworks arrayByAddingObject:artwork];
        self.progress = [self.artworks count] / (CGFloat)NUMBER_OF_PAIRS;
                
        if ([self.artworks count] == NUMBER_OF_PAIRS)
        {
            [self.routingService showGameViewController:self.artworks];
        }
        } error:^(NSError * _Nullable error) {
            @strongify(self);
            [self imageDownloadFailedError];
    }];
}

- (RACSignal *)artworkSignal:(NSArray<NSString *> *)urls
{
    @weakify(self);
    return [RACSignal concat:[urls.rac_sequence map:^id _Nullable(NSString * _Nullable url) {
        @strongify(self);
        return [[self.networkingService downloadImageFromPath:url] map:^id _Nullable(UIImage *image) {
            return [[Artwork alloc] initWithID:url image:image];
        }];
    }]];
}

- (void)imageDownloadFailedError
{
    [self showErrorAlertWithMessage:@"Image download failed. Please check your internet connection try again later!"];
}

- (void)showErrorAlertWithMessage:(NSString *)message
{
    @weakify(self);
    [[self.routingService showErrorAlertWithMessage:message] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.routingService goBack];  
    }];
}

@end
