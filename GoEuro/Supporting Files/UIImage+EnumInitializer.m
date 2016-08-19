//
//  UIImage+EnumInitializer.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "UIImage+EnumInitializer.h"

typedef NS_ENUM(NSUInteger, ImageIdentifier) {
    ImageIdentifierLogo,
    ImageIdentifierSort
};

@implementation UIImage (EnumInitializer)

+ (instancetype)imageForIdentifier:(ImageIdentifier)identifier {
    return [UIImage imageNamed:[UIImage imageNameForIdentifier:identifier]];
}

+ (NSString *)imageNameForIdentifier:(ImageIdentifier)identifier {
    NSString *name = @"";
    
    switch (identifier) {
        case ImageIdentifierLogo:
            name = @"Logo";
            break;
        case ImageIdentifierSort:
            name = @"Sort";
            break;
    }
    
    return name;
}

@end
