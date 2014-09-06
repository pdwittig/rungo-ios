//
//  PWApiClient.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/5/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PWApiClientDelegate <NSObject>

//Name needs to be changed - intermediary handler?
- (id) parseData:(id)data;

@end

@interface PWApiClient : NSObject

typedef void (^responseCallback)(BOOL success, NSError *error, id responseObject);

@property(nonatomic, strong) id <PWApiClientDelegate> delegate;

- (void) getRequest:(NSString *)url params:(NSDictionary *)params callback:(responseCallback)callback;
- (void) postRequest:(NSString *)url params:(NSDictionary *)params callback:(responseCallback)callback;


- (PWApiClient *) init;
+ (PWApiClient *) sharedInstance;

@end
