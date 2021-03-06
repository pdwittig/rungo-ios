//
//  PWApiClient.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/5/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PWApiClientDelegate <NSObject>

- (id) handleApiResponse:(id)data klass:(Class)klass;

@end

@interface PWApiClient : NSObject

typedef void (^completionBlock)(BOOL success, NSError *error, id responseObject);

@property(nonatomic, weak) id <PWApiClientDelegate> delegate;

//Optional options param
// - leave nil under normal circumstances
// - pass 1 if the response requires no model proccesing (via delegate calls)
- (void) getRequest:(NSString *)url params:(NSDictionary *)params klass:(Class)klass options:(NSNumber *)options completion:(completionBlock)completion;
- (void) postRequest:(NSString *)url params:(NSDictionary *)params klass:(Class)klass options:(NSNumber *)options completion:(completionBlock)completion;
- (void) putRequest:(NSString *)url params:(NSDictionary *)params klass:(Class)klass options:(NSNumber *)options completion:(completionBlock)completion;



- (PWApiClient *) init;
+ (PWApiClient *) apiClient;

@end
