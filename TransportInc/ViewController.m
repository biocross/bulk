//
//  ViewController.m
//  TransportInc
//
//  Created by Siddharth Gupta on 6/22/15.
//  Copyright (c) 2015 Siddharth Gupta. All rights reserved.
//

#import "ViewController.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *controlsView;
@property CLLocation *cachedLocation;

@end

@implementation ViewController{
    GMSMapView *mapView_;
    CLLocationManager *_manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:21.2619056
                                                            longitude:81.6190733
                                                                 zoom:12];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.frame = self.view.frame;
    
    [self.view addSubview:mapView_];
    [self.view bringSubviewToFront:self.controlsView];
    [self.view bringSubviewToFront:self.myLocationButtonView];
    [self addshadows:self.controlsView];
    
    // Setup location services
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"Please enable location services");
        return;
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"Please authorize location services");
        return;
    }
    
    _manager = [[CLLocationManager alloc] init];
    if(IS_OS_8_OR_LATER) {
        [_manager requestWhenInUseAuthorization];
    }
    _manager.delegate = self;
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    _manager.distanceFilter = 5.0f;
    [_manager startUpdatingLocation];
}

- (void) addshadows:(UIView *)view
{
    view.layer.shadowRadius = 10.0;
    view.layer.shadowOpacity = 0.8;
    view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    view.layer.shadowOffset = CGSizeZero;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        NSLog(@"Please authorize location services");
        return;
    }
    
    NSLog(@"CLLocationManager error: %@", error.localizedFailureReason);
    return;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.cachedLocation = [locations lastObject];
    
    GMSCameraUpdate *move = [GMSCameraUpdate setTarget:self.cachedLocation.coordinate zoom:17];
    [mapView_ animateWithCameraUpdate:move];
}

- (IBAction)getMyLocation:(id)sender {
    GMSCameraUpdate *move = [GMSCameraUpdate setTarget:self.cachedLocation.coordinate zoom:17];
    [mapView_ animateWithCameraUpdate:move];
}
@end
