//
//  PWSettingsViewController.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/3/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PWItemPickerViewController.h"
#import "PWSettingsMgr.h"
#import "PWAgencyMgr.h"

@interface PWSettingsViewController : UITableViewController <ItemPickerViewControllerDelegate>

@property(weak, nonatomic) IBOutlet UILabel *agencyLabel;

@property(nonatomic, strong) PWSettings *settings;
@property(nonatomic,strong) PWSettingsMgr *settingsMgr;

@property(nonatomic, strong) NSArray *agencyList;
@property(nonatomic, strong) PWAgencyMgr *agencyMgr;

@end
