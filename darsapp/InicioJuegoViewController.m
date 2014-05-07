//
//  InicioJuegoViewController.m
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "InicioJuegoViewController.h"

@interface InicioJuegoViewController ()

@end

@implementation InicioJuegoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Diseño para el boton Empezar
    self.btnEmpezar.layer.cornerRadius = 8;
    //self.btnEmpezar.layer.borderWidth = 1;
    self.btnEmpezar.layer.borderColor = [UIColor blackColor].CGColor;
    
    CAGradientLayer *degradado = [CAGradientLayer layer];
    degradado.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor colorWithRed:0.0f/255.0f green:68.0f/255.0f blue:0.0f/255.0f alpha:0.8f].CGColor];
    degradado.frame = self.btnEmpezar.bounds;
    
    [self.btnEmpezar.layer insertSublayer:degradado atIndex:0];
    
    //Diseño para el boton Comenzar
    self.btnContinuar.layer.cornerRadius = 8;
    //self.btnContinuar.layer.borderWidth = 1;
    self.btnContinuar.layer.borderColor = [UIColor blackColor].CGColor;
    
    CAGradientLayer *degradado1 = [CAGradientLayer layer];
    degradado1.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor colorWithRed:0.0f/255.0f green:68.0f/255.0f blue:0.0f/255.0f alpha:0.8f].CGColor];
    degradado1.frame = self.btnContinuar.bounds;
    
    [self.btnContinuar.layer insertSublayer:degradado1 atIndex:0];
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
