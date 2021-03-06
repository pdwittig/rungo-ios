//
//  PWModelServiceDelegate.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/8/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PWModelServiceDelegate <NSObject>

typedef void (^completionBlock)(BOOL success, NSError *error, id responseObject);

- (void) save:(id)object completion:(completionBlock)completion;

@end
