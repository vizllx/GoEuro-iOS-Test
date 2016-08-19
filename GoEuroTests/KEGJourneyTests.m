//
//  TravelMode.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "KEGJourney.h"
#import "GoEuro-Swift.h"

@interface KEGJourneyTests : XCTestCase

@end

@implementation KEGJourneyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItCalculatesDurationCorrectly {
    // given
    NSDictionary *JSON = @
    {
        @"departure_time"   : @"7:10",
        @"arrival_time"     : @"16:35"
    };
    KEGJourney *journey = [[KEGJourney alloc] initWithJSON:JSON];
    
    // when
    NSTimeInterval duration = journey.duration;
    
    // test
    XCTAssertTrue(duration == 33900); // 09:25
    
    
    // -----------------
    // given
    journey.departureTime = 82800; // 23:00
    journey.arrivalTime = 0; // 00:00
    
    // test
    XCTAssertTrue(journey.duration == 3600);
    
    
    // -----------------
    // given
    journey.departureTime = 82800; // 23:00
    journey.arrivalTime = 25800; // 07:10
    
    // test
    XCTAssertTrue(journey.duration == 29400); // 08:10
    
    
    // -----------------
    // given
    journey.departureTime = 0; // 00:00
    journey.arrivalTime = 25800; // 07:10
    
    // test
    XCTAssertTrue(journey.duration == 25800); // 07:10
}

- (void)testThatItHandlesTimeStringsCorrectly {
    // given
    NSTimeInterval time = 4000;
    
    // when
    NSString *timeString = [NSNumberFormatter dateStringForInterval:time];
    
    // test
    XCTAssertTrue([timeString isEqualToString:@"01:06"]);
    
    
    // -----------------
    // given
    time = 3600;
    
    // when
    timeString = [NSNumberFormatter dateStringForInterval:time];
    
    // test
    XCTAssertTrue([timeString isEqualToString:@"01:00"]);
    
    
    // -----------------
    // given
    time = 0;
    
    // when
    timeString = [NSNumberFormatter dateStringForInterval:time];
    
    // test
    XCTAssertTrue([timeString isEqualToString:@"00:00"]);
    
    
    // -----------------
    // given
    time = 86400;
    
    // when
    timeString = [NSNumberFormatter dateStringForInterval:time];
    
    // test
    XCTAssertTrue([timeString isEqualToString:@"24:00"]);
}

- (void)testThatItCalculatesTimeIntervalFromString {
    
    // given
    NSString *timeString = @"24:00";
    
    // when
    NSTimeInterval interval = [timeString convertToTimeInterval];
    
    // test
    XCTAssertTrue(interval == 86400);
    
    
    // -----------------
    // given
    timeString = @"07:10";
    
    // when
    interval = [timeString convertToTimeInterval];
    
    // test
    XCTAssertTrue(interval == 25800);
    
    
    // -----------------
    // given
    timeString = @"asdasdasd";
    
    // when
    interval = [timeString convertToTimeInterval];
    
    // test
    XCTAssertTrue(interval == -1);
    
    
    // -----------------
    // given
    timeString = @"07:qwe";
    
    // when
    interval = [timeString convertToTimeInterval];
    
    // test
    XCTAssertTrue(interval == -1);
}

- (void)testThatItThrowsWhenItIsNotASubclass {
    
    // given
    
    // test
    XCTAssertThrows(KEGJourney.webServiceAPIURL);
}

@end
