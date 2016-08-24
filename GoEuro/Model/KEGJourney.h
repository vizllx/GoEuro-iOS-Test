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
@property (assign, nonatomic) CGFloat price;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSURL *providerLogoURL;
@property (assign, nonatomic) TravelModeType type;

- (instancetype)initWithJSON:(NSDictionary <NSString *, id> *)object type:(TravelModeType)type NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

+ (NSString *)webServicePathForTravelMode:(TravelModeType)travelMode;

+ (NSArray <KEGJourney *>*)journeysFromObjects:(NSArray *)object withType:(TravelModeType)type;

@end

NS_ASSUME_NONNULL_END
