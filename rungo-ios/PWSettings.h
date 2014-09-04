//
//  PWSettings.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PWSettings : NSObject

@property(nonatomic, strong) NSString *agency;
@property(nonatomic, strong) NSString *nonDirectionalRoute;
@property(nonatomic, strong) NSString *directionalRoute;
@property(nonatomic, strong) NSDate *departureTime;



@end
