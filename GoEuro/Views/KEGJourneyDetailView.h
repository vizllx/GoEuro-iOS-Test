//
//  KEGJourneyDetailView.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/25/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KEGJourney.h"

@interface KEGJourneyDetailView : UIView

NS_ASSUME_NONNULL_BEGIN

@property (strong, nonatomic) UILabel *contentLabel;

- (instancetype)initWithJourneyIcon:(NSString *)journeyIcon;

NS_ASSUME_NONNULL_END

@end
