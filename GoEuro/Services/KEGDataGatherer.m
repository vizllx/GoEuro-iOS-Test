//
//  KEGDataGatherer.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/19/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGDataGatherer.h"
#import "KEGWebService.h"

#import "KEGBusJourney.h"
#import "KEGFlightJourney.h"
#import "KEGTrainJourney.h"

@implementation KEGDataGatherer

+ (void)gatherJourneyDataForTravelMode:(TravelModeType)travelMode
                               withURL:(NSURL *)url
                 withCompletionHandler:(DataGatheringSuccess)successBlock
                               failure:(DataGatheringFailure)failureBlock {
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        
        [KEGWebService startRequestWithURL:url successBlock:^(id object) {
            
            
            
        } errorBlock:^(NSError *error) {
            
        }];
        
    });
    
}

@end
