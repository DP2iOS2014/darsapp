//
//  MapaTachosViewController.m
//  darsapp
//
//  Created by inf227al on 7/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "MapaTachosViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapaTachosViewController ()

@end

@implementation MapaTachosViewController
{
    GMSMapView *mapView_;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-12.068938
                                                            longitude:-77.080190
                                                                 zoom:15.60];
    mapView_ = [GMSMapView mapWithFrame:self.mapView.bounds camera:camera];
    mapView_.myLocationEnabled = YES;
    [self.mapView addSubview: mapView_];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-12.068938, -77.080190);
    marker.title = @"CAPU";
    marker.snippet = @"Capilla";
    marker.map = mapView_;
    // Do any additional setup after loading the view.
    UIButton* myLocationButton = (UIButton*)[[mapView_ subviews] lastObject];
    myLocationButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin;
    CGRect frame = myLocationButton.frame;
    frame.origin.x = 5;
    myLocationButton.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
