//
//  Iniciativas.h
//  darsapp
//
//  Created by inf227al on 10/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"

@interface Iniciativas : UITableViewController<EDStarRatingProtocol>

@property (nonatomic,strong) NSDictionary *respuestajson;
@property NSInteger indice;
@property NSString *temainiciativas;
@property NSInteger cantidadFilas;
@end
