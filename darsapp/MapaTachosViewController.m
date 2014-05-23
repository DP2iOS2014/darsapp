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

-(void) recuperaListaDeTachosDeTipo:(NSString*)tipoTacho{
    ////////
    //Hacer diccionario que paso llamado "consulta"
    self.cargando.alpha = 1;
    NSDictionary * cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"contenedor",@"tipo" , nil];
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@",consulta);
    
    //{"operacion":"Consulta","cuerpo" : { "tipo":"contenedor"}
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:UbicacionTachos parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        self.cargando.alpha = 0; 
        NSDictionary * diccionarioPosiciones = [respuesta objectForKey:@"cuerpo"];
        NSArray * arregloPosiciones = [diccionarioPosiciones objectForKey:@"listaNodos"];
        
        /*GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(, -77.080190);
        marker.title = @"CAPU";
        marker.snippet = @"Capilla";
        marker.map = mapView_; */
        
        ////////////

        for (int i=0; i<[arregloPosiciones count]; i++){
            
            NSString *lat = [[arregloPosiciones objectAtIndex:i] objectForKey:@"field_mm_latitud"];
            NSString *lon = [[arregloPosiciones objectAtIndex:i] objectForKey:@"field_mm_longitud"];
            NSString *tipo = [[arregloPosiciones objectAtIndex:i] objectForKey:@"tipo_contenedor"];
            double lt=[lat doubleValue];
            double ln=[lon doubleValue];
            NSString *name = [[arregloPosiciones objectAtIndex:i] objectForKey:@"title"];
            
            if([tipo isEqualToString:tipoTacho]){
                // Instantiate and set the GMSMarker properties
                GMSMarker *marker = [[GMSMarker alloc] init];
                marker.appearAnimation=YES;
                marker.position = CLLocationCoordinate2DMake(lt,ln);
                marker.title = name;
                marker.snippet = @"prueba";
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
            
        }
        //////////
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No choco con el servidor"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [arregloMarkers removeAllObjects];
    [mapView_ clear];
    [self.tipoSegmentControl setSelectedSegmentIndex:0];
    [self recuperaListaDeTachosDeTipo:@"Contenedor general"];
}

- (IBAction)cambioDeTacho:(UISegmentedControl *)sender {
    if([sender selectedSegmentIndex]==0){
        [arregloMarkers removeAllObjects];
        [mapView_ clear];
        [self recuperaListaDeTachosDeTipo:@"Contenedor general"];
    }else if([sender selectedSegmentIndex]==1){
        [arregloMarkers removeAllObjects];
        [mapView_ clear];
        [self recuperaListaDeTachosDeTipo:@"Contenedor de papel"];
    }else if([sender selectedSegmentIndex]==2){
        [arregloMarkers removeAllObjects];
        [mapView_ clear];
        [self recuperaListaDeTachosDeTipo:@"Contenedor de pilas"];
    }else if([sender selectedSegmentIndex]==3){
        [arregloMarkers removeAllObjects];
        [mapView_ clear];
        [self recuperaListaDeTachosDeTipo:@"Contenedor de plastico"];
    }else if([sender selectedSegmentIndex]==4){
        [arregloMarkers removeAllObjects];
        [mapView_ clear];
        [self recuperaListaDeTachosDeTipo:@"Contenedor de vidrio"];
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
