//
//  PWHomeViewController.h
//  rungo-ios
//
//  Created by Phillip Wittig on 8/24/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWUserService.h"
#import <CoreLocation/CoreLocation.h>

@interface PWHomeViewController : UIViewController

@property(nonatomic, strong) PWUserService *userService;

@end
