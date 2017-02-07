//
//  RACSignalDelayTests.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 20/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "RACSignal+Delay.h"

@interface RACSignalDelayTests : UnitTestCase

@end

@implementation RACSignalDelayTests

- (void)test_rac_signal_fires_after_delay
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    id mockSignal = [OCMockObject niceMockForClass:[RACSignal class]];
    [[[mockSignal stub] andDo:^(NSInvocation *invocation) {
        id __unsafe_unretained weakArgument = nil;
        [invocation getArgument:&weakArgument atIndex:3];
        VoidBlock completionBlock = weakArgument;
        completionBlock();
    }] delay:1 thenDo:OCMOCK_ANY];

    [RACSignal delay:1 thenDo:^{
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

@end
