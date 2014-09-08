//
//  PWAgencyMgr.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/7/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWAgencyService.h"

@implementation PWAgencyService

- (id) init {
    
    self = [super init];
    if (self) {
        self.apiClient = [[PWApiClient alloc] init];
    }
    
    return self;
}

#pragma mark - API Queries

- (void) fetchAllAgenciesWithCallback:(responseCallback)callback {
    
    self.apiClient.delegate = self;
    
    [self.apiClient getRequest:@"agencies/"
                   params:nil
                  options:nil
                 callback:(responseCallback)callback];
    
}

#pragma mark - Delegate Methods

- (id) handleApiResponse:(id)data {
    
    NSMutableArray *agencies = [NSMutableArray array];
    for (NSDictionary *agencyDict in data) {
        
        PWAgency *agency = [PWAgency agencyWithName:[agencyDict objectForKey:@"name"]];
        [agencies addObject:agency];
        
    }
    return agencies;
}

@end
