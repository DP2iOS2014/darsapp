//
//  BotellasViewController.h
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface BotellasViewController : UIViewController <iCarouselDataSource, iCarouselDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *carruselbotellas;
@end
