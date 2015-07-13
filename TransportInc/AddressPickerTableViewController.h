//
//  PickerTableViewController.h
//  TransportInc
//
//  Created by Siddharth Gupta on 7/12/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>


@protocol AddressPickerDelegate <NSObject>
@required
- (void)selectedAddress: (GMSAutocompletePrediction *)address;
@end


@interface AddressPickerTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

- (IBAction)backButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *addressField;
@property (strong, nonatomic) IBOutlet UIView *mapContainer;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) id delegate;
@end
