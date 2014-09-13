//
//  PWAgency.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWAgency : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSArray *nonDirectionalRoutes;

- (id) initWithName:(NSString *)name;
+ (id) agencyWithName:(NSString *)name;

@end
