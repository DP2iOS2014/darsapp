//
//  Iniciativas.m
//  darsapp
//
//  Created by inf227al on 10/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "Iniciativas.h"
#import "URLsJson.h"
#import "UIImage+Tint.h"
#import "CeldaIniciativasTableViewCell.h"

@interface Iniciativas ()

@end

@implementation Iniciativas

NSDictionary *respuesta;
NSMutableArray *iniciativas;
NSMutableArray *descripciones;
NSMutableArray *puntajesusuario;
NSMutableArray *puntajestotal;


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
    [self recuperoIniciativas];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.parentViewController.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];


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


    return (iniciativas.count +1);
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    
    if(indexPath.row == 0){
        cell = [tableView dequeueReusableCellWithIdentifier:@"celdanuevainiciativa"];
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"CeldaIniciativas"];
        ((CeldaIniciativasTableViewCell*)cell).lblIniciativa.text= iniciativas[indexPath.row];
        
        
         ((CeldaIniciativasTableViewCell*)cell).starRating.backgroundColor  = [UIColor whiteColor];
         ((CeldaIniciativasTableViewCell*)cell).starRating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
         ((CeldaIniciativasTableViewCell*)cell).starRating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
         ((CeldaIniciativasTableViewCell*)cell).starRating.maxRating = 5.0;
         ((CeldaIniciativasTableViewCell*)cell).starRating.delegate = self;
         ((CeldaIniciativasTableViewCell*)cell).starRating.horizontalMargin = 15.0;
         ((CeldaIniciativasTableViewCell*)cell).starRating.editable=YES;
         ((CeldaIniciativasTableViewCell*)cell).starRating.rating= 2.5;
         ((CeldaIniciativasTableViewCell*)cell).starRating.displayMode=EDStarRatingDisplayHalf;
         [((CeldaIniciativasTableViewCell*)cell).starRating  setNeedsDisplay];
         ((CeldaIniciativasTableViewCell*)cell).starRating.tintColor = [[UIColor alloc] initWithRed:63/255.0 green:192/255.0 blue:169/255.0 alpha:0];
         [self starsSelectionChanged:((CeldaIniciativasTableViewCell*)cell).starRating rating:2.5];

        
    }

    
    
    
    return cell;
}




//PARA CARGAR LAS INICIATIVAS POR TEMA

-(void) recuperoIniciativas{

    NSDictionary *filtro2 = [NSDictionary dictionaryWithObjectsAndKeys:@"field_tipotema",@"campo",self.temainiciativas,@"valor",nil];
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"iniciativas", @"tipo", @[filtro2], @"filtro", nil];
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@", consulta);
    
    iniciativas = [[NSMutableArray alloc] init];
    descripciones = [[NSMutableArray alloc] init];
    puntajesusuario = [[NSMutableArray alloc]init];
    puntajestotal = [[NSMutableArray alloc]init];
    
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
            NSString *puntajeusuario = [[arregloPosiciones objectAtIndex:i] objectForKey:@"puntaje"];
            NSString *puntajetotal = [[arregloPosiciones objectAtIndex:i] objectForKey:@"puntaje_total"];
            NSNumber *estado = [[arregloPosiciones objectAtIndex:i] objectForKey:@"estado"];
            
            [iniciativas addObject:titulo];
            [descripciones   addObject:descripcion];
            [puntajesusuario   addObject:puntajeusuario];
            [puntajestotal addObject:puntajetotal];
           
            
            
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


-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row>0)
        [self performSegueWithIdentifier:@"idsegue" sender:self];
    

    
}

@end
