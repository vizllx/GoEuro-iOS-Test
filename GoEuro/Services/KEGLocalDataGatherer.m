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
    NSData *objectData = [NSKeyedArchiver archivedDataWithRootObject:data];
    NSURL *localURL = [KEGLocalDataGatherer localURLForTravelMode:travelMode];
    [objectData writeToFile:localURL.absoluteString atomically:YES];
}

+ (NSArray *)recoverLocalDataForTravelMode:(TravelModeType)travelMode {
    NSURL *localURL = [KEGLocalDataGatherer localURLForTravelMode:travelMode];
    NSData *data = [NSData dataWithContentsOfFile:localURL.absoluteString];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return array;
}

+ (NSURL *)localURLForTravelMode:(TravelModeType)travelMode {
    return [[NSURL documentsURL] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.moof", @(travelMode)]];
}

@end
