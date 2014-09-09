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
    
    [self.apiClient getRequest:@"agencies/"
                        params:nil
                         klass:[PWAgency class]
                       options:nil
                      callback:(responseCallback)callback];
    
}

- (void) fetchAllNonDirectionalRoutesforAgency:(NSString *)agencyName callback:(responseCallback)callback {
    
    NSDictionary *params = @{@"agency_name":agencyName};
    
    [self.apiClient getRequest:@"non_directional_routes/"
                        params:params
                         klass:[PWNonDirectionalRoute class]
                       options:nil
                      callback:callback];
    
}

- (void) fetchAllDirectionalRoutesForNonDirectionalRoute:(NSString *)nonDirectionalRouteName callback:(responseCallback)callback {
    
    NSDictionary *params = @{@"non_directional_route_name":nonDirectionalRouteName};
    
    [self.apiClient getRequest:@"directional_routes/"
                        params:params
                         klass:[PWDirectionalRoute class]
                       options:nil
                      callback:callback];
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
    
    PWSettings *settings = [self settingsWithServiceDelegate];
    
    if ([data[@"agency"][@"name"] isKindOfClass:[NSString class]]) {
    
        PWAgency *agency = [PWAgency agencyWithName:data[@"agency"][@"name"]];
        settings.agency = agency;
    }
    if ([data[@"non_directional_route"][@"name"] isKindOfClass:[NSString class]]) {
    
        PWNonDirectionalRoute *nonDirectionalRoute = [PWNonDirectionalRoute routeWithName:data[@"non_directional_route"][@"name"]
                                                                                     code:data[@"non_directional_route"][@"code"]];
        settings.nonDirectionalRoute = nonDirectionalRoute;
        
    }
    if ([data[@"directional_route"][@"name"] isKindOfClass:[NSString class]]) {
    
        PWDirectionalRoute *directionalRoute = [PWDirectionalRoute routeWithName:data[@"directional_route"][@"name"]
                                                                            code:data[@"directional_route"][@"code"]];
        
        settings.directionalRoute = directionalRoute;
        
    }
    
    return settings;
    
}

- (id) parseRoutes:(id)data klass:(Class)klass {
    
    NSMutableArray *routes = [NSMutableArray array];
    
    for (id routeData in data) {

        [routes addObject:[klass routeWithName:[routeData objectForKey:@"name"] code:[routeData objectForKey:@"code"]]];
        
    }
    
    return routes;
}



#pragma mark - Delegate Methods

- (id) handleApiResponse:(id)data klass:(Class)klass {
    
    id objects;
    
    if (klass == [PWSettings class]) {
        objects = [self parseSettings:data];
    }
    else if (klass == [PWAgency class]) {
        objects = [self parseAgencies: data];
    }
    else if (klass == [PWNonDirectionalRoute class] || klass == [PWDirectionalRoute class]) {
        objects = [self parseRoutes:data klass:klass];
    }

    return objects;
        
}

- (void) save:(id)object callback:(responseCallback)callback {
    
    
    NSDictionary *params = [self buildParams:object];
    
    [self.apiClient putRequest:@"settings/"
                        params:params
                         klass:[PWSettings class]
                       options:nil
                      callback:callback];
}

- (NSMutableDictionary *) buildParams:(id)object {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"auth_token"] = [[self.userService currentUser] authToken];
    
    if ([[[object agency] name] isKindOfClass:[NSString class]]) {
        params[@"agency_name"] = [[object agency] name];
    }
    if ([[[object nonDirectionalRoute] name] isKindOfClass:[NSString class]]) {
        params[@"non_directional_route_name"] = [[object nonDirectionalRoute] name];
    }
    if ([[[object directionalRoute] name] isKindOfClass:[NSString class]]) {
        params[@"directional_route_name"] = [[object directionalRoute] name];
    }
    
    
    return params;
                             
}

@end
