//
//  PWListItemsViewController.m
//  rungo-ios
//
//  Created by Phillip Wittig on 9/4/14.
//  Copyright (c) 2014 PhilWittig. All rights reserved.
//

#import "PWItemPickerViewController.h"

@interface PWItemPickerViewController ()

@end

@implementation PWItemPickerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.pickerItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    id item = [self.pickerItems objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [item name];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id item = [self.pickerItems objectAtIndex:indexPath.row];
    
    [self.delegate didSelectItem:item klass:self.pickerItemsKlass];
    
    [self.navigationController popViewControllerAnimated:YES];
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
