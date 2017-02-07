//
//  NetworkingService.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "NetworkingService.h"

#import "SDWebImageManager.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking/AFNetworking.h>

@interface NetworkingService ()

@property (readwrite, nonatomic) AFURLSessionManager *manager;
@property (readwrite, nonatomic) SDWebImageManager *imageManager;

@end

@implementation NetworkingService

- (instancetype)init
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    return [self initWithManager:manager
                    imageManager:[SDWebImageManager sharedManager]];
}

- (instancetype)initWithManager:(AFURLSessionManager *)manager
                   imageManager:(SDWebImageManager *)imageManager
{
    self = [super init];
    
    if (self)
    {
        self.manager = manager;
        self.imageManager = imageManager;
        
        [self setupImageCaching];
    }
    
    return self;
}

- (void)setupImageCaching
{
    self.imageManager.cacheKeyFilter = ^(NSURL *url) {
        return url.absoluteString;
    };
}

- (RACSignal *)getJsonFromPath:(NSString *)path
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSURL *URL = [NSURL URLWithString:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request
                                                         completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                             if (error)
                                                             {
                                                                 [subscriber sendError:error];
                                                             }
                                                             else
                                                             {
                                                                 [subscriber sendNext:responseObject];
                                                                 [subscriber sendCompleted];
                                                             }
                                                         }];
        
        [dataTask resume];

        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

- (RACSignal *)downloadImageFromPath:(NSString *)path
{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSURL *url = [NSURL URLWithString:path];
        
        id <SDWebImageOperation> operation = [self.imageManager downloadImageWithURL:url
                                        options:0
                                       progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                       }
                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                          if (image)
                                          {
                                              [subscriber sendNext:image];
                                              [subscriber sendCompleted];
                                          }
                                          else
                                          {
                                              [subscriber sendError:error];
                                          }
                                      }];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
}

@end
