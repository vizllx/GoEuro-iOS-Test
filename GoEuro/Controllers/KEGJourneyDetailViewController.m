//
//  KEGJourneyDetailViewController.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/25/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGJourneyDetailViewController.h"
#import "KEGJourneyDetailView.h"
#import "KEGLocalizable.h"

@interface KEGJourneyDetailViewController ()

@property (strong, nonatomic) KEGJourney *journey;

@end

@implementation KEGJourneyDetailViewController

- (instancetype)initWithJouney:(KEGJourney *)journey {
    if (self = [super init]) {
        self.journey = journey;
    }
    return self;
}

- (void)loadView {
    self.view = [[KEGJourneyDetailView alloc] initWithJourneyIcon:self.journey.icon];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.title = [KEGLocalizable localizedString:LocalizableIdentifierJourneyDetailsTitle];
}

@end
