//
//  PWSignupViewController.h
//  rungo-ios
//
//  Created by Phillip Wittig on 8/24/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWUserService.h"

@interface PWSignupViewController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *emailField;
@property(weak, nonatomic) IBOutlet UITextField *passwordField;
@property(weak, nonatomic) IBOutlet UITextField *passwordConfirmationField;
@property(nonatomic, strong) PWUserService *userService;

- (IBAction)signup:(id)sender;

@end
