//
//  PWSettingsMgr.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/7/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWApiClient.h"
#import "PWSettings.h"
#import "PWUserService.h"
#import "PWModelServiceDelegate.h"

@interface PWSettingsService : NSObject <PWApiClientDelegate, PWModelServiceDelegate>

typedef void (^responseCallback)(BOOL success, NSError *error, id responseObject);

@property(nonatomic, strong) PWApiClient *apiClient;
@property(nonatomic, strong) PWUserService *userService;

- (void) fetchSettingsForUserAuthToken:(NSString *)authToken callback:(responseCallback)callback;
- (void) fetchAllAgenciesWithCallback:(responseCallback)callback;

- (id) handleApiResponse:(id)data klass:(Class)klass;
- (id) settingsWithServiceDelegate;
- (void) save:(id)object callback:(responseCallback)callback;


@end
