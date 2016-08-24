//
//  KEGLocalDataGetherer.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/19/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KEGJourney.h"

@interface KEGLocalDataGatherer : NSObject

NS_ASSUME_NONNULL_BEGIN

+ (void)saveDataLocally:(NSArray *)data forTravelMode:(TravelModeType)travelMode;

+ (nullable NSArray *)recoverLocalDataForTravelMode:(TravelModeType)travelMode;

+ (NSURL *)localURLForTravelMode:(TravelModeType)travelMode;

NS_ASSUME_NONNULL_END

@end
