//
//  PWSettingsViewController.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWSettingsViewController.h"
#import "PWItemPickerViewController.h"
#import "PWAgency.h"
#import "PWSettings.h"

@interface PWSettingsViewController ()

@end

@implementation PWSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initDataServices];
    [self loadSettings];
    [self loadTransitData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateLabels];
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PWItemPickerViewController *itemPickerViewController = (PWItemPickerViewController *)segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"showAgencyItemPicker"]) {
        
        itemPickerViewController.pickerItems = self.agencyList;
        itemPickerViewController.pickerItemsKlass = [PWAgency class];
        itemPickerViewController.delegate = self;
    }
 
}

#pragma mark - Helpers

- (void) initDataServices {
    
    self.agencyService = [[PWAgencyService alloc] init];
    self.settingsService = [[PWSettingsService alloc] init];
    self.userService = [[PWUserService alloc] init];
    
}

- (void) loadTransitData {
    [self.agencyService fetchAllAgenciesWithCallback:^(BOOL success, NSError *error, id responseObject) {
        if (success){
            self.agencyList = responseObject;
        }
    }];
}

- (void) loadSettings {
    
    //TODO - How should I handle errors here?
    PWUser *user = [self.userService currentUser];
    [self.settingsService fetchSettingsForUserAuthToken:[user authToken] callback:^(BOOL success, NSError *error, id responseObject) {
        self.settings = responseObject;
    }];
}

-(void) updateLabels {
    self.agencyLabel.text = self.settings.agency.name;
}

#pragma mark - Delegate Methods

- (void) didSelectItem:(id)item klass:(Class)klass {
    if (klass == [PWAgency class]) {
        self.settings.agency = item;
    }
}

@end
