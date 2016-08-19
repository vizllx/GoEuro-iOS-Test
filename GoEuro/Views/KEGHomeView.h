//
//  KEGHomeView.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iCarousel/iCarousel.h>

@interface KEGHomeView : UIView

@property (strong, nonatomic, nonnull) UIButton *trainButton;
@property (strong, nonatomic, nonnull) UIButton *busButton;
@property (strong, nonatomic, nonnull) UIButton *flightButton;
@property (strong, nonatomic, nonnull) iCarousel *carousel;

@end
