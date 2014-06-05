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

@implementation EventosViewController{
    
    NSDictionary * respuestajson;
    NSMutableArray * titulos;
    NSMutableArray * urlImagenes;
    
    NSMutableArray * descripcion;
    NSMutableArray * enlace;
    NSMutableArray * fecha;
    NSMutableArray * lugar;
    NSMutableArray * organizador;
    NSMutableArray * estado;
    
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
    urlImagenes =[[NSMutableArray alloc]init];
    descripcion =[[NSMutableArray alloc]init];
    enlace =[[NSMutableArray alloc]init];
    fecha =[[NSMutableArray alloc]init];
    lugar =[[NSMutableArray alloc]init];
    organizador =[[NSMutableArray alloc]init];
    estado =[[NSMutableArray alloc]init];
    [self recuperoEventos];
    // Do any additional setup after loading the view.
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

-(void) recuperoEventos{
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"evento",@"tipo",@"config",@"usuario", nil];
    
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
            
            NSString * enlace_evento = [[eventos objectAtIndex:i]objectForKey:@"field_enlace_evento_value"];
            
            NSString * fecha_evento = [[eventos objectAtIndex:i]objectForKey:@"field_fecha_evento_value"];
            
            NSString * lugar_evento = [[eventos objectAtIndex:i]objectForKey:@"field_lugar_evento_value"];
            
            NSString * organizador_evento = [[eventos objectAtIndex:i]objectForKey:@"field_organizador_evento_value"];
            
            NSNumber * estado_evento = [[eventos objectAtIndex:i]objectForKey:@"estado"];
            
            [descripcion addObject:desc_evento];
            [enlace addObject:enlace_evento];
            [fecha addObject:fecha_evento];
            [lugar addObject:lugar_evento];
            [organizador addObject:organizador_evento];
            [estado addObject:estado_evento];
            [titulos addObject:tituloEvento];
            [urlImagenes addObject:urlImagen];
            
        }
        
        [self.tablaeventos reloadData];
        
        
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



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return titulos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier: @"celdaeventos"];
    ((CeldaTemas*)cell).lblTema.text=titulos[indexPath.row];
    
    
    
    [((CeldaTemas*)cell).imagen setImageWithURL:[NSURL URLWithString:urlImagenes[indexPath.row]] placeholderImage:[UIImage imageNamed:@"congruent_pentagon"]];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row<titulos.count)
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
        
    }
    
};

@end
