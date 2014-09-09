//
//  PWDirectionalRoute.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/8/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWDirectionalRoute.h"

@implementation PWDirectionalRoute

- (id) initWithName:(NSString *)name code:(NSString *)code {
    
    self = [super init];
    
    if (self) {
        self.name = name;
        self.code = code;
    }
    
    return self;
}

+ (id) routeWithName:(NSString *)name code:(NSString *)code {
    
    return [[self alloc] initWithName:name code:code];
    
}

@end
