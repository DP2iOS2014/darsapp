//
//  NuevaIniciativaViewController.m
//  darsapp
//
//  Created by inf227al on 11/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "NuevaIniciativaViewController.h"
#import "URLsJson.h"
@interface NuevaIniciativaViewController ()

@end

@implementation NuevaIniciativaViewController

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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [self.nombre resignFirstResponder];
    [self.descripcion resignFirstResponder];
}

- (IBAction)grabarIniciativas:(id)sender {
    [self grabaIniciativas:self.descripcion.text];
}

-(void) grabaIniciativas:(NSString*)descripcion{
    NSUserDefaults * datosDeMemoria = [NSUserDefaults standardUserDefaults];
    
    NSString * NombreUsuario = [datosDeMemoria stringForKey:@"NombreUsuario"];
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"guardariniciativa",@"tipo",NombreUsuario,@"username",descripcion,@"descripcion",self.nidTema,@"tema", nil];
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Almacenamiento",@"operacion",cuerpo,@"cuerpo", nil];
    
    NSLog(@"%@", consulta);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:Buenaspracticas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        NSDictionary * respuesta = responseObject;
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Se grabo con exito"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }
          failure:^(AFHTTPRequestOperation *task, NSError *error) {
              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No choco con el servidor"
                                                                  message:[error localizedDescription]
                                                                 delegate:nil
                                                        cancelButtonTitle:@"Ok"
                                                        otherButtonTitles:nil];
              [alertView show];
          }];
    
    
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
