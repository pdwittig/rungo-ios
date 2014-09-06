//
//  PWSettings.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWSettings.h"

@implementation PWSettings

- (id) initWithAgency:(PWAgency *)agency {
    self = [super init];

    if (self) {
        self.agency = agency;
    }
    return self;
    
}

+ (id) settingsWithAgency:(PWAgency *)agency {
    return [[self alloc] initWithAgency:agency];
}

//TODO - hookup to backend when settings API is implemented
+ (id)fetchSettings {
    
    PWAgency *agency = [PWAgency agencyWithName:@"Phils Train"];
    return [PWSettings settingsWithAgency:agency];
}

@end
