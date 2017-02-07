//
//  NetworkingServiceTests.m
//  MemoryGame
//
//  Created by Hilmar Birgir Ólafsson on 19/12/2016.
//  Copyright © 2016 Hilmar Birgir Ólafsson. All rights reserved.
//

#import "UnitTestCase.h"

#import "NetworkingService.h"

#import "SDWebImageManager.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <AFNetworking/AFNetworking.h>

@interface NetworkingServiceTests : UnitTestCase

@property (readwrite, nonatomic) NetworkingService *service;
@property (readwrite, nonatomic) id mockManager;
@property (readwrite, nonatomic) id mockImageManager;

@end

@implementation NetworkingServiceTests

- (void)setUp
{
    [super setUp];
    
    self.mockManager = [OCMockObject niceMockForClass:[AFURLSessionManager class]];
    self.mockImageManager = [OCMockObject niceMockForClass:[SDWebImageManager class]];
    
    self.service = [[NetworkingService alloc] initWithManager:self.mockManager
                                                 imageManager:self.mockImageManager];
}

- (void)test_service_sends_correct_next_when_get_json_succeeds
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    id mockResponse = [OCMockObject niceMockForClass:[NSURLResponse class]];
    
    [[[self.mockManager stub] andDo:^(NSInvocation *invocation) {
        id __unsafe_unretained weakArgument = nil;
        [invocation getArgument:&weakArgument atIndex:3];
        void (^block)(NSData *data, NSURLResponse *response, NSError *error) = weakArgument;
        block(nil, mockResponse, nil);
    }] dataTaskWithRequest:OCMOCK_ANY completionHandler:OCMOCK_ANY];
    
    [[self.service getJsonFromPath:@""] subscribeNext:^(id  _Nullable x) {
        XCTAssertEqual(mockResponse, x);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_service_sends_correct_error_when_get_json_fails
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSError *error = [NSError errorWithDomain:@"test" code:1 userInfo:@{}];
    
    [[[self.mockManager stub] andDo:^(NSInvocation *invocation) {
        id __unsafe_unretained weakArgument = nil;
        [invocation getArgument:&weakArgument atIndex:3];
        void (^block)(NSData *data, NSURLResponse *response, NSError *error) = weakArgument;
        block(nil, nil, error);
    }] dataTaskWithRequest:OCMOCK_ANY completionHandler:OCMOCK_ANY];
    
    [[self.service getJsonFromPath:@""] subscribeError:^(NSError * _Nullable actualError) {
        XCTAssertEqual(error, actualError);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_service_sends_correct_next_when_download_image_succeeds
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    UIImage *image = [UIImage new];
    
    [[[self.mockImageManager stub] andDo:^(NSInvocation *invocation) {
        id __unsafe_unretained weakArgument = nil;
        [invocation getArgument:&weakArgument atIndex:5];
        SDWebImageCompletionWithFinishedBlock block = weakArgument;
        block(image, nil, 0, YES, nil);
    }] downloadImageWithURL:OCMOCK_ANY
                    options:0
                   progress:OCMOCK_ANY
                  completed:OCMOCK_ANY];
    
    [[self.service downloadImageFromPath:@""] subscribeNext:^(UIImage *actualImage) {
        XCTAssertEqual(image, actualImage);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

- (void)test_service_sends_correct_error_when_download_image_fails
{
    XCTestExpectation *expectation = [self expectationWithDescription:NSStringFromSelector(_cmd)];
    
    NSError *error = [NSError errorWithDomain:@"test" code:1 userInfo:@{}];
    
    [[[self.mockImageManager stub] andDo:^(NSInvocation *invocation) {
        id __unsafe_unretained weakArgument = nil;
        [invocation getArgument:&weakArgument atIndex:5];
        SDWebImageCompletionWithFinishedBlock block = weakArgument;
        block(nil, error, 0, YES, nil);
    }] downloadImageWithURL:OCMOCK_ANY
                    options:0
                   progress:OCMOCK_ANY
                  completed:OCMOCK_ANY];
    
    [[self.service downloadImageFromPath:@""] subscribeError:^(NSError * _Nullable actualError) {
        XCTAssertEqual(error, actualError);
        [expectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:0.1 handler:nil];
}

@end
