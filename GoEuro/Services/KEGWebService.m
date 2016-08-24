//
//  WebService.m
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import "KEGWebService.h"
#import <AFNetworking.h>
#import "KEGLocalizable.h"

@implementation KEGWebService

+ (void)startRequestWithURL:(NSURL *)url successBlock:(WebServiceAPISuccess)successBlock errorBlock:(WebServiceAPIFailure)errorBlock {
    
    AFNetworkReachabilityStatus status = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    
    if (status == AFNetworkReachabilityStatusNotReachable) {
        
        NSError *error = [NSError errorWithDomain:KEGWebServiceErrorDomain code:WebServiceErrorInternetConnectionNotAvailable userInfo:@{ NSLocalizedDescriptionKey : [KEGLocalizable localizedString:LocalizableIdentifierErrorInternetConnection] }];
        errorBlock(error);
        return;
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            errorBlock(error);
        } else {
            successBlock(responseObject);
        }
    }];
    [dataTask resume];
    
}

+ (NSString *)baseURLPath {
    return @"https://api.myjson.com/bins/";
}

@end
