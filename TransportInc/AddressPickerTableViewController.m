//
//  PickerTableViewController.m
//  TransportInc
//
//  Created by Siddharth Gupta on 7/12/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "AddressPickerTableViewController.h"




@interface AddressPickerTableViewController (){
    id <AddressPickerDelegate> _delegate;
}

@property NSArray *suggestions;
@property GMSMapView *pickUpMap;
@property GMSPlacesClient* placesClient;

@end

@implementation AddressPickerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.addressField.delegate = self;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:21.2619056
                                                            longitude:81.6190733
                                                                 zoom:12];
    _pickUpMap = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _pickUpMap.myLocationEnabled = YES;
    _pickUpMap.frame = self.mapContainer.frame;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"Called");
    textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self didChangeTextInTextField];
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didChangeTextInTextField{
    NSLog(@"Called2");
    GMSVisibleRegion visibleRegion = self.pickUpMap.projection.visibleRegion;
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:visibleRegion.farLeft
                                                                       coordinate:visibleRegion.nearRight];
    
    _placesClient = [[GMSPlacesClient alloc] init];
    [_placesClient autocompleteQuery:self.addressField.text
                              bounds:bounds
                              filter:nil
                            callback:^(NSArray *results, NSError *error) {
                                if (error != nil) {
                                    NSLog(@"Autocomplete error %@", [error localizedDescription]);
                                    return;
                                }
                                
                                self.suggestions = results;
                                [self.tableView reloadData];
                            }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.suggestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    GMSAutocompletePrediction *result = self.suggestions[indexPath.row];
    cell.textLabel.text = result.attributedFullText.string;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_delegate selectedAddress:self.suggestions[indexPath.row]];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)backButtonPressed:(id)sender {
}

@end
