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

#pragma mark - Singleton methods

+ (PWApiClient *)sharedInstance
{
//    static PWApiClient *sharedInstance = nil;
//    static dispatch_once_t oncePredicate;
//    dispatch_once(&oncePredicate, ^{
//        sharedInstance = [[self alloc] init];
//    });
    
    
    return [[super alloc] init];
}


# pragma mark  - API Calls

- (void) getRequest:(NSString *)url params:(NSDictionary *)params klass:(Class)klass options:(NSNumber *)options callback:(responseCallback)callback {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[self endpointUrlWithResource:url] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self handleApiSuccess:responseObject klass:klass options:options callback:callback];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self handleApiError:operation callback:callback];
        
    }];
}

- (void) postRequest:(NSString *)url params:(NSDictionary *)params klass:(Class)klass options:(NSNumber *)options callback:(responseCallback)callback {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:[self endpointUrlWithResource:url] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self handleApiSuccess:responseObject klass:klass options:options callback:callback];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
       [self handleApiError:operation callback:callback];
        
    }];
}

- (void) putRequest:(NSString *)url params:(NSDictionary *)params klass:(Class)klass options:(NSNumber *)options callback:(responseCallback)callback {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager PUT:[self endpointUrlWithResource:url] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self handleApiSuccess:responseObject klass:klass options:options callback:callback];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self handleApiError:operation callback:callback];
        
    }];
}


# pragma mark - Helpers

- (void) handleApiSuccess:(id)responseObject klass:(Class)klass options:(NSNumber *)options callback:(responseCallback)callback {
    
    id response;
    
    if ([options intValue] == 1) {
        response = responseObject;
    }
    else {
        response = [self  parseData:responseObject klass:klass];
    }

    callback(YES, nil, response);
    
}

- (void) handleApiError:(id)responseObject callback:(responseCallback)callback {
    
    NSDictionary *response = [self parseError:[responseObject responseString]];
    NSError *apiError = [NSError errorWithDomain:@"apiError" code:0 userInfo:response];
    callback(NO,apiError, nil);
}

- (NSString *) endpointUrlWithResource:(NSString *)resource {
    
    return [@"http://localhost:3000/api/" stringByAppendingString:resource];
    
}

- (id) parseData:(id)data klass:(Class)klass {
    
    return [self.delegate handleApiResponse:data klass:klass];
    
}

- (NSDictionary *) parseError:(id)object {
    NSError *error;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:[object dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&error];
    return response;
}

@end




