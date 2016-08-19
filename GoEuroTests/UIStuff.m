//
//  UIStuff.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GoEuro-Swift.h"

@interface UIStuff : XCTestCase

@end

@implementation UIStuff

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItCalculatesMaxYValueCorrectly {
    
    // given
    CGRect frame = CGRectMake(0, 0, 0, 100);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    // when
    CGFloat maxY = [view frameMaxY];
    
    //then
    XCTAssertTrue(100 == maxY);
}

@end
