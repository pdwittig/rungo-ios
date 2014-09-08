//
//  PWSettings.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWAgency.h"
#import "PWModelServiceDelegate.h"

@interface PWSettings : NSObject

@property(nonatomic, strong) PWAgency *agency;
@property(nonatomic, strong) NSString *nonDirectionalRoute;
@property(nonatomic, strong) NSString *directionalRoute;
@property(nonatomic, strong) NSDate *departureTime;
@property(nonatomic, weak) id <PWModelServiceDelegate> delegate;

- (id) initWithAgency:(PWAgency *)agency;
+ (id) settingsWithAgency:(PWAgency *)agency;

- (void) saveWithcallback:(responseCallback)callback;

@end
