//
//  Artwork.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 16/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

NS_ASSUME_NONNULL_BEGIN

@interface Artwork : NSObject

@property (readonly, nonatomic) NSString *ID;
@property (readonly, nonatomic) UIImage *image;

- (instancetype)initWithID:(NSString *)ID
                     image:(UIImage *)image;

NS_ASSUME_NONNULL_END

@end
