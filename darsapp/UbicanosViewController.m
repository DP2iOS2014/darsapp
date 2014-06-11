//
//  UbicanosViewController.m
//  darsapp
//
//  Created by inf227al on 25/04/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#define METERS_PER_MILE 1609.344

#import "UbicanosViewController.h"
#import "DarsLocalizacionAnnotation.h"
@interface UbicanosViewController ()

@end

@implementation UbicanosViewController
{
    CLLocationCoordinate2D coordinate;
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
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //CLLocationCoordinate2D coordinate;
    coordinate.latitude = -12.069919;
    coordinate.longitude = -77.079801;
    DarsLocalizacionAnnotation *annotation = [[DarsLocalizacionAnnotation alloc] initWithName:@"DARS" address:@"Detrás de la oficina Dinthilac" coordinate:coordinate] ;
    [_mapa addAnnotation:annotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    // 1
    //CLLocationCoordinate2D zoomLocation;
    //zoomLocation.latitude = -12.069919;
    //zoomLocation.longitude= -77.079801;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate, 0.3*METERS_PER_MILE, 0.3*METERS_PER_MILE);
    
    // 3
    [_mapa setRegion:viewRegion animated:YES];
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[DarsLocalizacionAnnotation class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapa dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            annotationView.image = [UIImage imageNamed:@"dars1.png"];//here we use a nice image instead of the default pins
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
    
    return nil;
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
