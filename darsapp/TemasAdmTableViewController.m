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

@interface TemasAdmTableViewController ()

@end

@implementation TemasAdmTableViewController{

    NSDictionary * respuesta;
    NSDictionary *respuestatemas;
    NSMutableArray *arregloRespuesta;
    NSMutableArray *titulos;
    

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
    [self recuperoTemas];
    
    
    self.parentViewController.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
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
    return titulos.count ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CeldaTemas *cell = [tableView dequeueReusableCellWithIdentifier: @"CeldaTemas"];
    cell.lblTema.text=titulos[indexPath.row];
    return cell;
}

-(void) recuperoTemas{
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"tema_buenaspracticas", @"tipo", @[], @"filtro", nil];
    
        NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];

    NSLog(@"%@", consulta);
    
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
            NSString *nombreimagen = [[arregloPosiciones objectAtIndex:i] objectForKey:@"nombre_archivo"];
            
            [titulos addObject:titulo];
            
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

-(void) recuperaEcoTipsLider{

    //PARA ENVIAR PRIMI
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"buenaspracticas", @"tipo", nil];
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@", consulta);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:Buenaspracticas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        NSDictionary * diccionarioPosiciones = [respuesta objectForKey:@"cuerpo"];
        NSArray * arregloPosiciones = [diccionarioPosiciones objectForKey:@"listaNodos"];
        
        //PARA SACAR LOS DATOS
        
        for(int i=0; i<[arregloPosiciones count];i++){
        NSString *descripcion = [[arregloPosiciones objectAtIndex:i] objectForKey:@"descripcion"];
        NSString *titulo = [[arregloPosiciones objectAtIndex:i] objectForKey:@"title"];
        NSString *puntaje = [[arregloPosiciones objectAtIndex:i] objectForKey:@"puntaje"];
        NSString *tema = [[arregloPosiciones objectAtIndex:i] objectForKey:@"tema"];
        double punt=[puntaje doubleValue];
        double idtema;
            
        if ([tema isEqualToString:@"agua"]) {
            idtema=1;
        };
            if ([tema isEqualToString:@"espacios verdes"]) {
                idtema=2;
            };
            if ([tema isEqualToString:@"compras"]) {
                idtema=3;
            };
            if ([tema isEqualToString:@"energia"]) {
                idtema=4;
            };
            if ([tema isEqualToString:@"liderazgo"]) {
                idtema=5;
            };
            if ([tema isEqualToString:@"papeles"]) {
                idtema=6;
            };
            if ([tema isEqualToString:@"residuos solidos"]) {
                idtema=7;
            };
            if ([tema isEqualToString:@"aire y ruido"]) {
                idtema=8;
            };
            if ([tema isEqualToString:@"tranporte"]) {
                idtema=9;
            };
            
            
     
        
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
    
    if(indexPath.row<8)
    [self performSegueWithIdentifier:@"idsegue" sender:self];
    
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"idsegue"]){
    LiderAmbientalViewController *escenadestino = segue.destinationViewController;
    //escenadestino.respuestajson= respuesta;
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    escenadestino.indice= selectedIndexPath.row;
    }
    
};


@end
