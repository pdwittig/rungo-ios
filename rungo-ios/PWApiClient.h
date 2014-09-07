//
//  PWApiClient.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/5/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PWApiClientDelegate <NSObject>

- (id) handleApiResponse:(id)data;

@end

@interface PWApiClient : NSObject

typedef void (^responseCallback)(BOOL success, NSError *error, id responseObject);

@property(nonatomic, strong) id <PWApiClientDelegate> delegate;

//Optional options param
// - leave nil under normal circumstances
// - pass 1 if the response requires no model proccesing (via delegate calls)
- (void) getRequest:(NSString *)url params:(NSDictionary *)params options:(NSNumber *)options callback:(responseCallback)callback;
- (void) postRequest:(NSString *)url params:(NSDictionary *)params options:(NSNumber *)options callback:(responseCallback)callback;


- (PWApiClient *) init;
+ (PWApiClient *) sharedInstance;

@end
