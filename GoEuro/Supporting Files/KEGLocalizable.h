//
//  KEGLocalizable.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/18/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LocalizableIdentifier) {
    LocalizableIdentifierDirect,
    LocalizableIdentifierStops,
    LocalizableIdentifierOneStop,
    LocalizableIdentifierErrorInternetConnection
};

@interface KEGLocalizable : NSObject

+ (NSString *)localizedString:(LocalizableIdentifier)identifier;

+ (NSString *)localizableStringIdentifier:(LocalizableIdentifier)localizableIdentifier;

@end
