//
//  PWSettingsViewController.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWItemPickerViewController.h"
#import "PWSettings.h"

@interface PWSettingsViewController : UITableViewController <ItemPickerViewControllerDelegate>

@property(nonatomic, strong) NSArray *agencyList;
@property (weak, nonatomic) IBOutlet UILabel *agencyLabel;
@property (nonatomic, strong) PWSettings *settings;

@end
