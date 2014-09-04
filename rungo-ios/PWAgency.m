//
//  PWAgency.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWAgency.h"
#import <AFNetworking/AFNetworking.h>

@implementation PWAgency

# pragma mark - Contructors

@synthesize name;

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


#pragma mark - API Queries

+ (void) fetchAllAgenciesWithCallback:(responseCallback)callback {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[self endpointUrlWithResource:@"agencies/"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *agencies = [self createAgencies:responseObject];
        callback(YES, nil, agencies);
    
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSDictionary *response = [self parseJson:[operation responseString]];
        NSError *apiError = [NSError errorWithDomain:@"apiError" code:0 userInfo:response];
        callback(NO, apiError, nil);
        
    }];
}

#pragma mark - Helpers


+ (NSMutableArray *) createAgencies:(NSArray *)agencyData {
    NSMutableArray *agencies = [NSMutableArray array];
    for (NSDictionary *agencyDict in agencyData) {
        
        PWAgency *agency = [self agencyWithName:[agencyDict objectForKey:@"name"]];
        [agencies addObject:agency];
        
    }
    return agencies;
}

+ (NSDictionary *) parseJson:(id)object {
    NSError *error;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:[object dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    return response;
}

+ (NSString *) endpointUrlWithResource:(NSString *)resource {
    return [@"http://localhost:3000/api/" stringByAppendingString:resource];
}

@end
