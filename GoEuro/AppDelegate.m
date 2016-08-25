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
#import <SDWebImage/SDWebImageManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    KEGHomeViewController *homeViewController = [[KEGHomeViewController alloc] init];
    UINavigationController *rootViewController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    
    // This window initialization is necessary as iOS 8< doesn't play well with [[UIWindow alloc] init] or [[UIWindow alloc] initWithFrame:CGRectZero]
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
    
    [SDWebImageManager sharedManager];
    
    return YES;
}

@end
