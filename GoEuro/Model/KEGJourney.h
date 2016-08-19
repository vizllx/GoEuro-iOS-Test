//
//  TravelMode.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KEGWebService.h"

typedef NS_ENUM(NSUInteger, TravelModeType) {
    TravelModeTypeTrain = 0,
    TravelModeTypeBus,
    TravelModeTypeFlight,
};

NS_ASSUME_NONNULL_BEGIN

@protocol KEGJourneyProtocol <NSObject>

+ (NSURL *)webServiceAPIURL;
+ (NSArray *)journeysWithJSON:(NSArray *)objects;

@end

@interface KEGJourney : NSObject



@property (assign, nonatomic) NSInteger numberOfChanges;
@property (assign, nonatomic) NSInteger objectID;
@property (assign, nonatomic) NSTimeInterval arrivalTime;
@property (assign, nonatomic) NSTimeInterval departureTime;
@property (assign, nonatomic) NSTimeInterval duration;
@property (strong, nonatomic) NSNumber *price;

// This is a really simple example of why there is subclasses of Journey: customization
@property (strong, nonatomic) NSString *icon;

- (NSURL *)providerLogoURLWithSize:(CGFloat)size;

- (instancetype)initWithJSON:(NSDictionary <NSString *, id> *)object NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
