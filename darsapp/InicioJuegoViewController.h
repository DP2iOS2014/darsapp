//
//  InicioJuegoViewController.h
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PrincipalDelegado <NSObject>

-(void)principalApretoBotonDerecho;

@end

@interface InicioJuegoViewController : UIViewController
@property (strong,nonatomic) id<PrincipalDelegado> miDelegado;
@property (weak, nonatomic) IBOutlet UIButton *btnEmpezar;
@property (weak, nonatomic) IBOutlet UIButton *btnContinuar;
@property (strong, nonatomic) IBOutlet UIButton *btnRanking;
@property (strong, nonatomic) IBOutlet UIButton *btnInstrucciones;
@property (weak, nonatomic) IBOutlet UILabel *ptjMaximo;


@property (strong, nonatomic) IBOutlet UIButton *pruebaBackButton;

@end
