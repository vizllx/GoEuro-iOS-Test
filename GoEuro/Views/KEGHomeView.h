//
//  KEGHomeView.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KEGSelectorView.h"

@interface KEGHomeView : UIView

NS_ASSUME_NONNULL_BEGIN

@property (strong, nonatomic) KEGSelectorView *selectorView;
@property (strong, nonatomic) UITableView *journeysTableView;

- (void)animateCell:(UITableViewCell *)cell;

NS_ASSUME_NONNULL_END

- (void)reloadTableAnimated;

@end
