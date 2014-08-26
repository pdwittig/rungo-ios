//
//  PWLoginViewController.m
//  rungo-ios
//
//  Created by Phillip Wittig on 8/25/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWLoginViewController.h"

@interface PWLoginViewController ()

@end

@implementation PWLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationItem setHidesBackButton:YES];
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
