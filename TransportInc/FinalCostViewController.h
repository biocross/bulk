//
//  FinalCostViewController.h
//  TransportInc
//
//  Created by Siddharth Gupta on 7/19/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinalCostViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *costLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *pickUpLabel;
@property (strong, nonatomic) IBOutlet UILabel *destinationLabel;
@property (strong, nonatomic) IBOutlet UIButton *bookingButton;
- (IBAction)bookingButtonPressed:(id)sender;


@property NSInteger distance;
@property NSString *pickUpAddress;
@property NSString *destinationAddress;

@end
