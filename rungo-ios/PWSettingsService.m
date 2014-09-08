//
//  PWSettingsMgr.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/7/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWSettingsService.h"

@implementation PWSettingsService

- (id) init {
    
    self = [super init];
    if (self) {
        
        self.apiClient = [[PWApiClient alloc] init];
        self.apiClient.delegate = self;
        
        self.userService = [[PWUserService alloc] init];
    }
    
    return self;
}

#pragma mark  - Settings Constructors

- (id) settingsWithServiceDelegate {
    PWSettings *settings = [[PWSettings alloc] init];
    settings.delegate = self;
    return settings;
}

#pragma mark - API Queries

- (void) fetchSettingsForUserAuthToken:(NSString *)authToken callback:(responseCallback)callback {
    
    NSLog(@"%@", [self.userService currentUser]);
    
    NSDictionary *params = @{@"auth_token":[[self.userService currentUser] authToken]};

    [self.apiClient getRequest:@"settings/"
                   params:params
                  options:nil
                 callback:callback];

}


#pragma mark - Delegate Methods

- (id)handleApiResponse:(id)data {

    PWAgency *agency = [PWAgency agencyWithName:data[@"agency"][@"name"]];
    PWSettings *settings = [self settingsWithServiceDelegate];
    settings.agency = agency;
    return settings;

}

- (void) save:(id)object callback:(responseCallback)callback {
    
    NSDictionary *params = @{@"auth_token":[[self.userService currentUser] authToken],
                             @"agency_name":[[object agency] name]};
    
    [self.apiClient putRequest:@"settings/"
                        params:params
                       options:nil
                      callback:callback];
}

@end
