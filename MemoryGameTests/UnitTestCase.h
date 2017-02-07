//
//  UnitTestCase.h
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 18/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

@interface UnitTestCase : XCTestCase

@property (readwrite, nonatomic) id mockRoutingService;
@property (readwrite, nonatomic) id mockNetworkingService;
@property (readwrite, nonatomic) id mockScoreKeeperService;

@end
