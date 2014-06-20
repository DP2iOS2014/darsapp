//
//  MapaTachosViewController.m
//  darsapp
//
//  Created by inf227al on 7/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "MapaTachosViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "URLsJson.h"
#import "Tacho.h"

@interface MapaTachosViewController ()

@end

@implementation MapaTachosViewController
{
    GMSMapView *mapView_;
    NSDictionary * respuesta;
    NSMutableArray * arregloMarkers;
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
    
    
    //[self recuperaListaDeTachos];
    //self.cargando.alpha = 0;
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-12.068938
                                                            longitude:-77.080190
                                                                 zoom:15.60];
    mapView_ = [GMSMapView mapWithFrame:self.mapView.bounds camera:camera];
    mapView_.myLocationEnabled = YES;
    [self.mapView addSubview: mapView_];
    
    [self muestraListaDeTachosDeTipo:@"Contenedor general"];
    
    /*GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-12.068938, -77.080190);
    marker.title = @"CAPU";
    marker.snippet = @"Capilla";
    marker.map = mapView_; */
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) muestraListaDeTachosDeTipo:(NSString*)tipoTacho{
    
        NSArray * arrTachos = [Tacho all];
    
    
        for (int i=0; i<[arrTachos count]; i++){
            NSLog(@"%@",((Tacho*)arrTachos[i]).descripcion);
            if([((Tacho*)arrTachos[i]).tipo isEqualToString:tipoTacho]){
                
                GMSMarker *marker = [[GMSMarker alloc] init];
                marker.appearAnimation=YES;
                marker.position = CLLocationCoordinate2DMake(((Tacho*)arrTachos[i]).lt.doubleValue,((Tacho*)arrTachos[i]).ln.doubleValue);
                
                marker.title = ((Tacho*)arrTachos[i]).descripcion;
                if([tipoTacho isEqualToString:@"Contenedor general"]){
                    marker.icon = [UIImage imageNamed:@"tachito.png"];
                }else if ([tipoTacho isEqualToString:@"Contenedor de papel"]){
                    marker.icon = [UIImage imageNamed:@"tachito5.png"];
                }else if ([tipoTacho isEqualToString:@"Contenedor de pilas"]){
                    marker.icon = [UIImage imageNamed:@"tachito4.png"];
                }else if ([tipoTacho isEqualToString:@"Contenedor de plastico"]){
                    marker.icon = [UIImage imageNamed:@"tachito3.png"];
                }else if ([tipoTacho isEqualToString:@"Contenedor de vidrio"]){
                    marker.icon = [UIImage imageNamed:@"tachito2.png"];
                }
                marker.map = mapView_;
                [arregloMarkers addObject:marker];
                
            }
            
            if([tipoTacho isEqualToString:@"Todos"]){
                // Instantiate and set the GMSMarker properties
                GMSMarker *marker = [[GMSMarker alloc] init];
                marker.appearAnimation=YES;
                marker.position = CLLocationCoordinate2DMake(((Tacho*)arrTachos[i]).lt.doubleValue,((Tacho*)arrTachos[i]).ln.doubleValue);
                marker.title = ((Tacho*)arrTachos[i]).descripcion;
                //marker.snippet = @"prueba";
                if([((Tacho*)arrTachos[i]).tipo isEqualToString:@"Contenedor general"]){
                    marker.icon = [UIImage imageNamed:@"tachito.png"];
                }else if ([((Tacho*)arrTachos[i]).tipo isEqualToString:@"Contenedor de papel"]){
                    marker.icon = [UIImage imageNamed:@"tachito5.png"];
                }else if ([((Tacho*)arrTachos[i]).tipo isEqualToString:@"Contenedor de pilas"]){
                    marker.icon = [UIImage imageNamed:@"tachito4.png"];
                }else if ([((Tacho*)arrTachos[i]).tipo isEqualToString:@"Contenedor de plastico"]){
                    marker.icon = [UIImage imageNamed:@"tachito3.png"];
                }else if ([((Tacho*)arrTachos[i]).tipo isEqualToString:@"Contenedor de vidrio"]){
                    marker.icon = [UIImage imageNamed:@"tachito2.png"];
                }
                marker.map = mapView_;
                [arregloMarkers addObject:marker];
                
            }
            
        }
    
        
}
    



