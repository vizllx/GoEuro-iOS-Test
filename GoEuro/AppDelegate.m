//
//  AppDelegate.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "AppDelegate.h"
#import "KEGHomeViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    KEGHomeViewController *homeViewController = [[KEGHomeViewController alloc] init];
    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return YES;
}

@end
