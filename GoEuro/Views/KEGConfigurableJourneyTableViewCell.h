//
//  KEGConfigurableJourneyTableViewCell.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/18/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KEGJourney.h"

@protocol KEGConfigurableJourneyTableViewCell <NSObject>

- (void)configureCellForJourney:(nonnull KEGJourney *)journey;

@end
