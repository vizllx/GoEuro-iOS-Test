//
//  KEGTrainJourney.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/18/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGTrainJourney.h"

@implementation KEGTrainJourney

+ (NSURL *)webServiceAPIURL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [KEGWebService baseURLPath], @"3zmcy"]];
}

+ (NSArray *)journeysWithJSON:(NSArray *)objects {
    NSMutableArray *journeys = [NSMutableArray array];
    
    for (NSDictionary *object in objects) {
        [journeys addObject:[[KEGTrainJourney alloc] initWithJSON:object]];
    }
    
    return journeys;
}

- (instancetype)initWithJSON:(NSDictionary<NSString *,id> *)object {
    if (self = [super initWithJSON:object]) {
        self.icon = @"🚆";
    }
    return self;
}

@end
