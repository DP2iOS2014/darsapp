//
//  PilasViewController.h
//  darsapp
//
//  Created by inf227al on 7/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface PilasViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *carruselpilas;

@end
