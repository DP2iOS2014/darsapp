//
//  LiderAmbientalViewController.m
//  darsapp
//
//  Created by inf227al on 21/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "LiderAmbientalViewController.h"
#import "LiderAmbientalCell.h"

@interface LiderAmbientalViewController ()

@end

@implementation LiderAmbientalViewController{

    NSArray * arregloprueba;
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
    
    arregloprueba=@[@"Compras1.png",@"Compras2.png",@"Compras3.png",@"Compras4.png",@"Compras5.png",@"Compras6.png",@"Compras7.png",@"Compras8.png",@"Compras9.png",@"Compras10.png",@"Compras11.png",@"Compras12.png",@"Compras13.png",@"Compras14.png",@"Compras15.png",@"Compras16.png"];
    [self.collectionView setAllowsMultipleSelection:YES];
    
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *collectionViewLayout = (UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    
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
    return arregloprueba.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    LiderAmbientalCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"idimagen" forIndexPath:indexPath];
    
    cell.imagen.image = [UIImage imageNamed:[arregloprueba objectAtIndex:indexPath.row]];
    
    NSArray * indexitems = [self.collectionView indexPathsForSelectedItems];
    
    if([indexitems containsObject:indexPath]){
        cell.imagen.alpha=0.3;
        cell.icon.alpha=1;
        
    }else{
        cell.imagen.alpha=1;
        cell.icon.alpha=0;
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
    if(celda.imagen.alpha==1){
        [UIView transitionWithView:celda.imagen duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
            celda.imagen.alpha=0.3;
            
            
        } completion:^(BOOL finished) {
            celda.icon.alpha = 1;
        }];
        
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    LiderAmbientalCell* celda = [self.collectionView cellForItemAtIndexPath:indexPath];
    celda.icon.alpha = 0;
    [UIView transitionWithView:celda.imagen duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
        celda.imagen.alpha=1;
        
        
    } completion:nil];
}

//PARA MANDAR DE UNA ESCENA A OTRA


@end
