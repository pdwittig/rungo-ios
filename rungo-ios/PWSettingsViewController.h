//
//  PWSettingsViewController.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWItemPickerViewController.h"
#import "PWUserService.h"
#import "PWSettingsService.h"

@interface PWSettingsViewController : UITableViewController <ItemPickerViewControllerDelegate>

@property(weak, nonatomic) IBOutlet UILabel *agencyLabel;
@property(nonatomic, strong) NSArray *agencyList;

@property(nonatomic, strong) PWUserService *userService;

@property(nonatomic, strong) PWSettings *settings;
@property(nonatomic,strong) PWSettingsService *settingsService;


@end
