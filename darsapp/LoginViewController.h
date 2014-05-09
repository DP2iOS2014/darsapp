//
//  LoginViewController.h
//  darsapp
//
//  Created by inf227al on 25/04/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) UITapGestureRecognizer *tap;

@property (weak, nonatomic) IBOutlet UITextField *tFusuario;
@property (weak, nonatomic) IBOutlet UITextField *tFContrasenha;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargando;

@end
