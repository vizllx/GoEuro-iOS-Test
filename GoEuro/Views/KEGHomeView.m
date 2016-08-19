//
//  HomeView.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGHomeView.h"
#import "UIStuffHeader.h"

#define KEG_HOME_BUTTONS_CONTAINER_HEIGHT 45
#define KEG_HOME_BUTTON_HEIGHT 40
#define KEG_HOME_SELECTION_WIDTH 25

@interface KEGHomeView()

@property (strong, nonatomic, nonnull) UIView *buttonsContainerView;
@property (strong, nonatomic, nonnull) UIView *selectionView;

@end

@implementation KEGHomeView

#pragma mark - Properties initialization

- (UIButton *)trainButton {
    if (!_trainButton) {
        _trainButton = [[UIButton alloc] init];
        
    }
    return _trainButton;
}

- (UIButton *)busButton {
    if (!_busButton) {
        _busButton = [[UIButton alloc] init];
        
    }
    return _busButton;
}

- (UIButton *)flightButton {
    if (!_flightButton) {
        _flightButton = [[UIButton alloc] init];
        
    }
    return _flightButton;
}

- (UIView *)buttonsContainerView {
    if (!_buttonsContainerView) {
        _buttonsContainerView = [[UIView alloc] init];
        _buttonsContainerView.backgroundColor = [UIColor redColor];
    }
    return _buttonsContainerView;
}

- (iCarousel *)carousel {
    if (!_carousel) {
        _carousel = [[iCarousel alloc] init];
        _carousel.backgroundColor = [UIColor blueColor];
    }
    return _carousel;
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
    
    [self addSubview: self.buttonsContainerView];
    [self.buttonsContainerView addSubview: self.trainButton];
    [self.buttonsContainerView addSubview: self.busButton];
    [self.buttonsContainerView addSubview: self.flightButton];
    [self.buttonsContainerView addSubview: self.selectionView];
    [self addSubview: self.carousel];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat maxWidth = self.bounds.size.width;
    CGFloat buttonWidth = maxWidth / 3;
    
    self.buttonsContainerView.frame = CGRectMake(0, 0, maxWidth, KEG_HOME_BUTTONS_CONTAINER_HEIGHT);
    
    self.trainButton.frame = CGRectMake(0, 0, buttonWidth, KEG_HOME_BUTTON_HEIGHT);
    
    CGPoint carouselOrigin = CGPointMake(0, [self.buttonsContainerView frameMaxY]);
    CGFloat carouselHeight = self.bounds.size.height - carouselOrigin.y;
    
    self.carousel.frame = CGRectMake(carouselOrigin.x, carouselOrigin.y, maxWidth, carouselHeight);
}

@end
