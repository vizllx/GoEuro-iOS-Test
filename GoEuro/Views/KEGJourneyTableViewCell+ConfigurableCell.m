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
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation JourneyTableViewCell (ConfigurableCell)

// this should be in KEGJourneyTableViewCell.swift but iOS 7 does not accept dynamic modules, so here we are

- (void)configureCellForJourney:(KEGJourney *)journey {
    
    [self.providerLogoImageView setImageWithURL:[journey providerLogoURL]];
    self.priceLabel.text = [NSString stringWithFormat:@"%.02f €", journey.price];
    self.timesLabel.text = [NSString stringWithFormat:@"%@ - %@", [NSNumberFormatter dateStringForInterval:journey.departureTime], [NSNumberFormatter dateStringForInterval:journey.arrivalTime]];
    
    self.durationLabel.text = [NSString stringWithFormat:@"%@: %@", [KEGLocalizable localizedString:LocalizableIdentifierDuration], [NSNumberFormatter dateStringForInterval:journey.duration]];
    
    NSString *journeyInfo = nil;
    
    switch (journey.numberOfChanges) {
        case 0:
            journeyInfo = [KEGLocalizable localizedString:LocalizableIdentifierDirect];
            break;
        case 1:
            journeyInfo = [KEGLocalizable localizedString:LocalizableIdentifierOneStop];
            break;
        default:
            journeyInfo = [NSString stringWithFormat:@"%@ %@", @(journey.numberOfChanges), [KEGLocalizable localizedString:LocalizableIdentifierStops]];
            break;
    }
    
    self.journeyInfoLabel.text = journeyInfo;
    
    [self.priceLabel sizeToFit];
    [self.timesLabel sizeToFit];
    [self.durationLabel sizeToFit];
    [self.journeyInfoLabel sizeToFit];
    
    [self layoutIfNeeded];
}

@end
