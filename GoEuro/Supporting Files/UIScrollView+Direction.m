//
//  UIScrollView+Direction.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/23/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "UIScrollView+Direction.h"
#import <objc/runtime.h>

@implementation UIScrollView (Direction)

- (void)setLastVerticalOffset:(CGFloat)lastVerticalOffset {
    objc_setAssociatedObject(self, @selector(lastVerticalOffset), @(lastVerticalOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)lastVerticalOffset {
    return [objc_getAssociatedObject(self, @selector(lastVerticalOffset)) doubleValue];
}

- (ScrollDirection)scrollDirection {
    ScrollDirection direction = ScrollDirectionNone;
    
    if (self.lastVerticalOffset < self.contentOffset.y) {
        direction = ScrollDirectionDown;
    } else if (self.lastVerticalOffset > self.contentOffset.y) {
        direction = ScrollDirectionUp;
    }
    
    self.lastVerticalOffset = self.contentOffset.y;
    
    return direction;
}

@end
