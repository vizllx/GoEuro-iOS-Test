//
//  KEGHomeViewController.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGHomeViewController.h"
#import "KEGHomeView.h"

@interface KEGHomeViewController ()

@end

@implementation KEGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)loadView {
    self.view = [[KEGHomeView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
