//
//  KEGDataGatherer.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/19/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGDataGatherer.h"
#import "KEGWebService.h"
#import "KEGLocalDataGatherer.h"
#import "KEGLocalizable.h"

@implementation KEGDataGatherer

+ (void)gatherJourneyDataForTravelMode:(TravelModeType)travelMode
                               withPath:(NSString *)path
                 withCompletionHandler:(DataGatheringSuccess)successBlock
                               failure:(DataGatheringFailure)failureBlock {
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        
        NSURL *url = [[NSURL URLWithString:[KEGWebService baseURLPath]] URLByAppendingPathComponent:path];
        
        [KEGWebService startRequestWithURL:url successBlock:^(id object) {
            
            NSError *error = nil;
            NSArray *journeys = nil;
            NSArray *objects = nil;
            
            if ([object isKindOfClass:[NSArray class]]) {
                
                [KEGLocalDataGatherer saveDataLocally:object forTravelMode:travelMode];
                objects = object;
                
            } else {
                
                NSArray *localObjects = [KEGLocalDataGatherer recoverLocalDataForTravelMode:travelMode];
                if (localObjects) {
                    objects = localObjects;
                }
                
            }
            
            if (objects) {
                
                journeys = [KEGJourney journeysFromObjects:objects withType:travelMode];
                
            } else {
                
                error = [NSError errorWithDomain:KEGDataErrorDomain code:DataGatheringErrorNoData userInfo:@{ NSLocalizedDescriptionKey : [KEGLocalizable localizedString:LocalizableIdentifierErrorNoData] }];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                if (journeys && !error) {
                    successBlock(journeys, DataResponseTypeOnline);
                } else {
                    failureBlock(error);
                }
            });
            
        } errorBlock:^(NSError *error) {
            
            NSError *connectionError = error;
            NSArray *journeys = nil;
            
            if (connectionError) {
                
                NSArray *localObjects = [KEGLocalDataGatherer recoverLocalDataForTravelMode:travelMode];
                
                if (localObjects) {
                    journeys = [KEGJourney journeysFromObjects:localObjects withType:travelMode];
                } else {
                    connectionError = [NSError errorWithDomain:KEGDataErrorDomain code:DataGatheringErrorNoData userInfo:@{ NSLocalizedDescriptionKey : [KEGLocalizable localizedString:LocalizableIdentifierErrorNoData] }];
                }
                
            } else {
                connectionError = [NSError errorWithDomain:KEGDataErrorDomain code:DataGatheringErrorNoData userInfo:@{ NSLocalizedDescriptionKey : [KEGLocalizable localizedString:LocalizableIdentifierErrorNoData] }];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                if (journeys) {
                    successBlock(journeys, DataResponseTypeOffline);
                } else {
                    failureBlock(connectionError);
                }
            });
            
        }];
        
    });
    
}

@end
