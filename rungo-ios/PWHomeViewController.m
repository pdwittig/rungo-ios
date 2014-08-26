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

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //Redirect to login if no auth token exists
    id currentUser = [PWUser currentUser];
    
    if (!currentUser){
        [self performSegueWithIdentifier:@"showLogin" sender:self];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
