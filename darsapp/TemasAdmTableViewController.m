//
//  TemasAdmTableViewController.m
//  darsapp
//
//  Created by inf227al on 21/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "TemasAdmTableViewController.h"
#import "URLsJson.h"
#import "LiderAmbientalViewController.h"
#import "CeldaTemas.h"
#import "UIImageView+AFNetworking.h"
#import "puntajeAdministradorViewController.h"
#import "SingletonAmbientalizate.h"

@interface TemasAdmTableViewController ()

@end

@implementation TemasAdmTableViewController{

    NSDictionary * respuesta;
    NSDictionary *respuestatemas;
    NSMutableArray *arregloRespuesta;
    NSMutableArray *titulos;
    NSMutableArray *nombresimagenes;
    NSMutableArray * urlImagenes;
    NSMutableArray * nidsTema;

    NSMutableArray *buenaspracticas;
    NSMutableArray *puntajesBP;
    NSMutableArray *estadosBP;
    NSMutableArray *nidsBP;
    NSMutableArray *nidsTemaUsuario;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self recuperaEcoTipsLider];
    titulos = [[NSMutableArray alloc] init];
    nombresimagenes= [[NSMutableArray alloc] init];
    urlImagenes = [[NSMutableArray alloc] init];
    nidsTema = [[NSMutableArray alloc] init];
    
    buenaspracticas= [[NSMutableArray alloc] init];
    puntajesBP= [[NSMutableArray alloc] init];
    estadosBP= [[NSMutableArray alloc] init];
    nidsBP= [[NSMutableArray alloc] init];
    nidsTemaUsuario= [[NSMutableArray alloc] init];
    
    [self recuperoTemas];
    
    
    self.parentViewController.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) viewWillAppear:(BOOL)animated{
    
    NSUserDefaults * datosDeMemoria = [NSUserDefaults standardUserDefaults];
    
    double puntajeActual = [datosDeMemoria doubleForKey:@"puntajeAcumulado"];
    
    self.puntaje.text = [NSString stringWithFormat:@"%0.2f", puntajeActual];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return (titulos.count + 1) ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell ;
    if(indexPath.row < titulos.count){
        cell = [tableView dequeueReusableCellWithIdentifier: @"CeldaTemas"];
        ((CeldaTemas*)cell).lblTema.text=titulos[indexPath.row];
        
        
        
        [((CeldaTemas*)cell).imagen setImageWithURL:[NSURL URLWithString:urlImagenes[indexPath.row]] placeholderImage:[UIImage imageNamed:@"congruent_pentagon"]];
       // ((CeldaTemas*)cell).imagen.image=[UIImage imageNamed:nombresimagenes[indexPath.row]];

    }else{
        cell = [tableView dequeueReusableCellWithIdentifier: @"celdaguardar"];
    }

    return cell;
}

