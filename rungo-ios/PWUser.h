//
//  PWUser.h
//  rungo-ios
//
//  Created by Phillip Wittig on 8/24/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PWUser : NSObject

typedef void (^responseCallback)(BOOL success, NSError *error);

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *authToken;

- (id) initWithEmail:(NSString *)email authToken:(NSString *)authToken;
+ (id) userWithEmail:(NSString *)email authToken:(NSString *)authToken;
+ (void) createUserWithEmail:(NSString *)email password:(NSString *)password passwordConfirmation:(NSString *)passwordConfirmation callback:(responseCallback)callback;
+ (void) loginWithEmail:(NSString *)email password:(NSString *)password callback:(responseCallback)calllback;

+ (id) currentUser;
+ (void) setCurrentUserWithEmail:(NSString *)email authToken:(NSString *)authToken;


@end
