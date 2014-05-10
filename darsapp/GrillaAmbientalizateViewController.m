//
//  GrillaAmbientalizateViewController.m
//  darsapp
//
//  Created by inf227al on 10/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "GrillaAmbientalizateViewController.h"
#import "GrillaAmbientalizateCell.h"
//#import "RecipeCollectionHeaderView.h"


@interface GrillaAmbientalizateViewController ()

@end

@implementation GrillaAmbientalizateViewController
{
    NSArray * arregloImagenes;
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
    arregloImagenes = @[@"cl01.jpg",@"cl02.jpg",@"cl03.jpg",@"cl04.jpg",@"cl05.jpg",@"cl06.jpg",@"cl07.jpg",@"cl08.jpg",@"cl09.jpg",@"cl10.jpg",@"cl11.jpg"];
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
    return arregloImagenes.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GrillaAmbientalizateCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:@"miItem" forIndexPath:indexPath];
    
    cell.imagen.image = [UIImage imageNamed:[arregloImagenes objectAtIndex:indexPath.row]];
    
    NSArray * indexItems = [self.collectionView indexPathsForSelectedItems];
    
    if([indexItems containsObject:indexPath]){
        cell.imagen.alpha=0.3;
        cell.imagenCheck.alpha = 1;
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



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GrillaAmbientalizateCell* celda = [self.collectionView cellForItemAtIndexPath:indexPath];
    
    //Aqui gira la imagen
    if(celda.imagen.alpha==1){
        [UIView transitionWithView:celda.imagen duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        
            celda.imagen.alpha=0.3;
        
        
        } completion:^(BOOL finished) {
            celda.imagenCheck.alpha = 1;
        }];
    
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    GrillaAmbientalizateCell* celda = [self.collectionView cellForItemAtIndexPath:indexPath];
    celda.imagenCheck.alpha = 0;
        [UIView transitionWithView:celda.imagen duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            
            celda.imagen.alpha=1;
            
            
        } completion:nil];
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

@end
