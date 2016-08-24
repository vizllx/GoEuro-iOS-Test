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
#import "GoEuro-Swift.h"
#import "KEGJourneyTableViewCell+ConfigurableCell.h"
#import "KEGDataGatherer.h"
#import "KEGSelectorView.h"

#define KEGJourneyCellID @"KEGJourneyCellID"

@interface KEGHomeViewController () <UITableViewDelegate, UITableViewDataSource, KEGSelectionViewDelegate>


@property (weak, nonatomic) KEGHomeView * __nullable homeView;

@property (assign, nonatomic) TravelModeType currentTravelMode;

@property (strong, nonatomic) NSArray <KEGJourney *> * __nullable trains;
@property (strong, nonatomic) NSArray <KEGJourney *> * __nullable buses;
@property (strong, nonatomic) NSArray <KEGJourney *> * __nullable flights;

@property (assign, atomic) NSInteger dataCount;
@property (strong, atomic) NSArray <KEGJourney *> * __nullable currentJourneys;

@end

@implementation KEGHomeViewController

#pragma mark - Lifecycle

- (void)loadView {
    self.view = [[KEGHomeView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.dataCount = 0;
    
    [self.homeView.journeysTableView registerClass:[JourneyTableViewCell class] forCellReuseIdentifier:KEGJourneyCellID];
    
    [KEGDataGatherer gatherJourneyDataForTravelMode:TravelModeTypeBus withPath:[KEGJourney webServicePathForTravelMode:TravelModeTypeBus] withCompletionHandler:^(NSArray<KEGJourney *> *journeys, DataResponseType responseType) {
        self.buses = journeys;
        [self dataGatheringPartialCompletion:journeys travelMode:TravelModeTypeBus];
    } failure:^(NSError *error) {
        
    }];
    
    [KEGDataGatherer gatherJourneyDataForTravelMode:TravelModeTypeTrain withPath:[KEGJourney webServicePathForTravelMode:TravelModeTypeTrain] withCompletionHandler:^(NSArray<KEGJourney *> *journeys, DataResponseType responseType) {
        self.trains = journeys;
        [self dataGatheringPartialCompletion:journeys travelMode:TravelModeTypeTrain];
    } failure:^(NSError *error) {
        
    }];
    
    [KEGDataGatherer gatherJourneyDataForTravelMode:TravelModeTypeFlight withPath:[KEGJourney webServicePathForTravelMode:TravelModeTypeFlight] withCompletionHandler:^(NSArray<KEGJourney *> *journeys, DataResponseType responseType) {
        self.flights = journeys;
        [self dataGatheringPartialCompletion:journeys travelMode:TravelModeTypeFlight];
    } failure:^(NSError *error) {
        
    }];
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

- (void)dataGatheringPartialCompletion:(NSArray <KEGJourney *> *)journeys travelMode:(TravelModeType)travelMode {
    if (!self.currentJourneys) {
        self.currentTravelMode = travelMode;
        self.currentJourneys = journeys;
        self.homeView.journeysTableView.dataSource = self;
        self.homeView.journeysTableView.delegate = self;
        self.homeView.selectorView.delegate = self;
        [self.homeView.selectorView changeSelectionTo:self.currentTravelMode];
    }
}

#pragma mark - Properties

- (KEGHomeView *)homeView {
    return (KEGHomeView *) self.view;
}

#pragma mark - Table view

#pragma mark Data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.currentJourneys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KEGJourney *object = self.currentJourneys[indexPath.row];
    
    JourneyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KEGJourneyCellID forIndexPath:indexPath];
    
    [cell configureCellForJourney:object];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return JourneyTableViewCell.defaultCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return JourneyTableViewCell.defaultCellHeight;
}

#pragma mark Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.homeView animateCell:cell];
}

#pragma mark - Selector view delegate

- (void)selectionWillChangeToTravelMode:(TravelModeType)travelMode {
    self.currentTravelMode = travelMode;
    
    switch (self.currentTravelMode) {
        case TravelModeTypeBus:
            self.currentJourneys = self.buses;
            break;
        case TravelModeTypeFlight:
            self.currentJourneys = self.flights;
            break;
        case TravelModeTypeTrain:
            self.currentJourneys = self.trains;
            break;
    }
    
    [self.homeView reloadTableAnimated];
}

@end
