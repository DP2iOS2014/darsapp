//
//  TemasIniciativasTableViewController.m
//  darsapp
//
//  Created by inf227al on 10/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "TemasIniciativasTableViewController.h"
#import "URLsJson.h"
#import "UIImageView+AFNetworking.h"
#import "CeldaTemasIniciativas.h"
#import "Iniciativas.h"

@interface TemasIniciativasTableViewController ()

@end

@implementation TemasIniciativasTableViewController

NSDictionary * respuesta;
NSDictionary * respuestatemasiniciativas;
NSMutableArray *arregloRespuesta;
NSMutableArray *titulos;
NSMutableArray *nombresimagenes;
NSMutableArray * urlImagenes;



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
    titulos = [[NSMutableArray alloc] init];
    nombresimagenes= [[NSMutableArray alloc] init];
    urlImagenes = [[NSMutableArray alloc] init];
    [self recuperoTemasIniciativas];
    
    
    self.parentViewController.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return (titulos.count);
}


-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:@"CeldaTemasIniciativas"];
    ((CeldaTemasIniciativas*)cell).lblTema.text=titulos[indexPath.row];
    [((CeldaTemasIniciativas*)cell).imagenTema setImageWithURL:[NSURL URLWithString:urlImagenes[indexPath.row]] placeholderImage:[UIImage imageNamed:@"logo"]];

    return cell;
}



//METODO PARA LISTA LOS TEMAS DE LAS INICIATIVAS

-(void) recuperoTemasIniciativas{

    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"tema_iniciativa", @"tipo", nil];
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@", consulta);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:RecuperoTemas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuestatemasiniciativas = responseObject;
        NSLog(@"JSON: %@", respuestatemasiniciativas);
        
        NSDictionary * diccionarioPosiciones = [respuestatemasiniciativas objectForKey:@"cuerpo"];
        NSArray * arregloPosiciones = [diccionarioPosiciones objectForKey:@"listaNodos"];
        
        //PARA SACAR LOS DATOS
        
        for(int i=0; i<[arregloPosiciones count];i++){
            NSString *titulo = [[arregloPosiciones objectAtIndex:i] objectForKey:@"title"];
            NSString *nombreimagen = [[arregloPosiciones objectAtIndex:i] objectForKey:@"nombre_archivo"];
            
            NSString *postFijo = [[arregloPosiciones objectAtIndex:i] objectForKey:@"url_archivo"];
            
            NSString *urlImagen = [NSString stringWithFormat:@"%@%@",@"http://200.16.7.111/dp2/rc/",[postFijo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            [titulos addObject:titulo];
            [nombresimagenes addObject:nombreimagen];
            [urlImagenes addObject:urlImagen];
            
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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    Iniciativas *escenadestino = segue.destinationViewController;
    NSIndexPath *filaseleccionada = [self.tableView indexPathForSelectedRow];
    escenadestino.indice=filaseleccionada.row;
    escenadestino.temainiciativas= [titulos objectAtIndex:filaseleccionada.row];
    escenadestino.cantidadFilas = titulos.count;


}

@end
