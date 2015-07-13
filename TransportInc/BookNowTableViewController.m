//
//  BookNowTableViewController.m
//  TransportInc
//
//  Created by Siddharth Gupta on 7/11/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "BookNowTableViewController.h"

@interface BookNowTableViewController ()


@end

@implementation BookNowTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        AddressPickerTableViewController *addressPicker = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressPicker"];
        addressPicker.delegate = self;
        [self.navigationController pushViewController:addressPicker animated:YES];
    }
}

-(void)selectedAddress:(GMSAutocompletePrediction *)address {
    NSLog(@"Selected: %@", address.attributedFullText.string);
}

@end
