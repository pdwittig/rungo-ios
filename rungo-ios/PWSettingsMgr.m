//
//  PWSettingsMgr.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/7/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWSettingsMgr.h"

@implementation PWSettingsMgr

- (id) init {
    
    self = [super init];
    if (self) {
        self.apiClient = [[PWApiClient alloc] init];
    }
    
    return self;
}

- (void) fetchSettingsForUserAuthToken:(NSString *)authToken callback:(responseCallback)callback {

    NSDictionary *params = @{@"auth_token":[[PWUser currentUser] authToken]};

    self.apiClient.delegate = self;

    [self.apiClient getRequest:@"settings/"
                   params:params
                  options:nil
                 callback:callback];

}

- (id)handleApiResponse:(id)data {

    return nil;
}

@end
