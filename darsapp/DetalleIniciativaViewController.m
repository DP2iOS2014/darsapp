//
//  DetalleIniciativaViewController.m
//  darsapp
//
//  Created by inf227al on 11-06-14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "DetalleIniciativaViewController.h"
#import "URLsJson.h"
@interface DetalleIniciativaViewController ()

@end

@implementation DetalleIniciativaViewController

int puntajexusuario;

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
    
       [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
    
    self.starRating.backgroundColor  = [UIColor clearColor];
    self.starRating.starImage = [[UIImage imageNamed:@"leaf2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.starRating.starHighlightedImage = [[UIImage imageNamed:@"leaf"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.starRating.maxRating = 5.0;
    self.starRating.delegate = self;
    self.starRating.horizontalMargin = 15.0;
    self.starRating.editable=YES;
    self.starRating.rating= ((NSNumber*)self.puntuacion[self.celdaseleccionada-1]).floatValue /20;
    self.starRating.displayMode=EDStarRatingDisplayHalf;
    [self.starRating  setNeedsDisplay];
    self.starRating.tintColor = [[UIColor alloc] initWithRed:63.0/255.0 green:192.0/255.0 blue:169.0/255.0 alpha:1];
    [self starsSelectionChanged:self.starRating rating:((NSNumber*)self.puntuacion[self.celdaseleccionada-1]).intValue /20];
    
    //SETEAR AQUI EL ARREGLO TITULOS CUANDO SE LES OCURRA ARREGLAR EL JSON U.U
    self.lblIniciativa.text= self.titulos[self.celdaseleccionada-1];
    self.lblDescripcion.text=self.descripciones[self.celdaseleccionada-1];
    
}

- (IBAction)seApretoGuardar:(id)sender {
    
    NSInteger ratingAux = self.starRating.rating*20 ;
    NSNumber * rating = [[NSNumber alloc] initWithInteger:ratingAux];
    
    [self guardoRating:rating];
    
}



-(void) guardoRating:(NSNumber*)rating{
    NSUserDefaults * datosDeMemoria = [NSUserDefaults standardUserDefaults];
    NSString * NombreUsuario = [datosDeMemoria stringForKey:@"NombreUsuario"];
    
    
    NSDictionary * nodo = [NSDictionary dictionaryWithObjectsAndKeys: self.nidIniciativa,@"nid",rating,@"puntaje", nil];
    NSMutableArray * listaNodos = [[NSMutableArray alloc] init];
    [listaNodos addObject:nodo];
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys: listaNodos,@"listaNodos",NombreUsuario,@"username", nil];
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Accion", @"operacion", @"registro_votosxusuario",@"desc", cuerpo,@"cuerpo", nil];
    
    NSLog(@"%@", consulta);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:Buenaspracticas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
       NSDictionary * respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Mensaje"
                                                            message:@"Su iniciativa se guardo satisfactoriamente"
                                                           delegate:self
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating{
    puntajexusuario = rating*20;
}

- (IBAction)seMandoPuntuacion:(id)sender {
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Mandar Puntuación"
                                                        message:@"La Puntuación se envió con éxito"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    //[self guardoRating:rating];
}

@end
