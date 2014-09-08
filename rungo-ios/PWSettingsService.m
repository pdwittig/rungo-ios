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
        self.userService = [[PWUserService alloc] init];
    }
    
    return self;
}

#pragma mark - API Queries

- (void) fetchSettingsForUserAuthToken:(NSString *)authToken callback:(responseCallback)callback {
    
    NSLog(@"%@", [self.userService currentUser]);
    
    NSDictionary *params = @{@"auth_token":[[self.userService currentUser] authToken]};

    self.apiClient.delegate = self;

    [self.apiClient getRequest:@"settings/"
                   params:params
                  options:nil
                 callback:callback];

}

#pragma mark - Delegate Methods

- (id)handleApiResponse:(id)data {

    PWAgency *agency = [PWAgency agencyWithName:data[@"agency"][@"name"]];
    PWSettings *settings = [[PWSettings alloc] init];
    settings.agency = agency;
    return settings;

}

@end
