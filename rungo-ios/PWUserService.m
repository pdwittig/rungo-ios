//
//  PWUserMgr.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/7/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWUserService.h"

@implementation PWUserService

- (id) init {
    
    self = [super init];
    if (self) {
        self.apiClient = [[PWApiClient alloc] init];
    }
    
    return self;
}

#pragma mark - API Queries

- (void) createUserWithEmail:(NSString *)email password:(NSString *)password passwordConfirmation:(NSString *)passwordConfirmation callback:(responseCallback)callback {
    
    NSDictionary *params = @{@"email":email, @"password":password, @"password_confirmation":passwordConfirmation};
    
    self.apiClient.delegate = self;
    
    [self.apiClient postRequest:@"users/"
                    params:params
                     klass:[PWUser class]
                   options:[NSNumber numberWithInt:1]
                  callback:callback];
    
}

- (void) loginWithEmail:(NSString *)email password:(NSString *)password callback:(responseCallback)callback {
    
    NSDictionary *params = @{@"email":email, @"password":password};
    
    self.apiClient.delegate = self;
    [self.apiClient postRequest:@"sessions/"
                    params:params
                     klass:[PWUser class]
                   options:nil
                  callback:callback];
    
}

# pragma mark - NSUserDefault stuff

- (id) currentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary   *currentUserDict = [defaults objectForKey:@"currentUser"];
    PWUser *currentUser = [PWUser userWithEmail:[currentUserDict objectForKey:@"email"] authToken:[currentUserDict objectForKey:@"authToken"]];
    if (currentUser){
        return currentUser;
    }
    else {
        return NO;
    }
}

- (void) setCurrentUserWithEmail:(NSString *)email authToken:(NSString *)authToken {
    NSDictionary *currentUser = @{@"email":email, @"authToken":authToken};
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentUser forKey:@"currentUser"];
}


#pragma mark - Delegate Methods

- (id) handleApiResponse:(id)data klass:(Class)klass {
    
    [self setCurrentUserWithEmail:data[@"email"] authToken:data[@"auth_token"][@"access_token"]];
    
    return nil;
}

@end
