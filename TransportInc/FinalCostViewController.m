//
//  FinalCostViewController.m
//  TransportInc
//
//  Created by Siddharth Gupta on 7/19/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "FinalCostViewController.h"

@interface FinalCostViewController ()

@end

@implementation FinalCostViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.costLabel.textColor = [UIColor colorWithRed:0 green:0.60 blue:0.93 alpha:1];
    self.bookingButton.backgroundColor = [UIColor colorWithRed:0 green:0.60 blue:0.93 alpha:1];
    
    self.pickUpLabel.text = self.pickUpAddress;
    self.destinationLabel.text = self.destinationAddress;
    
    self.distanceLabel.text = [NSString stringWithFormat:@"Distance: %ld km", (long)self.distance];
    long cost = self.distance * 70;
    self.costLabel.text = [NSString stringWithFormat:@"₹ %ld", cost];
}



- (IBAction)bookingButtonPressed:(id)sender {
}
@end
