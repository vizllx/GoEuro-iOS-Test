//
//  KEGJourneyTableViewCell+ConfigurableCell.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/18/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGJourneyTableViewCell+ConfigurableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "KEGLocalizable.h"

@implementation JourneyTableViewCell (ConfigurableCell)

// this should have been in KEGJourneyTableViewCell.swift but iOS 7 does not accept dynamic modules, so here we are

- (void)configureCellForJourney:(KEGJourney *)journey {
    
    [self.providerLogoImageView sd_setImageWithURL:[journey providerLogoURLWithSize:self.providerLogoSize.width]];
    self.priceLabel.text = [NSString stringWithFormat:@"%@ €", journey.price];
    self.timesLabel.text = [NSString stringWithFormat:@"%@ - %@", [NSNumberFormatter dateStringForInterval:journey.departureTime], [NSNumberFormatter dateStringForInterval:journey.arrivalTime]];
    
    NSString *journeyInfo = nil;
    
    switch (journey.numberOfChanges) {
        case 0:
            journeyInfo = [KEGLocalizable localizedString:LocalizableIdentifierDirect];
            break;
        case 1:
            journeyInfo = [KEGLocalizable localizedString:LocalizableIdentifierOneStop];
            break;
        default:
            journeyInfo = [NSString stringWithFormat:@"%ld %@", journey.numberOfChanges, [KEGLocalizable localizedString:LocalizableIdentifierStops]];
            break;
    }
    
}

@end
