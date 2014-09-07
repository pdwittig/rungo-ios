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

@end
