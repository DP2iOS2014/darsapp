//
//  LoginViewController.h
//  darsapp
//
//  Created by inf227al on 25/04/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Login.h"
@interface LoginViewController : UIViewController<loginDelegate>
@property (strong, nonatomic) UITapGestureRecognizer *tap;

@property (weak, nonatomic) IBOutlet UITextField *tFusuario;
@property (weak, nonatomic) IBOutlet UITextField *tFContrasenha;
@property (weak, nonatomic) IBOutlet UILabel *txtUsuario;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cargando;
@property (weak, nonatomic) IBOutlet UILabel *txtPass;
@property (weak, nonatomic) IBOutlet UIButton *btnIngresar;
@property (weak, nonatomic) IBOutlet UIButton *btnVisitante;

@end
