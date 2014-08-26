//
//  PWLoginViewController.h
//  rungo-ios
//
//  Created by Phillip Wittig on 8/25/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PWLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)login:(id)sender;

@end
