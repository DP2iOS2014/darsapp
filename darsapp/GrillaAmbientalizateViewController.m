//
//  GrillaAmbientalizateViewController.m
//  darsapp
//
//  Created by inf227al on 10/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "GrillaAmbientalizateViewController.h"
#import "GrillaAmbientalizateCell.h"
#import "SingletonEcoTips.h"
#import "UIImageView+AFNetworking.h"
#import "MyFlowLayout.h"
//////
//#import "RecipeCollectionHeaderView.h"

#import "URLsJson.h"
#import "ResultadoCalificateViewController.h"

@interface GrillaAmbientalizateViewController ()

@end

@implementation GrillaAmbientalizateViewController
{
    NSArray * arregloImagenes;
    NSDictionary * respuesta;
    NSMutableArray *arregloRespuesta;
    NSMutableArray *estados;
    NSArray * arregloprueba;
    NSMutableArray *ecotips;
    NSMutableArray *puntajes;
    NSMutableArray *nids;
    double puntajeUsuario;
    double puntajeActual;
    SingletonEcoTips * ecoTips;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) recuperaEcoTipsLider{
    
    //PARA ENVIAR PRIMI
    
    ecotips = [[NSMutableArray alloc] init];
    puntajes = [[NSMutableArray alloc]init];
    estados = [[NSMutableArray alloc]init];
    nids = [[NSMutableArray alloc]init];
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"ecotips", @"tipo", @[], @"filtro", nil];
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
            
            @try {
                for(int i=0; i<[arregloPosiciones count];i++){
                    NSString *nid = [[arregloPosiciones objectAtIndex:i] objectForKey:@"nid"];
                    NSString *nombre_archivo = [[arregloPosiciones objectAtIndex:i] objectForKey:@"nombre_archivo"];
                    
                    NSString *postFijo = [[arregloPosiciones objectAtIndex:i] objectForKey:@"url_archivo"];
                    
                    //NSString *urlImagen = [NSString stringWithFormat:@"%@%@",@"http://200.16.7.111/dp2/rc/",[postFijo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
                    
                    //NSString *estado = [[arregloPosiciones objectAtIndex:i] objectForKey:@"estado"];
                    NSString *puntaje = [[arregloPosiciones objectAtIndex:i] objectForKey:@"puntaje"];
                    
                    
                    
                    [ecotips addObject:postFijo];
                    [nids addObject:nid];
                    [puntajes   addObject:puntaje];
                    [estados addObject:puntaje];
                    
                }
                [self.collectionView reloadData];
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
    ecoTips= [SingletonEcoTips sharedManager];
    [self recuperaEcoTipsLider];
    
    self.parentViewController.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    
    ///////
    MyFlowLayout *myLayout = [[MyFlowLayout alloc]init];
    myLayout.headerReferenceSize = CGSizeMake(0, 50);
    myLayout.footerReferenceSize = CGSizeMake(0, 50);
    [myLayout setItemSize:CGSizeMake(146, 118)];
    [self.collectionView setCollectionViewLayout:myLayout animated:YES];
    
    UIGestureRecognizer *pinchRecognizer =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handlePinch:)];
    
    [self.collectionView addGestureRecognizer:pinchRecognizer];

    //////
    
    [self.collectionView setAllowsMultipleSelection:YES];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    collectionViewLayout.sectionInset = UIEdgeInsetsMake(20, 8, 20, 8);
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
    return ecotips.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GrillaAmbientalizateCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"miItem" forIndexPath:indexPath];
    NSLog(@"blablabla @%",ecotips);
    
    [((GrillaAmbientalizateCell*)cell).imagen setImageWithURL:[NSURL URLWithString:ecotips[indexPath.row]] placeholderImage:[UIImage imageNamed:@"congruent_pentagon"]];
    
    NSArray * indexItems = [self.collectionView indexPathsForSelectedItems];
    if ([ecoTips.ArregloEstados count]!=0) {
        if([[ecoTips.ArregloEstados objectAtIndex:indexPath.row] isEqual:@100]){
            cell.imagen.alpha=0.3;
            cell.imagenCheck.alpha = 1;
            [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:nil];
            cell.selected = YES;
        }else{
            cell.imagen.alpha=1;
            cell.imagenCheck.alpha = 0;
            [self.collectionView deselectItemAtIndexPath:indexPath animated:YES
             ];
            cell.selected = NO;

        }
    }else{
        cell.imagen.alpha=1;
        cell.imagenCheck.alpha = 0;
    }
    
    
    return cell;
}

