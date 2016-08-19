//
//  KEGBusJourney.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGBusJourney.h"

@implementation KEGBusJourney

+ (NSURL *)webServiceAPIURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [KEGWebService baseURLPath], @"37yzm"]];
}

+ (NSArray *)journeysWithJSON:(NSArray *)objects {
    NSMutableArray *journeys = [NSMutableArray array];
    
    for (NSDictionary *object in objects) {
        [journeys addObject:[[KEGBusJourney alloc] initWithJSON:object]];
    }
    
    return journeys;
}

- (instancetype)initWithJSON:(NSDictionary<NSString *,id> *)object {
    if (self = [super initWithJSON:object]) {
        self.icon = @"🚍";
    }
    return self;
}

@end
