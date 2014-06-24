//
//  EventosViewController.m
//  darsapp
//
//  Created by inf227al on 4/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "EventosViewController.h"
#import "URLsJson.h"
#import "CeldaTemas.h"
#import "UIImageView+AFNetworking.h"
#import "GrillaEventoViewController.h"

@interface EventosViewController ()

@end

typedef void (^myCompletion)(BOOL);

@implementation EventosViewController{
    
    NSDictionary * respuestajson;
    NSDictionary * respuestajson2;
    NSMutableArray * titulos;
    NSMutableArray * urlImagenes;
    
    NSMutableArray * descripcion;
    NSMutableArray * enlace;
    NSMutableArray * fecha;
    NSMutableArray * lugar;
    NSMutableArray * organizador;
    NSMutableArray * estado;
    NSMutableArray  * nids;
    
    
    NSMutableArray *titulos2;
    NSMutableArray *urlImagenes2;
    NSMutableArray * fecha2;
    NSMutableArray  * nids2;
    
    NSInteger  segindice;
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
    
    titulos = [[NSMutableArray alloc]init];
    titulos2 = [[NSMutableArray alloc]init];
    urlImagenes =[[NSMutableArray alloc]init];
    urlImagenes2 =[[NSMutableArray alloc]init];
    descripcion =[[NSMutableArray alloc]init];
    enlace =[[NSMutableArray alloc]init];
    fecha =[[NSMutableArray alloc]init];
    fecha2 =[[NSMutableArray alloc]init];
    lugar =[[NSMutableArray alloc]init];
    organizador =[[NSMutableArray alloc]init];
    estado =[[NSMutableArray alloc]init];
    nids =[[NSMutableArray alloc]init];
    nids2 =[[NSMutableArray alloc]init];
    //[self recuperoEventos:@1];
    //[self recuperoEventosProximos];
    
    /*[self myMethod:^(BOOL finished) {
        if (finished) {
            //[self recuperoEventosProximos];
        }
        
    }];*/
    
    [self recuperoEventos:@2];
    
    for(int i=0;i<nids.count;i++){
        for(int j=0;j<nids2.count;j++){
            if([nids2[j] isEqualToString:nids[i]]) {
                [nids2 removeObjectAtIndex:j];
                [titulos2 removeObjectAtIndex:j];
                [urlImagenes2 removeObjectAtIndex:j];
                [fecha2 removeObjectAtIndex:j];
            };
        }
    }
    
    [self cambiodeEvento:0];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
    
    self.tablaeventos.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//JSON para llamar a todos los eventos

-(void) recuperoEventosProximos {

    NSDictionary *cuerpo= [NSDictionary dictionaryWithObjectsAndKeys:@"evento",@"tipo", nil];
    
    NSDictionary *consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta", @"operacion",cuerpo,@"cuerpo", nil];
    
    NSLog(@"%@", consulta);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:RecuperoTemas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuestajson2 = responseObject;
        NSLog(@"JSON: %@", respuestajson2);
        
        NSDictionary * cuerpo = [respuestajson2 objectForKey:@"cuerpo"];
        NSArray * eventos = [cuerpo objectForKey:@"listaNodos"];
        
        
        for(int i = 0; i < eventos.count; i++){
            NSString * tituloEvento = [[eventos objectAtIndex:i]objectForKey:@"field_nombre_evento_value"];
            
            NSString *postFijo = [[eventos objectAtIndex:i] objectForKey:@"url_archivo"];
            
            NSString *urlImagen = [NSString stringWithFormat:@"%@%@",@"http://200.16.7.111/dp2/rc/",[postFijo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            NSString * fecha_evento = [[eventos objectAtIndex:i]objectForKey:@"field_fecha_evento_value"];
            
            NSNumber * nid = (NSNumber *)[[eventos objectAtIndex:i] objectForKey:@"nid"];
            
            [fecha2 addObject:fecha_evento];
            [titulos2 addObject:tituloEvento];
            [urlImagenes2 addObject:urlImagen];
            [nids2 addObject:nid];
        
        }
        
        //[self.tablaeventos reloadData];
        
        
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

-(void) recuperoEventos: (NSNumber*)estadoevento{
    
    NSUserDefaults * datosUsuario = [NSUserDefaults standardUserDefaults];
    
    NSString * usuario = [datosUsuario stringForKey:@"NombreUsuario"];
    NSString * contraseña = [datosUsuario stringForKey:@"ContraseñaUsuario"];
    
    if(!([usuario isEqualToString:@""] || usuario == nil) ){
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"evento",@"tipo",usuario,@"usuario", nil];
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@", consulta);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:RecuperoTemas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuestajson = responseObject;
        NSLog(@"JSON: %@", respuestajson);
        
        NSDictionary * cuerpo = [respuestajson objectForKey:@"cuerpo"];
        NSArray * eventos = [cuerpo objectForKey:@"listaNodos"];
        
        for(int i = 0; i < eventos.count; i++){
            
            NSString * tituloEvento = [[eventos objectAtIndex:i]objectForKey:@"field_nombre_evento_value"];
            
            NSString *postFijo = [[eventos objectAtIndex:i] objectForKey:@"url_archivo"];
            
            NSString *urlImagen = [NSString stringWithFormat:@"%@%@",@"http://200.16.7.111/dp2/rc/",[postFijo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            NSString * desc_evento = [[eventos objectAtIndex:i]objectForKey:@"field_descripcion_evento_value"];
            
            //NSString * enlace_evento = [[eventos objectAtIndex:i]objectForKey:@"field_enlace_evento_value"];
            
            NSString * fecha_evento = [[eventos objectAtIndex:i]objectForKey:@"field_fecha_evento_value"];
            
            NSString * lugar_evento = [[eventos objectAtIndex:i]objectForKey:@"field_lugar_evento_value"];
            
            NSString * organizador_evento = [[eventos objectAtIndex:i]objectForKey:@"field_organizador_evento_value"];
            
            NSNumber * estado_evento = (NSNumber*)[[eventos objectAtIndex:i]objectForKey:@"estado"];
            NSNumber * nid = (NSNumber *)[[eventos objectAtIndex:i] objectForKey:@"nid"];
            
            //NSNull * null;
            
               if(estadoevento.intValue == estado_evento.intValue){
                [descripcion addObject:desc_evento];
                //[enlace addObject:enlace_evento];
                [fecha addObject:fecha_evento];
                [lugar addObject:lugar_evento];
                [organizador addObject:organizador_evento];
                [estado addObject:estado_evento];
                [titulos addObject:tituloEvento];
                [urlImagenes addObject:urlImagen];
                [nids addObject:nid];
            
            
            }
        }
        [self recuperoEventosProximos];
        //[self.tablaeventos reloadData];
        
        
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
}

-(void) myMethod:(myCompletion) compblock {
    [self recuperoEventos:@2];
    compblock (YES);
    
}


- (IBAction)cambiodeEvento:(UISegmentedControl *)sender {
    if([sender selectedSegmentIndex]==0){
        segindice=0;
        [self.tablaeventos reloadData];

    }else if([sender selectedSegmentIndex]==1){
        segindice=1;
        [self.tablaeventos reloadData];
 
    }else if([sender selectedSegmentIndex]==2){
        segindice=2;
        [self.tablaeventos reloadData];

    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if(segindice==0) {
        if(titulos2.count>0)
            return titulos2.count;
        else return 1;
    }
    
    else if(segindice==1){
        if(titulos.count>0)
            return titulos.count;
        else return 1;
    }
    
    else return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier: @"celdaeventos"];
    
    if(segindice==0){
        
        if(titulos2.count>0){
            
            ((CeldaTemas*)cell).lblTema.text=titulos2[indexPath.row];
            [((CeldaTemas*)cell).imagen setImageWithURL:[NSURL URLWithString:urlImagenes2[indexPath.row]] placeholderImage:[UIImage imageNamed:@"process.png"]];
            [((CeldaTemas*)cell).imagen setHidden:NO];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier: @"celdaeventos"];
            ((CeldaTemas*)cell).lblTema.text=@"No hay eventos";
            [((CeldaTemas*)cell).imagen setHidden:YES];
            
        }
    
    }else if (segindice==1){
        
        if(titulos.count>0){
            
            ((CeldaTemas*)cell).lblTema.text=titulos[indexPath.row];
            [((CeldaTemas*)cell).imagen setImageWithURL:[NSURL URLWithString:urlImagenes[indexPath.row]] placeholderImage:[UIImage imageNamed:@"process.png"]];
            [((CeldaTemas*)cell).imagen setHidden:NO];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier: @"celdaeventos"];
            ((CeldaTemas*)cell).lblTema.text=@"No hay eventos";
            [((CeldaTemas*)cell).imagen setHidden:YES];
            
        }
    
    }
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row<titulos.count && titulos.count>0)
        [self performSegueWithIdentifier:@"idsegue" sender:self];
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"idsegue"]){
        GrillaEventoViewController *escenadestino = segue.destinationViewController;
        //escenadestino.respuestajson= respuesta;
        
        escenadestino.titulos = [[NSMutableArray alloc] initWithArray: titulos];
        escenadestino.urlImagenes = [[NSMutableArray alloc] initWithArray: urlImagenes];
        escenadestino.descripcion = [[NSMutableArray alloc] initWithArray: descripcion];
        escenadestino.enlace = [[NSMutableArray alloc] initWithArray: enlace];
        escenadestino.fecha = [[NSMutableArray alloc] initWithArray: fecha];
        escenadestino.lugar = [[NSMutableArray alloc] initWithArray: lugar];
        escenadestino.organizador = [[NSMutableArray alloc] initWithArray: organizador];
        escenadestino.estado = [[NSMutableArray alloc] initWithArray: estado];
        NSIndexPath *selectedIndexPath = [self.tablaeventos indexPathForSelectedRow];
        escenadestino.celda_seleccionada = selectedIndexPath.row;
        escenadestino.nidseleccionado = [nids objectAtIndex:selectedIndexPath.row];
    }
    
};

@end
