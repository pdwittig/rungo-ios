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
    
    NSDictionary *params = @{@"auth_token":[[self.userService currentUser] authToken]};

    [self.apiClient getRequest:@"settings/"
                   params:params
                    klass:[PWSettings class]
                  options:nil
                 callback:callback];

}

- (void) fetchAllAgenciesWithCallback:(responseCallback)callback {
    
    self.apiClient.delegate = self;
    
    [self.apiClient getRequest:@"agencies/"
                        params:nil
                         klass:[PWAgency class]
                       options:nil
                      callback:(responseCallback)callback];
    
}

#pragma mark - Parsing

- (id) parseAgencies:(id)data {
    
    NSMutableArray *agencies = [NSMutableArray array];
    for (NSDictionary *agencyDict in data) {
        
        PWAgency *agency = [PWAgency agencyWithName:[agencyDict objectForKey:@"name"]];
        [agencies addObject:agency];
        
    }
    return agencies;
}

- (id) parseSettings:(id)data {
    
    PWAgency *agency = [PWAgency agencyWithName:data[@"agency"][@"name"]];
    PWSettings *settings = [self settingsWithServiceDelegate];
    settings.agency = agency;
    return settings;
    
}


#pragma mark - Delegate Methods

- (id)handleApiResponse:(id)data klass:(Class)klass {
    
    id objects;
    
    if (klass == [PWSettings class]){
        objects = [self parseSettings:data];
    }
    else if (klass == [PWAgency class]){
        objects = [self parseAgencies: data];
    }
    return objects;
        
}

- (void) save:(id)object callback:(responseCallback)callback {
    
    NSDictionary *params = @{@"auth_token":[[self.userService currentUser] authToken],
                             @"agency_name":[[object agency] name]};
    
    [self.apiClient putRequest:@"settings/"
                        params:params
                         klass:[PWSettings class]
                       options:nil
                      callback:callback];
}

@end
