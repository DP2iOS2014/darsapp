//
//  GrillaEventoViewController.h
//  darsapp
//
//  Created by inf227al on 5/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "ViewController.h"

@interface GrillaEventoViewController : ViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitulo;
@property (weak, nonatomic) IBOutlet UILabel *lblFecha;
@property (weak, nonatomic) IBOutlet UIImageView *imagenEvento;
@property (weak, nonatomic) IBOutlet UITextView *lblDescripcion;
@property (weak, nonatomic) IBOutlet UILabel *lblLugar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SegmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *btnAsistir;
@property (strong, nonatomic) IBOutlet UIImageView *checkAsistir;
@property (weak, nonatomic) IBOutlet UILabel *lblHora;


@property  NSMutableArray * titulos;
@property NSMutableArray * urlImagenes;

@property NSMutableArray * descripcion;
@property NSMutableArray * enlace;
@property NSMutableArray * fecha;
@property NSMutableArray * lugar;
@property NSMutableArray * organizador;
@property NSMutableArray * estado;
@property NSInteger celda_seleccionada;
@property NSNumber* nidseleccionado;
@end
