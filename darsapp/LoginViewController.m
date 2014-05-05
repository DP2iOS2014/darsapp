//
//  LoginViewController.m
//  darsapp
//
//  Created by inf227al on 25/04/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "LoginViewController.h"
#import "URLsJson.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    NSDictionary * respuesta;
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
     [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"grey_sandbag.png"]]];
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


- (IBAction)ApretoIngresar:(id)sender {
    // Arreglo de los indices(indices son Strings)
    NSArray *keys = [NSArray arrayWithObjects:@"hacer", @"username",@"password", nil];
    // Arreglo de los objeto que se tendran dentro del diccionario
    NSArray *objects = [NSArray arrayWithObjects:@"login" ,self.tFusuario.text, self.tFContrasenha.text, nil];
    //Primera forma de inicializar un diccionario pasandole un arreglo de indices y de objetos
    NSDictionary *dictionaryUsuario = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    //Segunda forma de inicializar un diccionario pasandole primero un indice y luego un objeto y asi consecutivamente
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys: dictionaryUsuario, @"cuerpo",@"Autenticacion", @"operacion", nil];
    
    //NSArray *keys = [NSArray arrayWithObjects:@"ApiToken", @"IdUsuarioLog", nil];
    //NSArray *objects = [NSArray arrayWithObjects:@"6aa83532910737795239f1d30cb9c0f6493c60bc" ,@106,  nil];
    //NSDictionary *consulta = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    //{"ApiToken":"6aa83532910737795239f1d30cb9c0f6493c60bc","IdUsuarioLog":106}
    NSLog(@"JSON: %@", consulta);
    
    //NSURL *URL = [NSURL URLWithString:login];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:login parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        if (((NSString*)[[respuesta objectForKey:@"cuerpo"] objectForKey:@"netin"]).intValue == 1) {
            [self performSegueWithIdentifier:@"exito_login" sender:self];
        }else if([self.tFusuario.text isEqualToString:@""] && [self.tFContrasenha.text isEqualToString:@""]){
            //Falta colocar usuario y contrasena
            
            UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Debe ingresar Usuario y/o Contraseña" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [miAlert show];
            
        }else if([self.tFusuario.text isEqualToString:@""] && ![self.tFContrasenha.text isEqualToString:@""]){
            //Falta colocar usuario
            
            UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Debe ingresar Usuario" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [miAlert show];
            
        }else if(![self.tFusuario.text isEqualToString:@""] && [self.tFContrasenha.text isEqualToString:@""]){
            //Falta colocar contrasenha
            UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Debe ingresar Contraseña" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [miAlert show];
        }
        else {
            UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Usuario o contraseña incorrecta" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [miAlert show];
        }

    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No choco con el servidor"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    //////////
    NSLog(@"%@",respuesta);
    
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
