//
//  PWUser.m
//  rungo-ios
//
//  Created by Phillip Wittig on 8/24/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWUser.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

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
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
    PWApiClient *apiClient = [PWApiClient sharedInstance];
    
    apiClient.delegate = [[self alloc] init];
    
    NSDictionary *params = @{@"email":email, @"password":password, @"password_confirmation":passwordConfirmation};
    
   [apiClient postRequest:@"users/"
                   params:params
                 callback:callback];
    
//
//    [manager POST:[self endpointUrlWithResource:@"users/"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    
//        callback(YES, nil, responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSDictionary *response = [self parseJson:[operation responseString]];
//        NSError *apiError = [NSError errorWithDomain:@"apiError" code:0 userInfo:response];
//        callback(NO,apiError, nil);
//        
//    }];
    

}

+ (void) loginWithEmail:(NSString *)email password:(NSString *)password callback:(responseCallback)callback {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = @{@"email":email, @"password":password};
    
    [manager POST:[self endpointUrlWithResource:@"sessions/"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id email = [responseObject objectForKey:@"email"];
        id authToken = [[responseObject objectForKey:@"auth_token"] objectForKey:@"access_token"];
        [self setCurrentUserWithEmail:email authToken:authToken];
        callback(YES, nil, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSDictionary *response = [self parseJson:[operation responseString]];
        NSError *apiError = [NSError errorWithDomain:@"apiError" code:0 userInfo:response];
        callback(NO,apiError, nil);
        
    }];
}

# pragma mark - Misc

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

- (id) parseData:(id)data {
    id something;
    return something;
}

+ (NSDictionary *) parseJson:(id)object {
    NSError *error;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:[object dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    return response;
}

+ (NSString *) endpointUrlWithResource:(NSString *)resource {
    return [@"http://localhost:3000/api/" stringByAppendingString:resource];
}

@end
