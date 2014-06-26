//
//  GrillaEventoViewController.m
//  darsapp
//
//  Created by inf227al on 5/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "GrillaEventoViewController.h"
#import "URLsJson.h"
#import "UIImageView+AFNetworking.h"

@interface GrillaEventoViewController ()

@end

@implementation GrillaEventoViewController

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
    self.lblTitulo.text = self.titulos[self.celda_seleccionada];
    
    //self.lblFecha.text = self.fecha[self.celda_seleccionada];
    
    [self.imagenEvento setImageWithURL:[NSURL URLWithString:self.urlImagenes[self.celda_seleccionada]] placeholderImage:[UIImage imageNamed:@"process.png"]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"dd/MM/yyyy"];
    
    NSDateFormatter *dateFormat3 = [[NSDateFormatter alloc] init];
    [dateFormat3 setDateFormat:@"HH:mm:ss"];
    
    NSDate *date = [dateFormat dateFromString:self.fecha[self.celda_seleccionada]];
    NSString *date2 = [dateFormat2 stringFromDate:date];
    
    NSString *hora = [dateFormat3 stringFromDate:date];
    
    self.lblFecha.text = date2;
    
    self.lblHora.text = hora;
    
    self.lblDescripcion.text = self.descripcion[self.celda_seleccionada];
    
    self.lblLugar.text = self.lugar[self.celda_seleccionada];
    
    if (((NSNumber*)(self.estado[self.celda_seleccionada])).intValue == 2) {
        [self.btnAsistir setTitle:@"No Asistiré" forState:UIControlStateNormal];
        [self.btnAsistir setHidden:NO];
        [self.checkAsistir setHidden:NO];
    }
    else if (((NSNumber*)(self.estado[self.celda_seleccionada])).intValue == 3){

        [self.btnAsistir setHidden:YES];
        [self.checkAsistir setHidden:YES];
    } else {
        [self.btnAsistir setTitle:@"No Asistiré" forState:UIControlStateNormal];
        [self.btnAsistir setHidden:NO];
        [self.checkAsistir setHidden:NO];
    }
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)RegistrarEvento:(id)sender {
    
    
    
    NSNumber * nid =self.nidseleccionado;
    
    NSUserDefaults * datos = [NSUserDefaults standardUserDefaults];
    NSString * nombre = [datos stringForKey:@"NombreUsuario"];
    
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:nombre,@"usuario",@"registrar_evento",@"tipo",self.estado[self.celda_seleccionada], @"asistir",nid,@"nid", nil];
    
    NSDictionary * accion = [NSDictionary dictionaryWithObjectsAndKeys:@"Accion",@"operacion",cuerpo,@"cuerpo" , nil];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager POST:RecuperoTemas parameters:accion success:^(AFHTTPRequestOperation *task, id responseObject) {
       
        NSLog(@"JSON: %@", responseObject);
        
        if(self.estado[self.celda_seleccionada]==1){
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"El evento se registró correctamente"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Se deseleccionó el evento correctamente"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        
        }

    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
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
