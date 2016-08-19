//
//  KEGHomeViewController.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGHomeViewController.h"
#import "KEGHomeView.h"
#import "UIStuffHeader.h"
#import <iCarousel/iCarousel.h>
#import "KEGTrainJourney.h"
#import "KEGBusJourney.h"
#import "KEGFlightJourney.h"
#import "GoEuro-Swift.h"
#import "KEGJourneyTableViewCell+ConfigurableCell.h"

@interface KEGHomeViewController () <iCarouselDelegate, iCarouselDataSource, UITableViewDelegate, UITableViewDataSource>

NS_ASSUME_NONNULL_BEGIN

@property (strong, nonatomic) UITableView *trainsTableView;
@property (strong, nonatomic) UITableView *busesTableView;
@property (strong, nonatomic) UITableView *flightsTableView;

@property (weak, nonatomic) KEGHomeView *homeView;

NS_ASSUME_NONNULL_END

@property (strong, nonatomic, nullable) NSArray <KEGTrainJourney *> *trains;
@property (strong, nonatomic, nullable) NSArray <KEGBusJourney *> *buses;
@property (strong, nonatomic, nullable) NSArray <KEGFlightJourney *> *flights;

@end

@implementation KEGHomeViewController

#pragma mark - Lifecycle

- (void)loadView {
    self.view = [[KEGHomeView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.homeView.carousel.delegate = self;
    self.homeView.carousel.dataSource = self;
    
    [self.trainsTableView registerClass:[JourneyTableViewCell class] forCellReuseIdentifier:[self cellIdentifierForTravelMode:TravelModeTypeTrain]];
    [self.busesTableView registerClass:[JourneyTableViewCell class] forCellReuseIdentifier:[self cellIdentifierForTravelMode:TravelModeTypeBus]];
    [self.flightsTableView registerClass:[JourneyTableViewCell class] forCellReuseIdentifier:[self cellIdentifierForTravelMode:TravelModeTypeFlight]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor goEuroColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Properties

- (KEGHomeView *)homeView {
    return (KEGHomeView *) self.view;
}

- (UITableView *)trainsTableView {
    if (!_trainsTableView) {
        _trainsTableView = [[UITableView alloc] init];
        _trainsTableView.dataSource = self;
        _trainsTableView.delegate = self;
    }
    return _trainsTableView;
}

- (UITableView *)busesTableView {
    if (!_busesTableView) {
        _busesTableView = [[UITableView alloc] init];
        _busesTableView.dataSource = self;
        _busesTableView.delegate = self;
    }
    return _busesTableView;
}

- (UITableView *)flightsTableView {
    if (!_flightsTableView) {
        _flightsTableView = [[UITableView alloc] init];
        _flightsTableView.dataSource = self;
        _flightsTableView.delegate = self;
    }
    return _flightsTableView;
}

#pragma mark - iCarousel

#pragma mark Data source

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    
    UITableView *tableView;
    
    switch (index) {
        case TravelModeTypeBus:
            tableView = self.busesTableView;
            break;
        case TravelModeTypeTrain:
            tableView = self.trainsTableView;
            break;
        case TravelModeTypeFlight:
            tableView = self.flightsTableView;
            break;
        default:
            break;
    }
    
    return tableView;
}

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return 3;
}

#pragma mark Delegate

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    
}

#pragma mark - Table view

- (nonnull NSString *)cellIdentifierForTravelMode:(TravelModeType)travelMode {
    NSString *identifier = nil;
    
    switch (travelMode) {
        case TravelModeTypeBus:
            identifier = @"BusCellIdentifier";
            break;
        case TravelModeTypeTrain:
            identifier = @"TrainCellIdentifier";
            break;
        case TravelModeTypeFlight:
            identifier = @"FlightCellIdentifier";
            break;
    }
    
    return identifier;
}

#pragma mark Data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    if ([tableView isEqual:self.trainsTableView]) {
        rows = self.trains.count;
    } else if ([tableView isEqual:self.busesTableView]) {
        rows = self.buses.count;
    } else if ([tableView isEqual:self.flightsTableView]) {
        rows = self.flights.count;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray <KEGJourney *> *source = nil;
    TravelModeType travelMode = TravelModeTypeTrain;
    
    if ([tableView isEqual:self.trainsTableView]) {
        source = self.trains;
        travelMode = TravelModeTypeTrain;
    } else if ([tableView isEqual:self.busesTableView]) {
        source = self.buses;
        travelMode = TravelModeTypeBus;
    } else if ([tableView isEqual:self.flightsTableView]) {
        source = self.flights;
        travelMode = TravelModeTypeFlight;
    }
    
    NSString *identifier = [self cellIdentifierForTravelMode:travelMode];
    
    KEGJourney *object = source[indexPath.row];
    
    JourneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    [cell configureCellForJourney:object];
    
    return cell;
}

#pragma mark Delegate

@end
