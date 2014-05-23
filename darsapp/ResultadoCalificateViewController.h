//
//  ResultadoCalificateViewController.h
//  darsapp
//
//  Created by inf227al on 10/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResultadoCalificateViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblPuntaje;
@property (nonatomic,strong) NSDictionary *respuestajson;

@property double puntaje;

@end
