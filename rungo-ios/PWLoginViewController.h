//
//  PWLoginViewController.h
//  rungo-ios
//
//  Created by Phillip Wittig on 8/25/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWUserService.h"

@interface PWLoginViewController : UIViewController

@property(weak, nonatomic) IBOutlet UITextField *emailField;
@property(weak, nonatomic) IBOutlet UITextField *passwordField;
@property(nonatomic,strong) PWUserService *userService;

- (IBAction)login:(id)sender;
- (void) displayError:(NSString *)message;

@end
