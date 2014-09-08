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

#pragma mark - Delegate Methods

- (void) saveWithcallback:(responseCallback)callback {
    [self.delegate save:self callback:callback];
}

@end
