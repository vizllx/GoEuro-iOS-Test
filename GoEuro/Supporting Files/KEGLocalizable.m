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
    }
    
    return value;
}

@end
