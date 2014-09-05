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
    
    //Set current user settings
    self.settings = [PWSettings fetchSettings];
    
    //Fetch the required transit data
    [self fetchTransitData];
    
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
        
//        itemPickerViewController.pickerItems = [self extractItemsLabels:self.agencyList labelKey:@"name"];
        itemPickerViewController.pickerItems = self.agencyList;
        itemPickerViewController.pickerItemsKlass = [PWAgency class];
        itemPickerViewController.delegate = self;
    }
 
}

#pragma mark - Helpers

//- (NSMutableArray *) extractItemsLabels:(NSArray *)items labelKey:(NSString *)labelKey {
//    NSMutableArray *itemLabels = [NSMutableArray array];
//    for (id item in items) {
//        [itemLabels addObject:[item valueForKey:labelKey]];
//    }
//    return itemLabels;
//}

- (void) fetchTransitData {
    [PWAgency fetchAllAgenciesWithCallback:^(BOOL success, NSError *error, id responseObject) {
        if (success){
            self.agencyList = responseObject;
        }
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
