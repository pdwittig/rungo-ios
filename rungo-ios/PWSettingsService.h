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
#import "PWNonDirectionalRoute.h"
#import "PWDirectionalRoute.h"
#import "PWUserService.h"
#import "PWModelServiceDelegate.h"

@interface PWSettingsService : NSObject < PWModelServiceDelegate>

typedef void (^completionBlock)(BOOL success, NSError *error, id responseObject);

@property(nonatomic, strong) PWApiClient *apiClient;
@property(nonatomic, strong) PWUserService *userService;

- (void) fetchSettingsForUserAuthToken:(NSString *)authToken completion:(completionBlock)completion;
- (void) fetchAllAgenciesWithCallback:(completionBlock)completion;
- (void) fetchAllNonDirectionalRoutesforAgency:(NSString *)agencyName completion:(completionBlock)completion;
- (void) fetchAllDirectionalRoutesForNonDirectionalRoute:(NSString *)nonDirectionalRotueName completion:(completionBlock)completion;

- (id) settingsWithServiceDelegate;
- (void) save:(id)object completion:(completionBlock)completion;


@end
