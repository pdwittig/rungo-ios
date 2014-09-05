//
//  PWApiClient.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/5/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PWApiClientDelegate <NSObject>

- (id) parseData:(id)data;

@end

@interface PWApiClient : NSObject

typedef void (^responseCallback)(BOOL success, NSError *error, id responseObject);

@property(nonatomic, strong) id <PWApiClientDelegate> delegate;

- (void) apiRequest:(NSString *)url httpMethod:(NSString *)httpMethod params:(NSString *)params callback:(responseCallback)callback;

- (PWApiClient *) init;
+ (PWApiClient *) sharedInstance;

@end
