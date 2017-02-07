//
//  UnitTestCase.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 18/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "RoutingService.h"
#import "NetworkingService.h"
#import "ScoreKeeperService.h"

@implementation UnitTestCase

- (id)mockRoutingService
{
    if (_mockRoutingService == nil)
    {
        _mockRoutingService = [OCMockObject niceMockForClass:[RoutingService class]];
    }
    
    return _mockRoutingService;
}
- (id)mockNetworkingService
{
    if (_mockNetworkingService == nil)
    {
        _mockNetworkingService = [OCMockObject niceMockForClass:[NetworkingService class]];
    }
    
    return _mockNetworkingService;
}

- (id)mockScoreKeeperService
{
    if (_mockScoreKeeperService == nil)
    {
        _mockScoreKeeperService = [OCMockObject niceMockForClass:[ScoreKeeperService class]];
    }
    
    return _mockScoreKeeperService;
}

@end
