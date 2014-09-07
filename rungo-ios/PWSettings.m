//
//  PWSettings.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWSettings.h"

@implementation PWSettings

- (id) initWithAgency:(PWAgency *)agency {
    self = [super init];

    if (self) {
        self.agency = agency;
    }
    return self;
    
}

+ (id) settingsWithAgency:(PWAgency *)agency {
    return [[self alloc] initWithAgency:agency];
}

//TODO - hookup to backend when settings API is implemented
//+ (void) fetchSettingsForUserAuthToken:(NSString *)authToken callback:(responseCallback)callback {
//
//    NSDictionary *params = @{@"auth_token":[[PWUser currentUser] authToken]};
//    PWApiClient *apiClient = [PWApiClient sharedInstance];
//    
//    apiClient.delegate = [[self alloc] init];
//    
//    [apiClient getRequest:@"settings/"
//                   params:params
//                  options:nil
//                 callback:callback];
//    
//}
//
//+ (id) fetchSettings {
//    return nil;
//}
//
//- (id)handleApiResponse:(id)data {
//    
////    PWAgency
////    return [PWSettings settingsWithAgency:<#(PWAgency *)#>]
//    return nil;
//}

@end
