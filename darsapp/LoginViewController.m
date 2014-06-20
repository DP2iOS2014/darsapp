//
//  LoginViewController.m
//  darsapp
//
//  Created by inf227al on 25/04/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "LoginViewController.h"
#import "URLsJson.h"
#import "Login.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    NSDictionary * respuesta;
    Login *objetoLogin;
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
    // Do any additional setup after loading the view.
    objetoLogin = [Login sharedManager];
    objetoLogin.delegate = self;
    
    self.cargando.alpha = 0 ;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
     [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondologin.jpg"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dismissKeyboard {
    [self.tFusuario resignFirstResponder];
    [self.tFContrasenha resignFirstResponder];
}


- (void) viewWillAppear:(BOOL)animated{
    NSUserDefaults * datosDeMemoria = [NSUserDefaults standardUserDefaults];
    
    NSString * NombreUsuario = [datosDeMemoria stringForKey:@"NombreUsuario"];
    
    NSString * ContraseñaUsuario = [datosDeMemoria stringForKey:@"ContraseñaUsuario"];
    
    
    if(![NombreUsuario  isEqual: @""] && ![ContraseñaUsuario  isEqual: @""] && NombreUsuario != nil && ContraseñaUsuario != nil) {
    self.cargando.alpha = 1 ;
    // Arreglo de los indices(indices son Strings)
        [Login jsonLoginConUsuarioPersistente:NombreUsuario yPassword:ContraseñaUsuario];
        
    }
    
    
}

- (void) viewWillDisappear:(BOOL)animated{
    
    
    
}
- (IBAction)ApretoVisitante:(id)sender {
    [[NSUserDefaults standardUserDefaults] setObject:@"S" forKey:@"Visitante"];
    [self performSegueWithIdentifier:@"exito_login" sender:self];
    
}


- (IBAction)ApretoIngresar:(id)sender {
    self.cargando.alpha = 1 ;
    // Arreglo de los indices(indices son Strings)
    
    [Login jsonLoginConUsuario:self.tFusuario.text yPassword:self.tFContrasenha.text];

    
}

-(void)loginExito{
    [self performSegueWithIdentifier:@"exito_login" sender:self];
}

-(void)loginFallo:(NSString *)mensaje{
    UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
     [miAlert show];
    
    self.cargando.alpha = 0 ;
}

-(void)falloServidor{
     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Fallo en el servicio" message:nil
     delegate:nil
     cancelButtonTitle:@"Ok"
     otherButtonTitles:nil];
    [alertView show];
    self.cargando.alpha = 0 ;
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
