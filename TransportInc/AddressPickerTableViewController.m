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
    GMSPlace *selectedAddress;
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
    self.seachBar.delegate = self;
    
    self.selectPlaceButton.backgroundColor = [UIColor colorWithRed:0 green:0.60 blue:0.93 alpha:1];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:21.2619056
                                                            longitude:81.6190733
                                                                 zoom:12];
    _pickUpMap = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _pickUpMap.myLocationEnabled = YES;
    _pickUpMap.frame = CGRectMake(self.mapContainer.frame.origin.x, self.mapContainer.frame.origin.y-64, self.mapContainer.frame.size.width, self.mapContainer.frame.size.height);
    
    [self.mapContainer addSubview:_pickUpMap];
    [self.seachBar becomeFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self didChangeTextInTextField];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (void)didChangeTextInTextField{
    GMSVisibleRegion visibleRegion = self.pickUpMap.projection.visibleRegion;
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:visibleRegion.farLeft
                                                                       coordinate:visibleRegion.nearRight];
    
    _placesClient = [[GMSPlacesClient alloc] init];
    [_placesClient autocompleteQuery:self.seachBar.text
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
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
    GMSAutocompletePrediction *result = self.suggestions[indexPath.row];
    cell.textLabel.text = result.attributedFullText.string;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.seachBar resignFirstResponder];
    GMSAutocompletePrediction *thePlace = self.suggestions[indexPath.row];
    NSString *placeID = thePlace.placeID;
    
    [_placesClient lookUpPlaceID:placeID callback:^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"Place Details error %@", [error localizedDescription]);
            return;
        }
        if (place != nil) {
            [self.pickUpMap clear];
            
            selectedAddress = place;
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:place.coordinate.latitude longitude:place.coordinate.longitude zoom:16];
            
            [self.pickUpMap animateToCameraPosition:camera];
            
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = camera.target;
            marker.snippet = place.name;
            marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.map = self.pickUpMap;
            
        } else {
            NSLog(@"No place details for %@", placeID);
        }
    }];
}

- (IBAction)selectPlacePressed:(id)sender {
    if(selectedAddress){
        [_delegate selectedAddress:selectedAddress ForID:self.recieverID.intValue];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        NSLog(@"No Address Selected!");
    }
    
}
@end
