//
//  PWSettingsMgr.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/7/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWSettings.h"
#import "PWUser.h"
#import "PWApiClient.h"

@interface PWSettingsMgr : NSObject <PWApiClientDelegate>

typedef void (^responseCallback)(BOOL success, NSError *error, id responseObject);

@property(nonatomic, strong) PWApiClient *apiClient;

- (void) fetchSettingsForUserAuthToken:(NSString *)authToken callback:(responseCallback)callback;
- (id) handleApiResponse:(id)data;


@end
