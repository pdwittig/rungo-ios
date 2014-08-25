//
//  PWSignupViewController.m
//  rungo-ios
//
//  Created by Phillip Wittig on 8/24/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWSignupViewController.h"
#import "PWUser.h"

@interface PWSignupViewController ()

@end

@implementation PWSignupViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

#pragma mark - IBActions

- (IBAction)signup:(id)sender {
    [self validateUserInput];
    [PWUser createUserWithEmail:self.emailField.text password:self.passwordField.text passwordConfirmation:self.passwordConfirmationField.text];
}

#pragma mark  - Helpers

- (void) validateUserInput {
    if ( [self.emailField.text length] == 0 || self.passwordField.text == 0 || self.passwordConfirmationField.text == 0){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Make sure you enter an email, password, and password confirmation" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
    }
}

@end
