//
//  UIImage+EnumInitializer.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ImageIdentifier) {
    ImageIdentifierLogo,
    ImageIdentifierSort
};

@interface UIImage (EnumInitializer)

+ (instancetype)imageForIdentifier:(ImageIdentifier)identifier;

@end
