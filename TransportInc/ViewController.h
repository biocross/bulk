//
//  ViewController.h
//  TransportInc
//
//  Created by Siddharth Gupta on 6/22/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate>

- (IBAction)getMyLocation:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *myLocationButtonView;
@property (strong, nonatomic) IBOutlet UIButton *bookNowButton;
@property (strong, nonatomic) IBOutlet UIButton *callButton;


@end

