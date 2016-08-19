//
//  KEGDataGatherer.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/19/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KEGJourney.h"

typedef void(^DataGatheringSuccess)(NSArray <KEGJourney *>* journeys);
typedef void(^DataGatheringFailure)(NSError *error);

@interface KEGDataGatherer : NSObject

+ (void)gatherJourneyDataForTravelMode:(TravelModeType)travelMode
                               withURL:(NSURL *)url
                 withCompletionHandler:(DataGatheringSuccess)successBlock
                               failure:(DataGatheringFailure)failureBlock;

@end
