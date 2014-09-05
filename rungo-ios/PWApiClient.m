//
//  PWApiClient.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/5/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWApiClient.h"
#import <AFNetworking/AFNetworking.h>

@implementation PWApiClient

#pragma mark - Constructor

- (PWApiClient *) init {
    
    self = [super init];
    
    if (self) {
        //do something?
    }
    
    return self;
}

#pragma mark - Singleton methods

+ (PWApiClient *)sharedInstance
{
    static PWApiClient *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}


- (void) apiRequest:(NSString *)url httpMethod:(NSString *)httpMethod params:(NSString *)params callback:(responseCallback)callback {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[self endpointUrlWithResource:url] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id response = [self  parseData:responseObject];
        
        callback(YES, nil, response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
//        NSDictionary *response = [self parseJson:[operation responseString]];
//        NSError *apiError = [NSError errorWithDomain:@"apiError" code:0 userInfo:response];
//        callback(NO,apiError, nil);
        
    }];
}

- (NSString *) endpointUrlWithResource:(NSString *)resource {
    return [@"http://localhost:3000/api/" stringByAppendingString:resource];
}

- (id) parseData:(id)data {
    return [self.delegate parseData:data];
}

//+ (NSDictionary *) parseJson:(id)object {
//    NSError *error;
//    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:[object dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
//    return response;
//}
//

@end




