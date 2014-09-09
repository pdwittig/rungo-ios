//
//  PWListItemsViewController.h
//  rungo-ios
//
//  Created by Phillip Wittig on 9/4/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ItemPickerViewControllerDelegate <NSObject>

- (void) didSelectItem:(NSString *)item klass:(Class)klass;

@end

@interface PWItemPickerViewController : UITableViewController


@property(nonatomic, strong) NSArray *pickerItems;
@property(nonatomic, strong) id selectedItem;
@property(nonatomic, strong) Class pickerItemsKlass;
@property(nonatomic, weak) id <ItemPickerViewControllerDelegate> delegate;

@end
