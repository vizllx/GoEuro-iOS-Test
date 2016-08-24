//
//  KEGLocalDataGatherer.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/19/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGLocalDataGatherer.h"
#import "GoEuro-Swift.h"

@implementation KEGLocalDataGatherer

+ (void)saveDataLocally:(NSArray *)data forTravelMode:(TravelModeType)travelMode {
    
    NSURL *localURL = [KEGLocalDataGatherer localURLForTravelMode:travelMode];
    [data writeToFile:localURL.absoluteString atomically:YES];
}

+ (NSArray *)recoverLocalDataForTravelMode:(TravelModeType)travelMode {
    NSURL *localURL = [KEGLocalDataGatherer localURLForTravelMode:travelMode];
    NSArray *array = [NSArray arrayWithContentsOfFile:localURL.absoluteString];
    return array;
}

+ (NSURL *)localURLForTravelMode:(TravelModeType)travelMode {
    return [[NSURL documentsURL] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.moof", @(travelMode)]];
}

@end
