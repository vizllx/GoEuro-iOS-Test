//
//  HomeView.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGHomeView.h"
#import "UIStuffHeader.h"
#import "UIScrollView+Direction.h"

#define KEG_HOME_BUTTONS_CONTAINER_HEIGHT 45
#define KEG_HOME_BUTTON_HEIGHT 40
#define KEG_HOME_SELECTION_WIDTH 25

typedef NS_ENUM(NSUInteger, CellAnimation) {
    CellAnimationAppearUp,
    CellAnimationAppearDown,
    CellAnimationNone
};

@interface KEGHomeView()

@end

@implementation KEGHomeView

#pragma mark - Properties initialization

- (KEGSelectorView *)selectorView {
    if (!_selectorView) {
        _selectorView = [[KEGSelectorView alloc] init];
    }
    return _selectorView;
}

- (UITableView *)journeysTableView {
    if (!_journeysTableView) {
        _journeysTableView = [[UITableView alloc] init];
    }
    return _journeysTableView;
}

#pragma mark - Init

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero]) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    [self addSubview:self.selectorView];
    [self addSubview:self.journeysTableView];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat maxWidth = self.bounds.size.width;
    
    self.selectorView.frame = CGRectMake(0, 0, maxWidth, KEG_HOME_BUTTONS_CONTAINER_HEIGHT);
    
    CGPoint carouselOrigin = CGPointMake(0, [self.selectorView frameMaxY]);
    CGFloat carouselHeight = self.bounds.size.height - carouselOrigin.y;
    
    self.journeysTableView.frame = CGRectMake(carouselOrigin.x, carouselOrigin.y, maxWidth, carouselHeight);
}

#pragma mark - Animations

- (void)reloadTableAnimated {
    // Stops scrolling
    [self.journeysTableView setContentOffset:self.journeysTableView.contentOffset animated:NO];
    
    // Prevents wrong cell animation
    self.journeysTableView.lastVerticalOffset = 0;
    
    NSInteger count = 0;
    NSTimeInterval wait = 0;
    
    NSArray <UITableViewCell *> *cells = [self.journeysTableView visibleCells];
    
    for (UITableViewCell *cell in cells) {
        wait = count++ * 0.1;
        
        [UIView animateWithDuration:0.1 delay:wait options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut  animations:^{
            cell.layer.transform = CATransform3DMakeRotation(M_PI_2, 1, 0, 0);
            cell.alpha = 0;
        } completion:^(BOOL finished) {
            if (count == cells.count) {
                [self finishTableReloading];
            }
        }];
    }
}

- (void)finishTableReloading {
    [self.journeysTableView setContentOffset:CGPointZero animated:NO];
    [self.journeysTableView reloadData];
    
    NSInteger count = 0;
    NSTimeInterval wait = 0;
    
    for (UITableViewCell *cell in self.journeysTableView.visibleCells) {
        wait = count++ * 0.1;
        cell.alpha = 0;
        [UIView animateWithDuration:0.1 delay:wait options:UIViewAnimationOptionTransitionCrossDissolve|UIViewAnimationOptionCurveEaseInOut  animations:^{
            cell.layer.transform = CATransform3DIdentity;
            cell.alpha = 1;
        } completion:nil];
    }
}

- (void)animateCell:(UITableViewCell *)cell {
    
    ScrollDirection direction = [self.journeysTableView scrollDirection];
    CellAnimation animation = CellAnimationNone;
    
    if (direction == ScrollDirectionUp) {
        animation = CellAnimationAppearUp;
    } else if (direction == ScrollDirectionDown) {
        animation = CellAnimationAppearDown;
    }
    
    if (animation == CellAnimationNone) {
        cell.alpha = 1;
    } else {
        cell.alpha = 0;
        
        CGFloat value = 0;
        
        if (animation == CellAnimationAppearDown) {
            value = 0.3;
        } else if (animation == CellAnimationAppearUp) {
            value = -0.3;
        }
        
        CATransform3D rotation;
        rotation = CATransform3DMakeRotation(M_PI_2, 1, value, 0);
        rotation.m34 = -0.0025;
        
        cell.layer.transform = rotation;
        
        [UIView animateWithDuration:0.35 animations:^{
            cell.layer.transform = CATransform3DIdentity;
            cell.alpha = 1;
        }];
    }
}

@end
