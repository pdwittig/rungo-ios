//
//  PWUser.h
//  rungo-ios
//
//  Created by Phillip Wittig on 8/24/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWUser : NSObject

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *authToken;

- (id) initWithEmail:(NSString *)email authToken:(NSString *)authToken;
+ (id) userWithEmail:(NSString *)email authToken:(NSString *)authToken;

@end
