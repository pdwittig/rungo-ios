//
//  PWSettings.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PWAgency.h"
#import "PWApiClient.h"

@interface PWSettings : NSObject <PWApiClientDelegate>

typedef void (^responseCallback)(BOOL success, NSError *error, id responseObject);

@property(nonatomic, strong) PWAgency *agency;
@property(nonatomic, strong) NSString *nonDirectionalRoute;
@property(nonatomic, strong) NSString *directionalRoute;
@property(nonatomic, strong) NSDate *departureTime;

- (id) initWithAgency:(PWAgency *)agency;
+ (id) settingsWithAgency:(PWAgency *)agency;

//TODO - hookup to backend when settings API is implemented
+ (id) fetchSettingsForUserAuthToken:(NSString *)authToken callback:(responseCallback)callback;
- (id) handleApiResponse:(id)data;
+(id) fetchSettings;


@end
