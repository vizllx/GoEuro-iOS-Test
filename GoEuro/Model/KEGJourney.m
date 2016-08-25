//
//  TravelMode.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGJourney.h"
#import "GoEuro-Swift.h"

@interface KEGJourney()

@property (strong, nonatomic) NSString *providerLogo;

@end

@implementation KEGJourney

- (instancetype)init {
    @throw nil;
}

- (instancetype)initWithJSON:(NSDictionary<NSString *, id> *)object type:(TravelModeType)type {
    if (self = [super init]) {
        
        self.type = type;
        self.numberOfChanges = [object[@"number_of_stops"] integerValue];
        self.objectID = [object[@"id"] integerValue];
        self.price = [object[@"price_in_euros"] floatValue];
        self.icon = [self iconForTravelMode:type];
        
        NSString *providerLogo = object[@"provider_logo"];
        
        NSString *providerString = [providerLogo stringByReplacingOccurrencesOfString:@"{size}" withString:@"63"];
        
        self.providerLogoURL = [NSURL URLWithString:[providerString stringByReplacingOccurrencesOfString:@"http:" withString:@"https:"]];
        
        NSString *departureTimeString = object[@"departure_time"];
        NSString *arrivalTimeString = object[@"arrival_time"];
        
        if (departureTimeString) {
            self.departureTime = [departureTimeString convertToTimeInterval];
        } else {
            self.departureTime = -1;
        }
        
        if (arrivalTimeString) {
            self.arrivalTime = [arrivalTimeString convertToTimeInterval];
        } else {
            self.arrivalTime = -1;
        }

    }
    return self;
}

- (NSTimeInterval)duration {
    NSTimeInterval arrivalTime = self.arrivalTime;
    if (self.departureTime > self.arrivalTime) {
        arrivalTime += 86400; // adding one day to compensate
    }
    return fabs(self.departureTime - arrivalTime);
}

- (NSString * __nonnull)iconForTravelMode:(TravelModeType)travelMode {
    NSString *icon = nil;
    
    switch (travelMode) {
        case TravelModeTypeFlight:
            icon = @"🚍";
            break;
        case TravelModeTypeTrain:
            icon = @"🚆";
            break;
        case TravelModeTypeBus:
            icon = @"✈️";
            break;
    }
    
    return icon;
}

+ (NSString *)webServicePathForTravelMode:(TravelModeType)travelMode {
    NSString *path = nil;
    
    switch (travelMode) {
        case TravelModeTypeFlight:
            path = @"w60i";
            break;
        case TravelModeTypeTrain:
            path = @"3zmcy";
            break;
        case TravelModeTypeBus:
            path = @"37yzm";
            break;
    }
    
    return path;
}

+ (NSArray <KEGJourney *>*)journeysFromObjects:(NSArray *)objects withType:(TravelModeType)type {
    NSMutableArray *journeys = [NSMutableArray array];
    
    for (NSDictionary *object in objects) {
        [journeys addObject:[[KEGJourney alloc] initWithJSON:object type:type]];
    }
    
    return journeys;
}

+ (NSSortDescriptor *)sortDescriptorForOption:(SortOption)option {
    
    NSString *property = nil;
    
    switch (option) {
        case SortOptionArrival:
            property = @"arrivalTime";
            break;
        case SortOptionDeparture:
            property = @"departureTime";
            break;
        case SortOptionDuration:
            property = @"duration";
            break;
        case SortOptionPrice:
            property = @"price";
            break;
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:property ascending:YES];
    
    return descriptor;
}

@end
