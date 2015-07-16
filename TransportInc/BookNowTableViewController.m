//
//  BookNowTableViewController.m
//  TransportInc
//
//  Created by Siddharth Gupta on 7/11/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "BookNowTableViewController.h"

@interface BookNowTableViewController ()

@property GMSAutocompletePrediction *pickUpAddress;
@property GMSAutocompletePrediction *destinationAddress;
@property (strong, nonatomic) IBOutlet UILabel *pickUpLabel;
@property (strong, nonatomic) IBOutlet UILabel *dropLabel;

@property (strong, nonatomic) IBOutlet UIView *BookNowButton;

@end

@implementation BookNowTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.BookNowButton.backgroundColor = [UIColor colorWithRed:0 green:0.60 blue:0.93 alpha:1];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        AddressPickerTableViewController *addressPicker = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressPicker"];
        addressPicker.delegate = self;
        addressPicker.recieverID = [NSNumber numberWithInt:0];
        [self.navigationController pushViewController:addressPicker animated:YES];
    }
    else if(indexPath.section == 1){
        AddressPickerTableViewController *addressPicker = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressPicker"];
        addressPicker.delegate = self;
        addressPicker.recieverID = [NSNumber numberWithInt:1];
        [self.navigationController pushViewController:addressPicker animated:YES];
    }
}

-(void)selectedAddress:(GMSAutocompletePrediction *)address ForID:(int)recieverID{
    if(!recieverID){
        self.pickUpAddress = address;
        self.pickUpLabel.text = address.attributedFullText.string;
    }
    else {
        self.destinationAddress = address;
        self.dropLabel.text = address.attributedFullText.string;
    }
}

@end
