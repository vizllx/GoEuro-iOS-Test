//
//  KEGSelectorView.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/21/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KEGJourney.h"

@protocol KEGSelectionViewDelegate <NSObject>

- (void)selectionWillChangeToTravelMode:(TravelModeType)travelMode;

@end

@interface KEGSelectorView : UIView

@property (weak, nonatomic) id <KEGSelectionViewDelegate> delegate;

- (void)changeSelectionTo:(TravelModeType)travelMode;

@end
