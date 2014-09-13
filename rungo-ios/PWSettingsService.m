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

#pragma mark  - Settings Constructors

- (id) settingsWithServiceDelegate {
    
    PWSettings *settings = [[PWSettings alloc] init];
    settings.delegate = self;
    return settings;
    
}

#pragma mark - API Queries

- (void) fetchSettingsForUserAuthToken:(NSString *)authToken completion:(completionBlock)completion {
    
    NSDictionary *params = @{@"auth_token":[[self.userService currentUser] authToken]};

    [self.apiClient getRequest:@"settings/"
                   params:params
                    klass:[PWSettings class]
                  options:nil
               completion:^(BOOL success, NSError *error, id responseObject) {
                        if (success){
                            
                            id settings = [self parseSettings:responseObject];
                            completion(YES, error, settings);
                            
                        }
                        else {
                            
                            completion(NO, error, responseObject);
                            
                        }
                    }];

}

- (void) fetchAllAgenciesWithCallback:(completionBlock)completion {
    
    [self.apiClient getRequest:@"agencies/"
                        params:nil
                         klass:[PWAgency class]
                       options:nil
                    completion:^(BOOL success, NSError *error, id responseObject) {
                        if (success){
                            
                            id agencies = [self parseAgencies:responseObject];
                            completion(YES, error, agencies);
                            
                        }
                        else {
                            
                            completion(NO, error, responseObject);
                            
                        }
                    }];
}

- (void) fetchAllNonDirectionalRoutesforAgency:(NSString *)agencyName completion:(completionBlock)completion{
    
    NSDictionary *params = @{@"agency_name":agencyName};
    
    [self.apiClient getRequest:@"non_directional_routes/"
                        params:params
                         klass:[PWNonDirectionalRoute class]
                       options:nil
                    completion:^(BOOL success, NSError *error, id responseObject) {
                        if (success){
                            
                            id nonDirectionalRoutes = [self parseRoutes:responseObject klass:[PWNonDirectionalRoute class]];
                            completion(YES, error, nonDirectionalRoutes);
                            
                        }
                        else {
                            
                            completion(NO, error, responseObject);
                            
                        }
                    }];
}

- (void) fetchAllDirectionalRoutesForNonDirectionalRoute:(NSString *)nonDirectionalRouteName completion:(completionBlock)completion {
    
    NSDictionary *params = @{@"non_directional_route_name":nonDirectionalRouteName};
    
    [self.apiClient getRequest:@"directional_routes/"
                        params:params
                         klass:[PWDirectionalRoute class]
                       options:nil
                    completion:^(BOOL success, NSError *error, id responseObject) {
                        if (success){
                            
                            id directionalRoutes = [self parseRoutes:responseObject klass:[PWDirectionalRoute class]];
                            completion(YES, error, directionalRoutes);
                            
                        }
                        else {
                            
                            completion(NO, error, responseObject);
                            
                        }
                    }];}


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

#pragma mark - Relationship builders

//- (void) relatedNonDirectionalRoutes:(id)objects callback:(completionBlock)callback  {
//    
////    NSArray *t = [NSArray arrayWithArray:objects];
//    dispatch_group_t group = dispatch_group_create();
// 
//    
//    for (PWAgency *agency in objects) {
//        
//        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            
//            dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//            
//            [self fetchAllNonDirectionalRoutesforAgency:[agency name] completion:^(BOOL success, NSError *error, id responseObject) {
//                if (success){
//                    dispatch_semaphore_signal(sem);
//                    NSLog(@"I am returning the non dir routes");
//                    NSMutableArray *relatedObjects = [NSMutableArray array];
//                    
//                    for (id route in responseObject) {
//                        
//                        [relatedObjects addObject:route];
//                        
//                    }
//                    //                NSLog(@"%@", relatedObjects);
//                    agency.nonDirectionalRoutes = relatedObjects;
//                    //                    NSLog(@"%@",[agency nonDirectionalRoutes]);
//                }
//            }];
//            
//            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//        });
//    }
//    
//    
//    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        callback(YES, nil, objects);
//    });
//    
//}


#pragma mark - Delegate Methods

- (void) save:(id)object completion:(completionBlock)completion{
    
    NSDictionary *params = [self buildParams:object];
    
    [self.apiClient putRequest:@"settings/"
                        params:params
                         klass:[PWSettings class]
                       options:nil
                    completion:^(BOOL success, NSError *error, id responseObject) {
                        if (success){
                            
                            completion(YES, error, responseObject);
                            
                        }
                        else {
                            
                            completion(NO, error, responseObject);
                            
                        }
                    }];
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
