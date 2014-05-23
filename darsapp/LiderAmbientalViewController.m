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

@interface LiderAmbientalViewController ()

@end

@implementation LiderAmbientalViewController{

    NSArray * arregloprueba;
    NSMutableArray *buenaspracticas;
    NSMutableArray *puntajes;
    NSMutableArray *estados;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    Ambientalizate= [SingletonAmbientalizate sharedManager];
    
    //lectura de datos
    
    NSDictionary * diccionarioPosiciones = [self.respuestajson objectForKey:@"cuerpo"];
    NSArray * arregloPosiciones = [diccionarioPosiciones objectForKey:@"listaNodos"];
    buenaspracticas = [[NSMutableArray alloc] init];
    puntajes = [[NSMutableArray alloc]init];
    estados = [[NSMutableArray alloc]init];
    //PARA SACAR LOS DATOS
    
    for(int i=0; i<[arregloPosiciones count];i++){
        NSString *descripcion = [[arregloPosiciones objectAtIndex:i] objectForKey:@"descripcion"];
        NSString *titulo = [[arregloPosiciones objectAtIndex:i] objectForKey:@"title"];
        NSString *puntaje = [[arregloPosiciones objectAtIndex:i] objectForKey:@"puntaje"];
        NSString *tema = [[arregloPosiciones objectAtIndex:i] objectForKey:@"tipo_tema"];
        NSNumber *estado = [[arregloPosiciones objectAtIndex:i] objectForKey:@"estado"];
        
        double idtema=0;

        
        if ([tema isEqualToString:@"agua"]) {
            idtema=0;
        };
        if ([tema isEqualToString:@"espacios verdes"]) {
            idtema=1;
        };
        if ([tema isEqualToString:@"compras"]) {
            idtema=2;
        };
        if ([tema isEqualToString:@"Energia"]) {
            idtema=3;
        };
        if ([tema isEqualToString:@"liderazgo"]) {
            idtema=4;
        };
        if ([tema isEqualToString:@"papeles"]) {
            idtema=5;
        };
        if ([tema isEqualToString:@"residuos solidos"]) {
            idtema=6;
        };
        if ([tema isEqualToString:@"aire y ruido"]) {
            idtema=7;
        };
        if ([tema isEqualToString:@"tranporte"]) {
            idtema=8;
        };
     
        if(self.indice==idtema){
            [buenaspracticas addObject:titulo];
            [puntajes   addObject:puntaje];
            [estados addObject:estado];
        }
    
    }
    
    NSLog(@"JSON: %@", self.respuestajson);
    
    /////////////VERIFICO QUE TEMA APRETO////////////////
        
    
    [self.collectionView setAllowsMultipleSelection:YES];
    
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 8, 20, 8);
    
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
    
    NSArray * indexitems = [self.collectionView indexPathsForSelectedItems];
    
    if ([Ambientalizate.ArregloEstados count]!=0) {
        
        if( [[Ambientalizate.ArregloEstados objectAtIndex:indexPath.row] isEqual:@1]){
            cell.imagen.alpha=0.3;
            cell.icon.alpha=1;
            cell.txtlabel.text=[buenaspracticas objectAtIndex:indexPath.row];
            [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:nil];
            cell.selected = YES;
        
        }else{
            cell.imagen.alpha=1;
            cell.icon.alpha=0;
            cell.txtlabel.text=[buenaspracticas objectAtIndex:indexPath.row];
            [self.collectionView deselectItemAtIndexPath:indexPath animated:YES
             ];
            cell.selected = NO; 
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
    LiderAmbientalCell* celda = [self.collectionView cellForItemAtIndexPath:indexPath];
    

    //Aqui gira la imagen
    //if(celda.imagen.alpha==1){
   
            [UIView transitionWithView:celda.imagen duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
                celda.imagen.alpha=0.3;
            
            
            } completion:^(BOOL finished) {
                celda.icon.alpha = 1;
            }];
    //}
    
        puntajeUsuario = [[puntajes objectAtIndex:indexPath.row] doubleValue] + puntajeUsuario;
    
        estados[indexPath.row] = @1;
        [Ambientalizate setArregloEstados:estados];
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    LiderAmbientalCell* celda = [self.collectionView cellForItemAtIndexPath:indexPath];
    

         celda.icon.alpha = 0;
         [UIView transitionWithView:celda.imagen duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
             celda.imagen.alpha=1;
        
        
         } completion:nil];
    
         puntajeUsuario = puntajeUsuario - [[puntajes objectAtIndex:indexPath.row] doubleValue] ;
    
         estados[indexPath.row] = @0;
        [Ambientalizate setArregloEstados:estados];
    
}

//PARA MANDAR DE UNA ESCENA A OTRA


@end
