//
//  PWLoginViewController.m
//  rungo-ios
//
//  Created by Phillip Wittig on 8/25/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWLoginViewController.h"
#import "PWUser.h"

@interface PWLoginViewController ()

@end

@implementation PWLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
}


- (IBAction)login:(id)sender {
    [self validateUserInput];
    [PWUser loginWithEmail:self.emailField.text password:self.passwordField.text callback:^(BOOL success, NSError *error) {
        if (success) {
            [self.navigationController popViewControllerAnimated:NO];
        }
        else {
            [self displayError:[[error userInfo] objectForKey:@"error_message"]];
        }
    }];
}

#pragma mark  - Helpers

- (void) validateUserInput {
    if ([self.emailField.text length] == 0 || self.passwordField.text == 0){
        [self displayError:@"Make sure you enter an email, password"];
    }
}

- (void) displayError:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}



@end
