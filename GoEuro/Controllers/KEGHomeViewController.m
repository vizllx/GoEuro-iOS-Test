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
#import "KEGJourneyDetailViewController.h"

#define KEGJourneyCellID @"KEGJourneyCellID"

@interface KEGHomeViewController () <UITableViewDelegate, UITableViewDataSource, KEGSelectionViewDelegate, UIAlertViewDelegate>


@property (assign, nonatomic) SortOption currentSortOption;
@property (assign, nonatomic) TravelModeType currentTravelMode;

@property (strong, atomic) NSArray <KEGJourney *> * __nullable currentJourneys;
@property (strong, nonatomic) NSArray <KEGJourney *> * __nullable buses;
@property (strong, nonatomic) NSArray <KEGJourney *> * __nullable flights;
@property (strong, nonatomic) NSArray <KEGJourney *> * __nullable trains;

@property (weak, nonatomic) KEGHomeView * __nullable homeView;
@property (weak, nonatomic) UIButton *sortBarButton;

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
        
        if (responseType == DataResponseTypeOffline) {
            [self.homeView showOfflineWarning];
        }
        
    } failure:^(NSError *error) {
        [self showAlertViewWithTitle:@"Error" message:error.localizedDescription];
    }];
    
    [KEGDataGatherer gatherJourneyDataForTravelMode:TravelModeTypeTrain withPath:[KEGJourney webServicePathForTravelMode:TravelModeTypeTrain] withCompletionHandler:^(NSArray<KEGJourney *> *journeys, DataResponseType responseType) {
        
        self.trains = journeys;
        [self dataGatheringPartialCompletion:journeys travelMode:TravelModeTypeTrain];
        
        if (responseType == DataResponseTypeOffline) {
            [self.homeView showOfflineWarning];
        }
        
    } failure:^(NSError *error) {
        [self showAlertViewWithTitle:@"Error" message:error.localizedDescription];
    }];
    
    [KEGDataGatherer gatherJourneyDataForTravelMode:TravelModeTypeFlight withPath:[KEGJourney webServicePathForTravelMode:TravelModeTypeFlight] withCompletionHandler:^(NSArray<KEGJourney *> *journeys, DataResponseType responseType) {
        
        self.flights = journeys;
        [self dataGatheringPartialCompletion:journeys travelMode:TravelModeTypeFlight];
        
        if (responseType == DataResponseTypeOffline) {
            [self.homeView showOfflineWarning];
        }
        
    } failure:^(NSError *error) {
        [self showAlertViewWithTitle:@"Error" message:error.localizedDescription];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor goEuroColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    if (!self.navigationItem.leftBarButtonItem) {
        
        //TODO: Change this ugly thing
        UIImage *sortImage = [UIImage imageForIdentifier:ImageIdentifierSort];
        CGRect sortRect = CGRectMake(0, 0, 100, 25);
        
        UIButton *sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [sortButton setImage:sortImage forState:UIControlStateNormal];
        [sortButton setTitle:[KEGLocalizable localizedString:LocalizableIdentifierDeparture] forState:UIControlStateNormal];
        sortButton.titleLabel.font = [UIFont goEuroFont:GoEuroFontThin size:12];
        sortButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        sortButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 75);
        sortButton.titleEdgeInsets = UIEdgeInsetsMake(0, -80, 0, 0);
        sortButton.frame = sortRect;
        [sortButton addTarget:self action:@selector(presentSortOptions) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:sortButton];
        self.navigationItem.leftBarButtonItem = barButton;
        
        self.sortBarButton = sortButton;
    }
    
    self.title = @"Toussaint → Berlin";
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
        
        [self.homeView showJourneys];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KEGJourney *journey = self.currentJourneys[indexPath.row];
    KEGJourneyDetailViewController *journeyDetailViewController = [[KEGJourneyDetailViewController alloc] initWithJouney:journey];
    [self.navigationController pushViewController:journeyDetailViewController animated:YES];
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
        [self.sortBarButton setTitle:[alertView buttonTitleAtIndex:buttonIndex] forState:UIControlStateNormal];
        
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
    
    NSArray <NSSortDescriptor *> *descriptors;
    
    NSSortDescriptor *priceSortDescriptor = [KEGJourney sortDescriptorForOption:SortOptionPrice];
    
    if (self.currentSortOption == SortOptionPrice) {
        descriptors = @[priceSortDescriptor, [KEGJourney sortDescriptorForOption:SortOptionDuration]];
    } else {
        descriptors = @[[KEGJourney sortDescriptorForOption:self.currentSortOption], priceSortDescriptor];
    }
    
    self.currentJourneys = [self.currentJourneys sortedArrayUsingDescriptors:descriptors];
}

@end
