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
#import "UIImage+EnumInitializer.h"
#import "KEGLocalizable.h"

#define KEGJourneyCellID @"KEGJourneyCellID"

@interface KEGHomeViewController () <UITableViewDelegate, UITableViewDataSource, KEGSelectionViewDelegate, UIAlertViewDelegate>


@property (weak, nonatomic) KEGHomeView * __nullable homeView;

@property (assign, nonatomic) TravelModeType currentTravelMode;

@property (strong, nonatomic) NSArray <KEGJourney *> * __nullable trains;
@property (strong, nonatomic) NSArray <KEGJourney *> * __nullable buses;
@property (strong, nonatomic) NSArray <KEGJourney *> * __nullable flights;

@property (strong, atomic) NSArray <KEGJourney *> * __nullable currentJourneys;

@property (assign, nonatomic) SortOption currentSortOption;

@property (weak, nonatomic) UIBarButtonItem *sortBarButton;
@property (weak, nonatomic) UILabel *sortDescriptionLabel;

@end

@implementation KEGHomeViewController

#pragma mark - Lifecycle

- (void)loadView {
    self.view = [[KEGHomeView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.currentSortOption = SortOptionDeparture;
    
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
    
    if (!self.navigationItem.leftBarButtonItem) {
        CGRect sortRect = CGRectMake(0, 0, 25, 25);
        UIImage *sortImage = [UIImage imageForIdentifier:ImageIdentifierSort];
        
        UIButton *sortButton = [[UIButton alloc] initWithFrame:sortRect];
        [sortButton setImage:sortImage forState:UIControlStateNormal];
        [sortButton setTitle:[KEGLocalizable localizedString:LocalizableIdentifierDeparture] forState:UIControlStateNormal];
        [sortButton addTarget:self action:@selector(presentSortOptions) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:sortButton];
        self.navigationItem.leftBarButtonItem = barButton;
        
        UILabel *sortLabel = [[UILabel alloc] init];
        sortLabel.text = [KEGLocalizable localizedString:LocalizableIdentifierDeparture];
        sortLabel.font = [UIFont goEuroFont:GoEuroFontRegular size:15];
        sortLabel.textColor = [UIColor whiteColor];
        [sortLabel sizeToFit];
        
        UIBarButtonItem *sortBarLabel = [[UIBarButtonItem alloc] initWithCustomView:sortLabel];
        
        self.navigationItem.leftBarButtonItems = @[barButton, sortBarLabel];
        
        self.sortBarButton = barButton;
        self.sortDescriptionLabel = sortLabel;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dataGatheringPartialCompletion:(NSArray <KEGJourney *> *)journeys travelMode:(TravelModeType)travelMode {
    if (!self.currentJourneys) {
        self.currentTravelMode = travelMode;
        self.currentJourneys = journeys;
        
        [self sortItems];
        
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
    
    [self sortItems];
    
    [self.homeView reloadTableAnimated];
}

#pragma mark - Alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    SortOption option = buttonIndex;
    
    if (self.currentSortOption != option) {
        
        self.currentSortOption = option;
        self.sortDescriptionLabel.text = [alertView buttonTitleAtIndex:buttonIndex];
        
        [self sortItems];
        [self.homeView reloadTableAnimated];
    }
}

#pragma mark - Actions

- (void)presentSortOptions {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[KEGLocalizable localizedString:LocalizableIdentifierSortBy] message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: [KEGLocalizable localizedString:LocalizableIdentifierArrival], [KEGLocalizable localizedString:LocalizableIdentifierDeparture], [KEGLocalizable localizedString:LocalizableIdentifierDuration], [KEGLocalizable localizedString:LocalizableIdentifierPrice], nil];
    [alertView show];
}

- (void)sortItems {
    NSSortDescriptor *descriptor = [KEGJourney sortDescriptorForOption:self.currentSortOption];
    self.currentJourneys = [self.currentJourneys sortedArrayUsingDescriptors:@[descriptor]];
}

@end
