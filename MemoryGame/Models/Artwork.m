//
//  Artwork.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 16/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "Artwork.h"

#import <UIKit/UIKit.h>

@interface Artwork ()

@property (readwrite, nonatomic) NSString *ID;
@property (readwrite, nonatomic) UIImage *image;

@end

@implementation Artwork

- (instancetype)initWithID:(NSString *)ID
                     image:(UIImage *)image
{
    self = [super init];
    
    if (self)
    {
        self.ID = ID;
        self.image = image;
    }
    
    return self;
}

@end
