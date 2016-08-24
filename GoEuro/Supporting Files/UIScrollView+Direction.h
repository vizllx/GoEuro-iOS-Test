//
//  UIScrollView+Direction.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/23/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ScrollDirection) {
    ScrollDirectionNone,
    ScrollDirectionUp,
    ScrollDirectionDown
};

@interface UIScrollView (Direction)

@property (assign, nonatomic) CGFloat lastVerticalOffset;

- (ScrollDirection)scrollDirection;

@end
