//
//  UINib+Class.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (Class)

+ (nullable instancetype)nibFromClass:(nonnull Class)nibClass;

@end
