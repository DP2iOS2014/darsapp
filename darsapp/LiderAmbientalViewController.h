//
//  LiderAmbientalViewController.h
//  darsapp
//
//  Created by inf227al on 21/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiderAmbientalViewController : UICollectionViewController

@property (nonatomic,strong) NSDictionary *respuestajson;
@property NSInteger indiceTema;
@property NSString *tituloTema;
@property NSInteger cantidadFilas;
@property NSInteger nidTemaSeleccionado;

@property NSMutableArray *buenaspracticas;
@property NSMutableArray *puntajesBP;
@property NSMutableArray *estadosBP;
@property NSMutableArray *nidsBP;
@property NSMutableArray *nidsTemaUsuario;
@end
