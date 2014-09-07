//
//  PWAgency.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWAgency.h"

@implementation PWAgency

# pragma mark - Contructors

- (id) initWithName:(NSString *)name {
    self = [super init];
    
    if (self){
        self.name = name;
    }
    return self;
}

+ (id) agencyWithName:(NSString *)name {
    return [[self alloc] initWithName:name];
}


//#pragma mark - API Queries
//
//+ (void) fetchAllAgenciesWithCallback:(responseCallback)callback {
//    
//    PWApiClient *apiClient = [PWApiClient sharedInstance];
//    
//    //Kind of ghetto - figure out how to implement better
//    
//    apiClient.delegate = [[self alloc] init];
//    
//    [apiClient getRequest:@"/agencies"
//                   params:nil
//                  options:nil
//                 callback:(responseCallback)callback];
//    
//}
//
//#pragma mark - Parsing
//
//- (id) handleApiResponse:(id)data {
//    NSMutableArray *agencies = [NSMutableArray array];
//    for (NSDictionary *agencyDict in data) {
//        
//        PWAgency *agency = [PWAgency agencyWithName:[agencyDict objectForKey:@"name"]];
//        [agencies addObject:agency];
//        
//    }
//    return agencies;
//}

@end
