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
    
    self.lblFecha.text = self.fecha[self.celda_seleccionada];
    
    [self.imagenEvento setImageWithURL:[NSURL URLWithString:self.urlImagenes[self.celda_seleccionada]] placeholderImage:[UIImage imageNamed:@"process.png"]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/dd/MM"];
    NSDate *date = [dateFormat dateFromString:self.fecha[self.celda_seleccionada]];
    NSString *dateToday = [dateFormat stringFromDate:[NSDate date]];
    
    self.lblFecha.text = dateToday;
    
    self.lblDescripcion.text = self.descripcion[self.celda_seleccionada];
    
    self.lblLugar.text = self.lugar[self.celda_seleccionada];
    
    if (((NSNumber*)(self.estado[self.celda_seleccionada])).intValue == 2) {
        [self.btnAsistir setTitle:@"Asistiré" forState:UIControlStateNormal];
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
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"config",@"usuario",nid,@"evento_nid",@"5555555",@"telefono", nil];
    
    NSDictionary * accion = [NSDictionary dictionaryWithObjectsAndKeys:@"Accion",@"operacion",cuerpo,@"cuerpo" , nil];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager POST:RecuperoTemas parameters:accion success:^(AFHTTPRequestOperation *task, id responseObject) {
       
        NSLog(@"JSON: %@", responseObject);

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
