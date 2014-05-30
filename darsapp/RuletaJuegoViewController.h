//
//  RuletaJuegoViewController.h
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreguntasViewController.h"
@interface RuletaJuegoViewController : UIViewController<preguntasDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *ruleta;
@property (strong, nonatomic) IBOutlet UIButton *btnGiraRuleta;
@property (weak, nonatomic) IBOutlet UILabel *ptjMaximo;
@property (weak, nonatomic) IBOutlet UILabel *ptjActual;


@end
