//
//  DetalleIniciativaViewController.h
//  darsapp
//
//  Created by inf227al on 11-06-14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "ViewController.h"
#import "EDStarRating.h"

@interface DetalleIniciativaViewController : ViewController<EDStarRatingProtocol>
@property (weak, nonatomic) IBOutlet EDStarRating *starRating;

@end
