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
    self = [super init];
    
    if (self) {
        self.email = email;
        self.authToken = authToken;
    }
    
    return self;
}

+ (id) userWithEmail:(NSString *)email authToken:(NSString *)authToken {
    return [[self alloc] initWithEmail:email authToken:authToken];
}


#pragma mark - API Queries
+ (void) createUserWithEmail:(NSString *)email password:(NSString *)password passwordConfirmation:(NSString *)passwordConfirmation callback:(responseCallback)callback {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = @{@"email":email, @"password":password, @"password_confirmation":passwordConfirmation};
    
    [manager POST:[self endpointUrlWithResource:@"users/"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(YES, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSDictionary *response = [self parseJson:[operation responseString]];
        NSError *apiError = [NSError errorWithDomain:@"apiError" code:0 userInfo:response];
        callback(NO,apiError);
    }];
}

+ (void) loginWithEmail:(NSString *)email password:(NSString *)password callback:(responseCallback)calllback{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = @{@"email":email, @"password":password};
    
    [manager GET:[self endpointUrlWithResource:@"sessions/"] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [operation responseString]);
    }];
}

# pragma mark - Misc
+ (id) currentUser {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    PWUser *currentUser = [defaults objectForKey:@"currentUser"];
    if (currentUser){
        return currentUser;
    }
    else {
        return NO;
    }
}

#pragma mark - Helpers

+ (NSDictionary *) parseJson:(id)object {
    NSError *error;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:[object dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    return response;
}

+ (NSString *) endpointUrlWithResource:(NSString *)resource {
    return [@"http://localhost:3000/api/" stringByAppendingString:resource];
}

@end
