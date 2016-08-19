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

- (instancetype)initWithJSON:(NSDictionary<NSString *, id> *)object {
    if (self = [super init]) {
        
        self.numberOfChanges = [object[@"numberOfChanges"] integerValue];
        self.objectID = [object[@"id"] integerValue];
        self.price = object[@"price_in_euros"];
        self.providerLogo = object[@"provider_logo"];
        
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

- (NSURL *)providerLogoURLWithSize:(CGFloat)size {
    NSString *providerString = [self.providerLogo stringByReplacingOccurrencesOfString:@"{size}" withString:[NSString stringWithFormat:@"%lf", size]];
    return [NSURL URLWithString:providerString];
}

@end
