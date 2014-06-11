//
//  CeldaIniciativasTableViewCell.h
//  darsapp
//
//  Created by inf227al on 10/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"

@interface CeldaIniciativasTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblIniciativa;
@property (weak, nonatomic) IBOutlet EDStarRating *starRating;

@end
