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


- (void)viewDidLoad

{
    [super viewDidLoad];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Redirect to login if no auth token exists
//    id currentUser = [PWUser currentUser];
    [PWUser setCurrentUserWithEmail:@"pdwittig@gmail.com" authToken:@"f3aee8f68d1eb69bacb4ce7a26d36670"];
    id currentUser = [PWUser currentUser];
    if (!currentUser){
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}

@end
