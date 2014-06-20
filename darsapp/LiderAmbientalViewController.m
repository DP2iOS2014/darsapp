//
//  LiderAmbientalViewController.m
//  darsapp
//
//  Created by inf227al on 21/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "LiderAmbientalViewController.h"
#import "LiderAmbientalCell.h"
#import "SingletonAmbientalizate.h"
#import "URLsJson.h"

@interface LiderAmbientalViewController ()

@end

@implementation LiderAmbientalViewController{

    NSDictionary * respuesta;
    NSArray * arregloprueba;
    NSMutableArray *buenaspracticas;
    NSMutableArray *puntajes;
    NSMutableArray *estados;
    NSMutableArray * nids;
    double puntajeUsuario;
    SingletonAmbientalizate *Ambientalizate;
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) recuperaBuenasPracticas{
    
    //lectura de datos
    
    NSUserDefaults * datos = [NSUserDefaults standardUserDefaults];
    NSString * nombre = [datos stringForKey:@"NombreUsuario"];
    NSDictionary *filtro2 = [NSDictionary dictionaryWithObjectsAndKeys:nombre, @"username",self.tema,@"tema",nil];
    
    NSDictionary *consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Accion",@"operacion",@"consulta_buenaspracticasxusuario",@"desc",filtro2, @"cuerpo", nil];
    
    
    NSLog(@"%@", consulta);
    
    buenaspracticas = [[NSMutableArray alloc] init];
    puntajes = [[NSMutableArray alloc]init];
    estados = [[NSMutableArray alloc]init];
    nids = [[NSMutableArray alloc] init];
    //PARA SACAR LOS DATOS
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:Buenaspracticas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        NSDictionary * diccionarioPosiciones = [respuesta objectForKey:@"cuerpo"];
        NSArray * arregloPosiciones = [diccionarioPosiciones objectForKey:@"listaBuenasPracticas"];
        
        //PARA SACAR LOS DATOS
        
        for(int i=0; i<[arregloPosiciones count];i++){
            //NSString *descripcion = [[arregloPosiciones objectAtIndex:i] objectForKey:@"descripcion"];
            NSString *titulo = [[arregloPosiciones objectAtIndex:i] objectForKey:@"title"];
            NSString *puntaje = [[arregloPosiciones objectAtIndex:i] objectForKey:@"puntaje"];
            NSNumber *estado = [[arregloPosiciones objectAtIndex:i] objectForKey:@"activo"];
            //NSNumber * nid = [[arregloPosiciones objectAtIndex:i] objectForKey:@"nid"];
            [buenaspracticas addObject:titulo];
            [puntajes   addObject:puntaje];
            [estados addObject:estado];
           // [nids addObject:nid];
            
            
        }
        if([[Ambientalizate.ArregloEstados objectAtIndex:self.indice] count]==0){
            [Ambientalizate.ArregloEstados setObject:estados atIndexedSubscript:self.indice];
            
        }
        //if([[Ambientalizate.ArregloNids objectAtIndex:self.indice] count]==0){
          //  [Ambientalizate.ArregloNids setObject:nids atIndexedSubscript:self.indice];
            
        //}
        
        //if([[Ambientalizate.ArregloReset objectAtIndex:self.indice] count]==0){
          //  [Ambientalizate.ArregloReset setObject:@1 atIndexedSubscript:self.indice];
            
        //}
        
        [self.collectionView reloadData];
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    Ambientalizate= [SingletonAmbientalizate sharedManager:(NSInteger)self.cantidadFilas];
    
    [self recuperaBuenasPracticas];
    
    
    [self.collectionView setAllowsMultipleSelection:YES];
    
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 8, 20, 8);
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

}


- (void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults * datosUsuario = [NSUserDefaults standardUserDefaults];
    puntajeUsuario = [datosUsuario doubleForKey:@"puntajeAcumulado"];

}
- (void)viewWillDisappear:(BOOL)animated {
    
    
    double puntajeHecho = puntajeUsuario;
    
   // NSUserDefaults * datosDeMemoria = [NSUserDefaults standardUserDefaults];
    
    //double puntajeActual = [datosDeMemoria doubleForKey:@"puntajeAcumulado"];
    
    //double nuevoPuntaje = puntajeActual + puntajeHecho;

    
    [[NSUserDefaults standardUserDefaults] setDouble:puntajeHecho forKey:@"puntajeAcumulado"];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return buenaspracticas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LiderAmbientalCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"idimagen" forIndexPath:indexPath];
    
    cell.imagen.image = [UIImage imageNamed:@"images.jpeg"];
    
    
    if ([[Ambientalizate.ArregloEstados objectAtIndex:self.indice] count]!=0) {

        
        [@"perro" isEqualToString:@"perro"];
        
        NSNumber *miEstado = [Ambientalizate.ArregloEstados objectAtIndex:self.indice][indexPath.row];
        
        if(miEstado.intValue == 1){
            cell.imagen.alpha=0.3;
            cell.icon.alpha=1;
            cell.txtlabel.text=[buenaspracticas objectAtIndex:indexPath.row];
            
        }else{
            cell.imagen.alpha=1;
            cell.icon.alpha=0;
            cell.txtlabel.text=[buenaspracticas objectAtIndex:indexPath.row];
        }
    }else {
    
    cell.imagen.alpha=1;
    cell.icon.alpha=0;
    cell.txtlabel.text=[buenaspracticas objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"miHeader" forIndexPath:indexPath];
        
        reusableview = headerView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"miFooter" forIndexPath:indexPath];
        
        reusableview = footerview;
    }
    
    return reusableview;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    collectionView.userInteractionEnabled = NO;
    self.navigationItem.backBarButtonItem.enabled = NO;
    
    LiderAmbientalCell* celda = [self.collectionView cellForItemAtIndexPath:indexPath];
    

    
   [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
    
    NSNumber * miestado=[[Ambientalizate.ArregloEstados objectAtIndex:self.indice] objectAtIndex:indexPath.row];
    
    
    if(miestado.intValue==0){
        
        puntajeUsuario = [[puntajes objectAtIndex:indexPath.row] doubleValue] + puntajeUsuario;
        
        [Ambientalizate.ArregloEstados objectAtIndex:self.indice][indexPath.row] = @1;
        [UIView transitionWithView:celda.imagen duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
            celda.imagen.alpha=0.3;
            
            
        } completion:^(BOOL finished) {
            celda.icon.alpha = 1;
            collectionView.userInteractionEnabled = YES;
            self.navigationItem.backBarButtonItem.enabled = YES;
            
        }];
        
       
        
        
    
    
    }else{
    
        puntajeUsuario = puntajeUsuario - [[puntajes objectAtIndex:indexPath.row] doubleValue] ;
        
        
        celda.icon.alpha = 0;
        [UIView transitionWithView:celda.imagen duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            
            celda.imagen.alpha=1;
            
            
        } completion:^(BOOL finished) {
            collectionView.userInteractionEnabled = YES;
            self.navigationItem.backBarButtonItem.enabled = YES;
        }];
        
        
        
        [Ambientalizate.ArregloEstados objectAtIndex:self.indice][indexPath.row] = @0;
      

    }
    
    
  
    
    //Aqui gira la imagen
    //if(celda.imagen.alpha==1){
   
    //}
    
    
}


//PARA MANDAR DE UNA ESCENA A OTRA


@end
