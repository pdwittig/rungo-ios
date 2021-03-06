//
//  PWSignupViewController.m
//  rungo-ios
//
//  Created by Phillip Wittig on 8/24/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWSignupViewController.h"


@interface PWSignupViewController ()

@end

@implementation PWSignupViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userService = [[PWUserService alloc] init];
    
}


#pragma mark - IBActions

- (IBAction)signup:(id)sender {
    [self validateUserInput];
    [self.userService createUserWithEmail:self.emailField.text password:self.passwordField.text passwordConfirmation:self.passwordConfirmationField.text completion:^(BOOL success, NSError *error, id responseObject){
        if (success){
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else {
            
            [self displayError:[[error userInfo] objectForKey:@"error_message"]];
            
        }
    }];
 
}

#pragma mark  - Helpers

- (void) validateUserInput {
    if ([self.emailField.text length] == 0 || self.passwordField.text == 0 || self.passwordConfirmationField.text == 0){
        [self displayError:@"Make sure you enter an email, password, and password confirmation"];
    }
}

- (void) displayError:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

@end
