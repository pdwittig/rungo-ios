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

@interface PWUserService : NSObject <PWApiClientDelegate>

typedef void (^responseCallback)(BOOL success, NSError *error, id responseObject);

@property(nonatomic,strong) PWApiClient *apiClient;


- (void) createUserWithEmail:(NSString *)email password:(NSString *)password passwordConfirmation:(NSString *)passwordConfirmation callback:(responseCallback)callback;
- (void) loginWithEmail:(NSString *)email password:(NSString *)password callback:(responseCallback)calllback;

- (id) currentUser;
- (void) setCurrentUserWithEmail:(NSString *)email authToken:(NSString *)authToken;
- (id) handleApiResponse:(id)data;



@end
