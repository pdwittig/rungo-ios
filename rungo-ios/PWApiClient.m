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

@synthesize delegate;

#pragma mark - Constructors

- (PWApiClient *) init {
    
    self = [super init];
    
    if (self) {
        //do something?
    }
    
    return self;
}

+ (PWApiClient *)apiClient
{
    
    return [[super alloc] init];
}


# pragma mark  - API Calls

- (void) getRequest:(NSString *)url params:(NSDictionary *)params klass:(Class)klass options:(NSNumber *)options completion:(completionBlock)completion {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[self endpointUrlWithResource:url] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        completion(YES, nil, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self handleApiError:operation completion:completion];
        
    }];
}

- (void) postRequest:(NSString *)url params:(NSDictionary *)params klass:(Class)klass options:(NSNumber *)options completion:(completionBlock)completion {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:[self endpointUrlWithResource:url] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         completion(YES, nil, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
       [self handleApiError:operation completion:completion];
        
    }];
}

- (void) putRequest:(NSString *)url params:(NSDictionary *)params klass:(Class)klass options:(NSNumber *)options completion:(completionBlock)completion {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager PUT:[self endpointUrlWithResource:url] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         completion(YES, nil, responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
       [self handleApiError:operation completion:completion];
        
    }];
}


# pragma mark - Helpers

- (void) handleApiError:(id)responseObject completion:(completionBlock)completion {
    
    NSDictionary *response = [self parseError:[responseObject responseString]];
    NSError *apiError = [NSError errorWithDomain:@"apiError" code:0 userInfo:response];
    completion(NO,apiError, nil);
}

- (NSDictionary *) parseError:(id)object {
    NSError *error;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:[object dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    return response;
}

- (NSString *) endpointUrlWithResource:(NSString *)resource {
    
    return [@"http://localhost:3000/api/" stringByAppendingString:resource];
    
}


@end




