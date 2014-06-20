//
//  DetalleIniciativaViewController.m
//  darsapp
//
//  Created by inf227al on 11-06-14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "DetalleIniciativaViewController.h"

@interface DetalleIniciativaViewController ()

@end

@implementation DetalleIniciativaViewController

int puntajexusuario;

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
    // Do any additional setup after loading the view.
    
       [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
    
    self.starRating.backgroundColor  = [UIColor clearColor];
    self.starRating.starImage = [[UIImage imageNamed:@"leaf2"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.starRating.starHighlightedImage = [[UIImage imageNamed:@"leaf"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.starRating.maxRating = 5.0;
    self.starRating.delegate = self;
    self.starRating.horizontalMargin = 15.0;
    self.starRating.editable=YES;
    self.starRating.rating= ((NSNumber*)self.puntuacion[self.celdaseleccionada-1]).intValue /20;
    self.starRating.displayMode=EDStarRatingDisplayHalf;
    [self.starRating  setNeedsDisplay];
    self.starRating.tintColor = [[UIColor alloc] initWithRed:63.0/255.0 green:192.0/255.0 blue:169.0/255.0 alpha:1];
    [self starsSelectionChanged:self.starRating rating:((NSNumber*)self.puntuacion[self.celdaseleccionada-1]).intValue /20];
    
    //SETEAR AQUI EL ARREGLO TITULOS CUANDO SE LES OCURRA ARREGLAR EL JSON U.U
    self.lblIniciativa.text= self.titulos[self.celdaseleccionada-1];
    self.lblDescripcion.text=self.descripciones[self.celdaseleccionada-1];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating{
    puntajexusuario = rating*20;
}

- (IBAction)seMandoPuntuacion:(id)sender {
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Mandar Puntuación"
                                                        message:@"La Puntuación se envió con éxito"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}


@end
