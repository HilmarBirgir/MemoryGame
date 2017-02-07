//
//  UINib+Class.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 14/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UINib+Class.h"

@implementation UINib (Class)

+ (nullable instancetype)nibFromClass:(nonnull Class)nibClass;
{
    return [self nibWithNibName:NSStringFromClass(nibClass) bundle:nil];
}

@end
