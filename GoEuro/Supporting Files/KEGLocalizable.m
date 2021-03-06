//
//  KEGLocalizable.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/18/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGLocalizable.h"

@implementation KEGLocalizable

+ (NSString *)localizedString:(LocalizableIdentifier)identifier {
    return NSLocalizedString([KEGLocalizable localizableStringIdentifier:identifier], nil);
}

+ (NSString *)localizableStringIdentifier:(LocalizableIdentifier)localizableIdentifier {
    NSString *value = nil;
    
    switch (localizableIdentifier) {
        case LocalizableIdentifierDirect:
            value = @"Direct";
            break;
        case LocalizableIdentifierOneStop:
            value = @"OneStop";
            break;
        case LocalizableIdentifierStops:
            value = @"ManyStops";
            break;
        case LocalizableIdentifierErrorInternetConnection:
            value = @"InternetConnectionNotAvailable";
            break;
        case LocalizableIdentifierErrorWrongObject:
            value = @"ErrorWrongObject";
            break;
        case LocalizableIdentifierErrorNoData:
            value = @"ErrorNoData";
            break;
        case LocalizableIdentifierDuration:
            value = @"Duration";
            break;
        case LocalizableIdentifierSortBy:
            value = @"SortBy";
            break;
        case LocalizableIdentifierArrival:
            value = @"Arrival";
            break;
        case LocalizableIdentifierDeparture:
            value = @"Departure";
            break;
        case LocalizableIdentifierPrice:
            value = @"Price";
            break;
        case LocalizableIdentifierNotImplemented:
            value = @"NotImplemented";
            break;
        case LocalizableIdentifierJourneyDetailsTitle:
            value = @"JourneyDetailsTitle";
            break;
        case LocalizableIdentifierOffline:
            value = @"Offline";
            break;
    }
    
    return value;
}

@end
