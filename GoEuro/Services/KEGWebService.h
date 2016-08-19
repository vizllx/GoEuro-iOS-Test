//
//  WebService.h
//  GoEuro
//
//  Created by Kevin Elorza on 8/17/16.
//  Copyright © 2016 Kevin Elorza. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WebServiceAPIFailure)(NSError *error);

typedef void(^WebServiceAPISuccess)(id object);

typedef NS_ENUM(NSUInteger, WebServiceError) {
    WebServiceErrorInternetConnectionNotAvailable = 1000
};

#define KEGWebServiceErrorDomain @"com.kevineg.goeuro.Connection"

@interface KEGWebService : NSObject

+ (NSString *)baseURLPath;

+ (void)startRequestWithURL:(NSURL *)url successBlock:(WebServiceAPISuccess)successBlock errorBlock:(WebServiceAPIFailure)errorBlock;

@end

NS_ASSUME_NONNULL_END