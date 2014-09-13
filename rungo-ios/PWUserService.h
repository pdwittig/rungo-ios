//
//  PWUserMgr.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/7/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWUser.h"
#import "PWApiClient.h"

@interface PWUserService : NSObject 

typedef void (^completionBlock)(BOOL success, NSError *error, id responseObject);

@property(nonatomic,strong) PWApiClient *apiClient;


- (void) createUserWithEmail:(NSString *)email password:(NSString *)password passwordConfirmation:(NSString *)passwordConfirmation completion:(completionBlock)completion;
- (void) loginWithEmail:(NSString *)email password:(NSString *)password completion:(completionBlock)completion;

- (id) currentUser;
- (void) setCurrentUserWithEmail:(NSString *)email authToken:(NSString *)authToken;

@end
