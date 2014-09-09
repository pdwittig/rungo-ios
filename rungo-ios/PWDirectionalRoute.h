//
//  PWDirectionalRoute.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/8/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWDirectionalRoute : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *code;

- (id) initWithName:(NSString *)name code:(NSString *)code;
+ (id) routeWithName:(NSString *)name code:(NSString *)code;

@end
