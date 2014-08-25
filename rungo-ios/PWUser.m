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

+ (void) createUserWithEmail:(NSString *)email password:(NSString *)password passwordConfirmation:(NSString *)passwordConfirmation {
    
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    NSDictionary *params = @{@"email":email, @"password":password, @"password_confirmation":passwordConfirmation};
    
    [manager POST:@"http://rungoapi.herokuapp.com/api/users/" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure, %@", error);
    }];

}

@end
