//
//  MapaTachosViewController.h
//  darsapp
//
//  Created by inf227al on 7/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapaTachosView.h"

@interface MapaTachosViewController : UIViewController <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet MapaTachosView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipoSegmentControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargando;
@end