-(void)actualizaTachos{
    NSUserDefaults * datosDeMemoria = [NSUserDefaults standardUserDefaults];
    NSString * fechaUltimaActualizacion = [datosDeMemoria stringForKey:@"ultActualizacionTachos"];
    

    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"contenedor",@"tipo", @"incremental",@"forma",fechaUltimaActualizacion ,@"fecha", nil];
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@", consulta);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:RecuperoTemas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        NSDictionary * respuestajson = responseObject;
        NSLog(@"JSON: %@", respuestajson);
        
        NSDictionary * cuerpo = [respuestajson objectForKey:@"cuerpo"];
        NSArray * listaNodos = [cuerpo objectForKey:@"listaNodos"];
        
        for(int i = 0; i < listaNodos.count; i++){
            
            NSString *lat = [[listaNodos objectAtIndex:i] objectForKey:@"latitud"];
            NSString *lon = [[listaNodos objectAtIndex:i] objectForKey:@"longitud"];
            NSString *tipo = [[listaNodos objectAtIndex:i] objectForKey:@"tipo_tacho"];
            double lt=[lat doubleValue];
            double ln=[lon doubleValue];
            NSString *name = [[listaNodos objectAtIndex:i] objectForKey:@"title"];
            NSString *fecha = [[listaNodos objectAtIndex:i] objectForKey:@"fecha_modificacion"];
            NSString *nid = [[listaNodos objectAtIndex:i] objectForKey:@"nid"];
            
            Tacho * tacho = [Tacho create];
            
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSDate * dateNotFormatted = [format dateFromString:fecha];
            
            tacho.descripcion = name;
            tacho.fecha = dateNotFormatted;
            
            
            tacho.lt = [[NSNumber alloc] initWithDouble: lt];
            tacho.ln = [[NSNumber alloc] initWithDouble: ln];
            tacho.tipo = tipo;
            tacho.nid= [[NSNumber alloc] initWithInt: nid.intValue];
            
            NSDate *now = [NSDate date];
            NSDateFormatter *formato = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSString *dateString = [formato stringFromDate:now];
            
            [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"ultActualizacionTachos"];

            //Agregar los tachos a coredata
            
        }
        
        [[IBCoreDataStore mainStore] save];
        
        NSInteger indice = [self.tipoSegmentControl selectedSegmentIndex];
        if(indice==0){
            [arregloMarkers removeAllObjects];
            [mapView_ clear];
            [self muestraListaDeTachosDeTipo:@"Contenedor general"];
        }else if(indice==1){
            [arregloMarkers removeAllObjects];
            [mapView_ clear];
            [self muestraListaDeTachosDeTipo:@"Contenedor de papel"];
        }else if(indice==2){
            [arregloMarkers removeAllObjects];
            [mapView_ clear];
            [self muestraListaDeTachosDeTipo:@"Contenedor de pilas"];
            
        }else if(indice==3){
            [arregloMarkers removeAllObjects];
            [mapView_ clear];
            [self muestraListaDeTachosDeTipo:@"Contenedor de plastico"];
            
        }else if(indice==4){
            [arregloMarkers removeAllObjects];
            [mapView_ clear];
            [self muestraListaDeTachosDeTipo:@"Contenedor de vidrio"];
        }else if (indice==5){
            [arregloMarkers removeAllObjects];
            [mapView_ clear];
            [self muestraListaDeTachosDeTipo:@"Todos"];
            
        }

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


- (IBAction)actualizarMapa:(id)sender {
    [self actualizaTachos];
    
}



-(void)viewWillAppear:(BOOL)animated{
    //[arregloMarkers removeAllObjects];
    //[mapView_ clear];
    //[self.tipoSegmentControl setSelectedSegmentIndex:0];
    //[self recuperaListaDeTachosDeTipo:@"Contenedor general"];
}

- (IBAction)cambioDeTacho:(UISegmentedControl *)sender {
    if([sender selectedSegmentIndex]==0){
        [arregloMarkers removeAllObjects];
        [mapView_ clear];
        [self muestraListaDeTachosDeTipo:@"Contenedor general"];
    }else if([sender selectedSegmentIndex]==1){
        [arregloMarkers removeAllObjects];
        [mapView_ clear];
        [self muestraListaDeTachosDeTipo:@"Contenedor de papel"];
    }else if([sender selectedSegmentIndex]==2){
        [arregloMarkers removeAllObjects];
        [mapView_ clear];
        [self muestraListaDeTachosDeTipo:@"Contenedor de pilas"];
    }else if([sender selectedSegmentIndex]==3){
        [arregloMarkers removeAllObjects];
        [mapView_ clear];
        [self muestraListaDeTachosDeTipo:@"Contenedor de plastico"];
    }else if([sender selectedSegmentIndex]==4){
        [arregloMarkers removeAllObjects];
        [mapView_ clear];
        [self muestraListaDeTachosDeTipo:@"Contenedor de vidrio"];
    }else if([sender selectedSegmentIndex]==5){
        [arregloMarkers removeAllObjects];
        [mapView_ clear];
        [self muestraListaDeTachosDeTipo:@"Todos"];
    }
}


- (IBAction)cerrarSesion:(id)sender {
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Cerrar Sesión"
                                                        message:@"Está seguro que desea cerrar sesión?"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Si",nil];
    [alertView show];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1){
        
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                      bundle:nil];
        UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"login"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"netin"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"netalu"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Visitante"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"NombreUsuario"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ContraseñaUsuario"];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
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
