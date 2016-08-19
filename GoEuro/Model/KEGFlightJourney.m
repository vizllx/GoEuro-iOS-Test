//
//  KEGFlightJourney.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/18/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGFlightJourney.h"

@implementation KEGFlightJourney

+ (NSURL *)webServiceAPIURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [KEGWebService baseURLPath], @"w60i"]];
}

+ (NSArray *)journeysWithJSON:(NSArray *)objects {
    NSMutableArray *journeys = [NSMutableArray array];
    
    for (NSDictionary *object in objects) {
        [journeys addObject:[[KEGFlightJourney alloc] initWithJSON:object]];
    }
    
    return journeys;
}

- (instancetype)initWithJSON:(NSDictionary<NSString *,id> *)object {
    if (self = [super initWithJSON:object]) {
        self.icon = @"✈️";
    }
    return self;
}

@end
