//
//  BookNowTableViewController.m
//  TransportInc
//
//  Created by Siddharth Gupta on 7/11/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "BookNowTableViewController.h"
#import "GMDirectionService.h"
#import "FinalCostViewController.h"

@interface BookNowTableViewController (){
}

@property GMSPlace *pickUpAddress;
@property (strong, nonatomic) IBOutlet UILabel *pickUpLabel;
@property (strong, nonatomic) IBOutlet UILabel *dropLabel;

@property (strong, nonatomic) IBOutlet UILabel *weightLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;

@property (strong, nonatomic) IBOutlet UIView *bookNowView;

@end

@implementation BookNowTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.bookNowView.backgroundColor = [UIColor colorWithRed:0 green:0.60 blue:0.93 alpha:1];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        AddressPickerTableViewController *addressPicker = [self.storyboard instantiateViewControllerWithIdentifier:@"AddressPicker"];
        addressPicker.delegate = self;
        addressPicker.recieverID = [NSNumber numberWithInt:0];
        [self.navigationController pushViewController:addressPicker animated:YES];
    }
    else if(indexPath.section == 2){
        if(indexPath.row == 0){
            FinalCostViewController *costController = [self.storyboard instantiateViewControllerWithIdentifier:@"CostView"];
            costController.pickUpAddress = self.pickUpAddress.name;
            costController.destinationAddress = @"";
            costController.distance = 40;
            [self.navigationController pushViewController:costController animated:YES];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)selectedAddress:(GMSPlace *)address ForID:(int)recieverID{
    if(!recieverID){
        self.pickUpAddress = address;
        self.pickUpLabel.text = address.name;
    }
    
//    if(self.pickUpAddress){
//        NSLog(@"Both Addresses are here, getting directions");
//        NSString *origin = [NSString stringWithFormat:@"%f,%f", self.pickUpAddress.coordinate.latitude, self.pickUpAddress.coordinate.longitude];
//        NSString *destination = [NSString stringWithFormat:@"%f,%f", self.destinationAddress.coordinate.latitude, self.destinationAddress.coordinate.longitude];
//        
//        [[GMDirectionService sharedInstance] getDirectionsFrom:origin to:destination succeeded:^(GMDirection *directionResponse) {
//            if ([directionResponse statusOK]){
//                NSLog(@"Distance : %@", [directionResponse distanceHumanized]);
//                self.distanceLabel.text = [directionResponse distanceHumanized];
//            }
//        } failed:^(NSError *error) {
//            NSLog(@"Error in getting directions: %@", [error description]);
//        }];
//    }
}

@end
