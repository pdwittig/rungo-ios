//
//  PWHomeViewController.m
//  rungo-ios
//
//  Created by Phillip Wittig on 8/24/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWHomeViewController.h"
#import "PWUser.h"

@interface PWHomeViewController ()

@end

@implementation PWHomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userService = [[PWUserService alloc] init];
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    CLLocation *lovation = [locationManager location];
    
    NSLog(@"%@", lovation);
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    id currentUser = [self.userService currentUser];
    
    if (!currentUser){
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}

@end
