//
//  NetworkingService.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class AFURLSessionManager;
@class SDWebImageManager;

NS_ASSUME_NONNULL_BEGIN

@interface NetworkingService : NSObject

- (instancetype)initWithManager:(AFURLSessionManager *)manager
                   imageManager:(SDWebImageManager *)imageManager;

- (RACSignal *)getJsonFromPath:(NSString *)path;
- (RACSignal *)downloadImageFromPath:(NSString *)path;

NS_ASSUME_NONNULL_END

@end
