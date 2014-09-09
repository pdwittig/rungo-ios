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
@property (weak, nonatomic) IBOutlet UILabel *routeLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;

@property(nonatomic, strong) NSArray *agencyCollection;
@property(nonatomic, strong) NSArray *nonDirectionalRouteCollection;
@property(nonatomic, strong) NSArray *directionalRouteCollection;

@property(nonatomic, strong) PWUserService *userService;

@property(nonatomic, strong) PWSettings *settings;
@property(nonatomic,strong) PWSettingsService *settingsService;


@end
