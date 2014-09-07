//
//  PWUser.m
//  rungo-ios
//
//  Created by Phillip Wittig on 8/24/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWUser.h"

@implementation PWUser

# pragma mark - Contructors

- (id) initWithEmail:(NSString *)email authToken:(NSString *)authToken {
    if ([email length] > 0 && [authToken length] > 0){
        self = [super init];
        if (self) {
            self.email = email;
            self.authToken = authToken;
        }
    return self;
    }
    else {
        return NO;
    }
}

+ (id) userWithEmail:(NSString *)email authToken:(NSString *)authToken {
    return [[self alloc] initWithEmail:email authToken:authToken];
}


#pragma mark - API Queries

+ (void) createUserWithEmail:(NSString *)email password:(NSString *)password passwordConfirmation:(NSString *)passwordConfirmation callback:(responseCallback)callback {
    
    NSDictionary *params = @{@"email":email, @"password":password, @"password_confirmation":passwordConfirmation};
    
    PWApiClient *apiClient = [PWApiClient sharedInstance];
//    apiClient.delegate = [[self alloc] init];
   [apiClient postRequest:@"users/"
                   params:params
                  options:[NSNumber numberWithInt:1]
                 callback:callback];

}

+ (void) loginWithEmail:(NSString *)email password:(NSString *)password callback:(responseCallback)callback {
    
    NSDictionary *params = @{@"email":email, @"password":password};
    
    PWApiClient *apiClient = [PWApiClient sharedInstance];
//    apiClient.delegate = [[self alloc] init];
    [apiClient postRequest:@"sessions/"
                    params:params
                   options:nil
                  callback:callback];
    
}

# pragma mark - NSUserDefault stuff

+ (id) currentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary   *currentUserDict = [defaults objectForKey:@"currentUser"];
    PWUser *currentUser = [self userWithEmail:[currentUserDict objectForKey:@"email"] authToken:[currentUserDict objectForKey:@"authToken"]];
    if (currentUser){
        return currentUser;
    }
    else {
        return NO;
    }
}

+ (void) setCurrentUserWithEmail:(NSString *)email authToken:(NSString *)authToken {
    NSDictionary *currentUser = @{@"email":email, @"authToken":authToken};
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentUser forKey:@"currentUser"];
}


#pragma mark - Helpers

- (id) handleApiResponse:(id)data {
    
    [[self  class] setCurrentUserWithEmail:data[@"email"] authToken:data[@"auth_token"][@"access_token"]];

    return nil;
}


@end