-(void) recuperoTemas{
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"tema_buenaspracticas", @"tipo", @[], @"filtro", nil];
    
        NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];

    NSLog(@"%@", consulta);
    
    
    @try {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        
        [manager POST:RecuperoTemas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
            respuestatemas = responseObject;
            NSLog(@"JSON: %@", respuestatemas);
            
            NSDictionary * diccionarioPosiciones = [respuestatemas objectForKey:@"cuerpo"];
            NSArray * arregloPosiciones = [diccionarioPosiciones objectForKey:@"listaNodos"];
            
            //PARA SACAR LOS DATOS
            
            for(int i=0; i<[arregloPosiciones count];i++){
                NSString *titulo = [[arregloPosiciones objectAtIndex:i] objectForKey:@"title"];
                NSNumber* nid = [[arregloPosiciones objectAtIndex:i] objectForKey:@"nid"];
                NSString *nombreimagen = [[arregloPosiciones objectAtIndex:i] objectForKey:@"nombre_archivo"];
                
                NSString *postFijo = [[arregloPosiciones objectAtIndex:i] objectForKey:@"url_archivo"];
                
                NSString *urlImagen = [NSString stringWithFormat:@"%@%@",@"http://200.16.7.111/dp2/rc/",[postFijo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                
                [titulos addObject:titulo];
                [nombresimagenes addObject:nombreimagen];
                [urlImagenes addObject:urlImagen];
                [nidsTema addObject:nid];
                
            }
            
            [self.tableView reloadData];
            
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
    @catch (NSException *exception) {
        NSLog( @"NSException caught" );
        NSLog( @"Name: %@", exception.name);
        NSLog( @"Reason: %@", exception.reason );
        return;
    }
    @finally {
        NSLog( @"In finally block");
    }
    
    
    NSUserDefaults * datos = [NSUserDefaults standardUserDefaults];
    NSString * nombre = [datos stringForKey:@"NombreUsuario"];
    NSDictionary *cuerpoBP = [NSDictionary dictionaryWithObjectsAndKeys: nombre,@"usuario",@"consulta_buenaspracticasxusuario",@"tipo",nil];
    
    NSDictionary *consultaBP = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpoBP, @"cuerpo", nil];
    
    
    NSLog(@"%@", consultaBP);
    
    [[NSUserDefaults standardUserDefaults] setDouble:0.0  forKey:@"puntajeAcumulado"];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:Buenaspracticas parameters:consultaBP success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        NSDictionary * diccionarioPosiciones = [respuesta objectForKey:@"cuerpo"];
        NSArray * arregloPosiciones = [diccionarioPosiciones objectForKey:@"lista"];
        
        double puntajeMaximo = 0;
        for(int i=0; i<[arregloPosiciones count];i++){
            
            NSString *titulo = [[arregloPosiciones objectAtIndex:i] objectForKey:@"titulo"];
            NSString *puntaje = [[arregloPosiciones objectAtIndex:i] objectForKey:@"puntaje"];
            NSNumber *estado = [[arregloPosiciones objectAtIndex:i] objectForKey:@"estado"];
            NSNumber * nidBP = [[arregloPosiciones objectAtIndex:i] objectForKey:@"id_buenaPractica"];
            NSNumber * nidTemaUsuario = [[arregloPosiciones objectAtIndex:i] objectForKey:@"id_temaBP"];
            
            [buenaspracticas addObject:titulo];
            [puntajesBP   addObject:puntaje];
            [estadosBP addObject:estado];
            [nidsBP addObject:nidBP];
            [nidsTemaUsuario addObject:nidTemaUsuario];
            
            if ([[estadosBP objectAtIndex:i] integerValue] == 1){
                puntajeMaximo = puntajeMaximo + [puntaje doubleValue];
                
                [[NSUserDefaults standardUserDefaults] setDouble:puntajeMaximo  forKey:@"puntajeAcumulado"];

            }
            
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row<titulos.count)
    [self performSegueWithIdentifier:@"idsegue" sender:self];
    
    
}
- (IBAction)SeApretoGuardar:(id)sender {
    
    [self performSegueWithIdentifier:@"verpuntaje" sender:self];
    
    //AQUI SE ENVIA EL JSON CON LOS PUNTAJES Y LOS NIDS
    
    SingletonAmbientalizate *singleton = [SingletonAmbientalizate sharedManager:1];
    
    NSMutableArray *nidsjson;
    NSMutableArray *activosjson;
    
    activosjson = [[NSMutableArray alloc] init];
    nidsjson = [[NSMutableArray alloc] init];
    
    
    for(int i=0;i<singleton.ArregloEstados.count;i++){
        if ( [singleton.ArregloEstados[i] count] != 0 ) {
            [activosjson addObject:singleton.ArregloEstados[i][0]];
            [nidsjson addObject:singleton.ArregloNids[i][0]];
        }
    
    }
    
    
    NSMutableArray *arreglo = [[NSMutableArray alloc] init];
    NSDictionary *lista;
    
    
    for(int i=0; i<nidsjson.count ; i++){
        lista = [NSDictionary dictionaryWithObjectsAndKeys:nidsjson[i], @"nid", activosjson[i], @"activo", nil];
        [arreglo addObject:lista];
    }
  
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"config", @"admin", lista, @"listaNodos", nil];
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Accion",@"operacion",@"registro_votoxusuario",@"desc",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@", consulta);
    
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"idsegue"]){
        
        LiderAmbientalViewController *escenadestino = segue.destinationViewController;
        //escenadestino.respuestajson= respuesta;
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
        escenadestino.indiceTema= selectedIndexPath.row;
        escenadestino.tituloTema= [titulos objectAtIndex:selectedIndexPath.row];
        escenadestino.cantidadFilas = titulos.count;
        escenadestino.nidTemaSeleccionado = ((NSNumber*)[nidsTema objectAtIndex:selectedIndexPath.row]).integerValue;
        
        escenadestino.buenaspracticas = [[NSMutableArray alloc] initWithArray:buenaspracticas];
        escenadestino.puntajesBP = [[NSMutableArray alloc] initWithArray:puntajesBP];
        escenadestino.estadosBP = [[NSMutableArray alloc] initWithArray:estadosBP];
        escenadestino.nidsBP = [[NSMutableArray alloc] initWithArray:nidsBP];
        escenadestino.nidsTemaUsuario = [[NSMutableArray alloc] initWithArray:nidsTemaUsuario];
    }
    else if([segue.identifier isEqual:@"verpuntaje"]){
        puntajeAdministradorViewController * escenadestino = segue.destinationViewController;
       escenadestino.cantidadFilas = titulos.count;
   }
    
};


@end
