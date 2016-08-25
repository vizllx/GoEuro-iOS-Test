//
//  KEGSelectorView.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/21/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGSelectorView.h"
#import "GoEuro-Swift.h"

#define KEGSelectionViewHeight 3
#define KEGSelectionButtonTitleFontSize 18
#define KEGSelectionViewWidth 35

#define KEGChangeSelectionAnimationDuration 0.35

@interface KEGSelectorViewButton : UIButton

@property (assign, nonatomic) TravelModeType travelMode;

@end

@implementation KEGSelectorViewButton
@end


typedef NS_ENUM(NSUInteger, SelectionState) {
    SelectionStateSelected,
    SelectionStateNotSelected
};

@interface KEGSelectorView()

@property (strong, nonatomic) KEGSelectorViewButton * __nonnull busButton;
@property (strong, nonatomic) KEGSelectorViewButton * __nonnull trainButton;
@property (strong, nonatomic) KEGSelectorViewButton * __nonnull flightButton;
@property (strong, nonatomic) UIView * __nonnull selectionView;

@property (assign, nonatomic) TravelModeType currentTravelMode;

@end

@implementation KEGSelectorView

#pragma mark - Initializers

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (instancetype)init {
    if (self = [super initWithFrame:CGRectZero]) {
        [self setupView];
    }
    return self;
}

#pragma mark - Properties

- (UIButton *)busButton {
    if (!_busButton) {
        _busButton = [self selectorButtonWithTitle:@"🚍"];
        _busButton.travelMode = TravelModeTypeBus;
    }
    return _busButton;
}

- (UIButton *)trainButton {
    if (!_trainButton) {
        _trainButton = [self selectorButtonWithTitle:@"🚆"];
        _trainButton.travelMode = TravelModeTypeTrain;
    }
    return _trainButton;
}

- (UIButton *)flightButton {
    if (!_flightButton) {
        _flightButton = [self selectorButtonWithTitle:@"✈️"];
        _flightButton.travelMode = TravelModeTypeFlight;
    }
    return _flightButton;
}

- (UIView *)selectionView {
    if (!_selectionView) {
        _selectionView = [[UIView alloc] initWithFrame:CGRectZero];
        _selectionView.backgroundColor = [UIColor colorWithRed:0.87 green:0.43 blue:0.26 alpha:1.0];
    }
    return _selectionView;
}

- (KEGSelectorViewButton * __nonnull)selectorButtonWithTitle:(NSString * __nonnull)title {
    KEGSelectorViewButton *button = [[KEGSelectorViewButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [self selectionButtonFont];
    button.layer.shadowColor = [UIColor colorWithRed:0.54 green:0.54 blue:0.54 alpha:1.0].CGColor;
    button.layer.shadowRadius = 3;
    button.layer.shadowOpacity = 1;
    button.layer.shadowOffset = CGSizeMake(0, 1);
    return button;
}

#pragma mark - Layout

- (void)setupView {
    self.backgroundColor = [UIColor colorWithRed:0.75 green:0.84 blue:0.87 alpha:1.0];
    
    [self.busButton addTarget:self action:@selector(userDidTapSelectionButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.trainButton addTarget:self action:@selector(userDidTapSelectionButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.flightButton addTarget:self action:@selector(userDidTapSelectionButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.busButton];
    [self addSubview:self.trainButton];
    [self addSubview:self.flightButton];
    [self addSubview:self.selectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat buttonWidth = self.bounds.size.width / 3;
    CGFloat buttonHeight = self.bounds.size.height;
    
    self.busButton.frame = CGRectMake(0, 0, buttonWidth, buttonHeight);
    self.trainButton.frame = CGRectMake(self.busButton.frameMaxX, 0, buttonWidth, buttonHeight);
    self.flightButton.frame = CGRectMake(self.trainButton.frameMaxX, 0, buttonWidth, buttonHeight);
    
    [self selectTravelMode:self.currentTravelMode];
}

- (UIFont * __nonnull)selectionButtonFont {
    return [UIFont systemFontOfSize:25];
}

#pragma mark - Selection

- (void)changeSelectionTo:(TravelModeType)travelMode {
    [self selectTravelMode:travelMode];
}

- (void)selectTravelMode:(TravelModeType)travelMode {
    
    KEGSelectorViewButton *newSelectedView = [self viewForTravelMode:travelMode];
    
    CGRect currentSelectionRect = self.selectionView.frame;
    
    if (CGRectEqualToRect(currentSelectionRect, CGRectZero)) {
         self.selectionView.frame = CGRectMake([self selectionViewXValueWithSelectedView:newSelectedView], [self selectionViewBaseYValue], KEGSelectionViewWidth, 0);
    }
    
    [UIView animateWithDuration:KEGChangeSelectionAnimationDuration animations:^{
        self.selectionView.frame = CGRectMake([self selectionViewXValueWithSelectedView:newSelectedView], [self selectionViewBaseYValue], KEGSelectionViewWidth, KEGSelectionViewHeight);
    }];

    self.currentTravelMode = travelMode;
}

- (KEGSelectorViewButton * __nonnull)viewForTravelMode:(TravelModeType)travelMode {
    
    KEGSelectorViewButton *view = nil;
    
    switch (travelMode) {
        case TravelModeTypeBus:
            view = self.busButton;
            break;
        case TravelModeTypeTrain:
            view = self.trainButton;
            break;
        case TravelModeTypeFlight:
            view = self.flightButton;
            break;
    }
    
    return view;
}

- (CGFloat)selectionViewXValueWithSelectedView:(UIView *)selectedView {
    
    return [selectedView frameMiddle].x - (KEGSelectionViewWidth / 2);
}

- (CGFloat)selectionViewBaseYValue {
    
    return self.bounds.size.height - KEGSelectionViewHeight;
}

#pragma mark - Actions

- (void)userDidTapSelectionButton:(KEGSelectorViewButton *)button {
    if (self.currentTravelMode != button.travelMode) {
        TravelModeType userSelectedTravelMode = button.travelMode;
        [self.delegate selectionWillChangeToTravelMode:userSelectedTravelMode];
        
        [self selectTravelMode:userSelectedTravelMode];
    }
}

@end