/*-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *miView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"miHeader"  forIndexPath:indexPath];
    
    return miView;
}*/

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

- (void)viewWillAppear:(BOOL)animated{
    
    NSUserDefaults * datosUsuario = [NSUserDefaults standardUserDefaults];
    puntajeUsuario = [datosUsuario doubleForKey:@"puntajeAcumuladoEcoTips"];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    
    
    double puntajeHecho = puntajeUsuario;
    
    // NSUserDefaults * datosDeMemoria = [NSUserDefaults standardUserDefaults];
    
    //double puntajeActual = [datosDeMemoria doubleForKey:@"puntajeAcumulado"];
    
    //double nuevoPuntaje = puntajeActual + puntajeHecho;
    
    
    [[NSUserDefaults standardUserDefaults] setDouble:puntajeHecho forKey:@"puntajeAcumuladoEcoTips"];
    
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    collectionView.userInteractionEnabled = NO;
    self.navigationItem.backBarButtonItem.enabled = NO;
    
    GrillaAmbientalizateCell* celda = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    NSNumber * mistado = [estados objectAtIndex:indexPath.row];
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    
    //ESTA DESACTIVADO
    if (mistado.intValue == 20) {
        
        puntajeUsuario = [[puntajes objectAtIndex:indexPath.row] doubleValue] + puntajeUsuario;
         estados[indexPath.row] = @100;
        
        [UIView transitionWithView:celda.imagen duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
            celda.imagen.alpha=0.3;
            
            
        } completion:^(BOOL finished) {
            celda.imagenCheck.alpha = 1;
            collectionView.userInteractionEnabled = YES;
            self.navigationItem.backBarButtonItem.enabled = YES;
            
        }];
        [ecoTips setArregloEstados:estados];
        
    }else{
         puntajeUsuario = puntajeUsuario - [[puntajes objectAtIndex:indexPath.row] doubleValue];
        
        celda.imagenCheck.alpha = 0;
        [UIView transitionWithView:celda.imagen duration:0.5 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
            celda.imagen.alpha=1;
            
            
        }completion:^(BOOL finished) {
            collectionView.userInteractionEnabled = YES;
            self.navigationItem.backBarButtonItem.enabled = YES;
        }];
        
        estados[indexPath.row] = @20;
        [ecoTips setArregloEstados:estados];
        
    }
    
    
}


//////
- (IBAction)handlePinch:(UIPinchGestureRecognizer *)sender {
    
    // Get a reference to the flow layout
    
    MyFlowLayout *layout =
    (MyFlowLayout *)self.collectionView.collectionViewLayout;
    
    // If this is the start of the gesture
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        // Get the initial location of the pinch?
        CGPoint initialPinchPoint =
        [sender locationInView:self.collectionView];
        
        //Convert pinch location into a specific cell
        NSIndexPath *pinchedCellPath =
        [self.collectionView indexPathForItemAtPoint:initialPinchPoint];
        
        // Store the indexPath to cell
        layout.currentCellPath = pinchedCellPath;
    }
    else if (sender.state == UIGestureRecognizerStateChanged)
    {
        // Store the new center location of the selected cell
        layout.currentCellCenter =
        [sender locationInView:self.collectionView];
        // Store the scale value
        layout.currentCellScale = sender.scale;
    }
    else if(sender.state == UIGestureRecognizerStateEnded)
    {
        
        if(layout.itemSize.width*layout.currentCellScale>self.collectionView.frame.size.width){
            [self.collectionView performBatchUpdates:^{
                    layout.currentCellScale = self.collectionView.frame.size.width/layout.itemSize.width;
            } completion:nil];
        }else{
        
        
        [self.collectionView performBatchUpdates:^{
            layout.currentCellPath = nil;
            layout.currentCellScale = 1.0;
        } completion:nil];
        }
    }
    
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ResultadoCalificateViewController *escenadestino = segue.destinationViewController;
    escenadestino.respuestajson= respuesta;
    
    escenadestino.puntaje= puntajeUsuario;
    
};

/////

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
