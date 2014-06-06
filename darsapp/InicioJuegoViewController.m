//
//  InicioJuegoViewController.m
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "InicioJuegoViewController.h"
#import "SingletonJuego.h"
@interface InicioJuegoViewController ()

@end

@implementation InicioJuegoViewController{
    
    SingletonJuego * juego;
    
}

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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
    // Do any additional setup after loading the view.
    
    
    UIImage *original = self.pruebaBackButton.imageView.image;
    
    [self.pruebaBackButton setImage:[original imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
}
- (IBAction)apreteBoniBackButton:(UIButton *)sender {
    
    UIActionSheet *a = [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:nil];
    
    [a showInView:self.view];
    
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
    //self.btnEmpezar.layer.cornerRadius = 4;
    //self.btnEmpezar.layer.borderWidth = 3;
    //self.btnEmpezar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    /*CAGradientLayer *degradado = [CAGradientLayer layer];
    degradado.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor colorWithRed:0.0f/255.0f green:68.0f/255.0f blue:0.0f/255.0f alpha:0.8f].CGColor];
    degradado.frame = self.btnEmpezar.bounds;
    
    [self.btnEmpezar.layer insertSublayer:degradado atIndex:0];
    
    //Diseño para el boton Comenzar
    self.btnContinuar.layer.cornerRadius = 4;
    self.btnContinuar.layer.borderWidth = 3;
    self.btnContinuar.layer.borderColor = [UIColor whiteColor].CGColor;
    
    CAGradientLayer *degradado1 = [CAGradientLayer layer];
    degradado1.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor colorWithRed:0.0f/255.0f green:68.0f/255.0f blue:0.0f/255.0f alpha:0.8f].CGColor];
    degradado1.frame = self.btnContinuar.bounds;
    
    [self.btnContinuar.layer insertSublayer:degradado1 atIndex:0];
    
    //Diseño para el boton Ranking
    self.btnRanking.layer.cornerRadius = 4;
    self.btnRanking.layer.borderWidth = 3;
    self.btnRanking.layer.borderColor = [UIColor whiteColor].CGColor;
    
    CAGradientLayer *degradado3 = [CAGradientLayer layer];
    degradado3.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor colorWithRed:0.0f/255.0f green:68.0f/255.0f blue:0.0f/255.0f alpha:0.8f].CGColor];
    degradado3.frame = self.btnRanking.bounds;
    
    [self.btnRanking.layer insertSublayer:degradado3 atIndex:0];
    
    
    //Diseño para el boton Instrucciones
    self.btnInstrucciones.layer.cornerRadius = 4;
    self.btnInstrucciones.layer.borderWidth = 3;
    self.btnInstrucciones.layer.borderColor = [UIColor whiteColor].CGColor;
    
    CAGradientLayer *degradado4 = [CAGradientLayer layer];
    degradado4.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor colorWithRed:0.0f/255.0f green:68.0f/255.0f blue:0.0f/255.0f alpha:0.8f].CGColor];
    degradado4.frame = self.btnInstrucciones.bounds;
    
    [self.btnInstrucciones.layer insertSublayer:degradado4 atIndex:0];*/
    

        
        NSUserDefaults * datosDeUsuario = [NSUserDefaults standardUserDefaults];
        
    
        double puntajeMaximo = [datosDeUsuario doubleForKey:@"puntajeMaximoRuleta"];
        
        self.ptjMaximo.text = [NSString stringWithFormat:@"%0.2f",puntajeMaximo];
    
}


- (IBAction)btnEmpezarJuego:(id)sender {
    
     juego = [SingletonJuego sharedManager];
        [SingletonJuego ResetearValores];
    
     [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"puntajeActualJuegoRuleta"];
    
    [[NSUserDefaults standardUserDefaults] setInteger:3 forKey:@"vidasJuegoRuleta"];
    
    
    [self performSegueWithIdentifier:@"escena_juego" sender:self];
    
}
- (IBAction)btnContinuarJuego:(id)sender {
    
     [self performSegueWithIdentifier:@"escena_juego" sender:self];
    
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
