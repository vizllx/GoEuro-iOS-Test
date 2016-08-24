//
//  KEGDataGatherer.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/19/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KEGJourney.h"

#define KEGDataErrorDomain @"com.kevineg.goeuro.Data"

typedef NS_ENUM(NSUInteger, DataGatheringError) {
    DataGatheringErrorWrongObject = 2000,
    DataGatheringErrorNoData
};

typedef NS_ENUM(NSUInteger, DataResponseType) {
    DataResponseTypeOnline,
    DataResponseTypeOffline
};

typedef void(^DataGatheringSuccess)(NSArray <KEGJourney *>* journeys, DataResponseType responseType);
typedef void(^DataGatheringFailure)(NSError *error);

@interface KEGDataGatherer : NSObject

+ (void)gatherJourneyDataForTravelMode:(TravelModeType)travelMode
                               withPath:(NSString *)path
                 withCompletionHandler:(DataGatheringSuccess)successBlock
                               failure:(DataGatheringFailure)failureBlock;

@end
