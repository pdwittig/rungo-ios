//
//  PWAgency.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWApiClient.h"


@interface PWAgency : NSObject <PWApiClientDelegate>

@property(nonatomic, strong) NSString *name;


typedef void (^responseCallback)(BOOL success, NSError *error, id responseObject);

- (id) initWithName:(NSString *)name;
+ (id) agencyWithName:(NSString *)name;

+ (void) fetchAllAgenciesWithCallback:(responseCallback)callback;

@end
