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
- (void)selectedAddress:(GMSAutocompletePrediction *)address ForID:(int)recieverID;
@end


@interface AddressPickerTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UIView *mapContainer;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *seachBar;
@property (strong, nonatomic) IBOutlet UIButton *selectPlaceButton;

@property (strong) NSNumber* recieverID;
@property (nonatomic,strong) id delegate;
- (IBAction)selectPlacePressed:(id)sender;

@end
