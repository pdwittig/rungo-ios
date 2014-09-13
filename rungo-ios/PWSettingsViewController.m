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
#import "PWModelServiceDelegate.h"

@interface PWSettingsViewController ()

@end

@implementation PWSettingsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initDataServices];
    [self loadSettings];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    self.tableView.tableFooterView = view;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self updateLabels];
    
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if([self.navigationController.viewControllers indexOfObject:self] == NSNotFound){
        [self.settings saveWithcallback:^(BOOL success, NSError *error, id responseObject) {
          //TODO - Errors
            
        }];
    }
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    PWItemPickerViewController *itemPickerViewController = (PWItemPickerViewController *)segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"showAgencyItemPicker"]) {
        
        itemPickerViewController.pickerItems = self.agencyCollection;
        itemPickerViewController.pickerItemsKlass = [PWAgency class];
        itemPickerViewController.selectedItem = self.settings.agency;
        itemPickerViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"showRouteItemPicker"]) {
        
        itemPickerViewController.pickerItems = self.nonDirectionalRouteCollection;
        itemPickerViewController.pickerItemsKlass = [PWNonDirectionalRoute class];
        itemPickerViewController.selectedItem = self.settings.nonDirectionalRoute;
        itemPickerViewController.delegate = self;
    }
    else if ([segue.identifier isEqualToString:@"showDirectionItemPicker"]) {
        
        itemPickerViewController.pickerItems = self.directionalRouteCollection;
        itemPickerViewController.pickerItemsKlass = [PWDirectionalRoute class];
        itemPickerViewController.selectedItem = self.settings.directionalRoute;
        itemPickerViewController.delegate = self;
    }
}

#pragma mark - Helpers

- (void) initDataServices {
    
    self.settingsService = [[PWSettingsService alloc] init];
    self.userService = [[PWUserService alloc] init];
    
}

- (void) loadTransitData {
    
    [self loadAgencies];
    
    if (self.settings.agency) [self loadNonDirectionalRoutes];
    
    if (self.settings.nonDirectionalRoute) [self loadDirectionalRoutes];

}

- (void) loadAgencies {
    
    if (!self.agencyCollection) {
        [self.settingsService fetchAllAgenciesWithCallback:^(BOOL success, NSError *error, id responseObject) {
            
            if (success){
                
                self.agencyCollection = responseObject;
                
            }
        }];
    }
}

- (void) loadNonDirectionalRoutes {
    
    [self.settingsService fetchAllNonDirectionalRoutesforAgency:self.settings.agency.name completion:^(BOOL success, NSError *error, id responseObject) {
        
        if (success){
            
            self.nonDirectionalRouteCollection = responseObject;
            
        }
    }];
}

- (void) loadDirectionalRoutes {
    
    [self.settingsService fetchAllDirectionalRoutesForNonDirectionalRoute:self.settings.nonDirectionalRoute.name completion:^(BOOL success, NSError *error, id responseObject) {
    
        if (success) {
            
            self.directionalRouteCollection = responseObject;
            
        }
        
    }];
}

- (void) loadSettings {
    
    PWUser *user = [self.userService currentUser];
    [self.settingsService fetchSettingsForUserAuthToken:[user authToken] completion:^(BOOL success, NSError *error, id responseObject) {
        if (success) {
            
            self.settings = responseObject;
            [self updateLabels];
            [self loadTransitData];
        }
        else {
            
            self.settings = [self.settingsService settingsWithServiceDelegate];
            
        }
    }];
}

-(void) updateLabels {
    
    
    if (self.settings.agency) self.agencyLabel.text = self.settings.agency.name;
    if (self.settings.nonDirectionalRoute) self.routeLabel.text = self.settings.nonDirectionalRoute.name;
    if (self.settings.directionalRoute) self.directionLabel.text = self.settings.directionalRoute.name;
}

#pragma mark - Delegate Methods

- (void) didSelectItem:(id)item klass:(Class)klass {
  
    if (klass == [PWAgency class]) {
        self.settings.agency = item;
    }
    else if (klass == [PWNonDirectionalRoute class]){
        self.settings.nonDirectionalRoute = item;
    }
    else if (klass == [PWDirectionalRoute class]){
        self.settings.directionalRoute = item;
    }
    
    [self loadTransitData];
}

@end
