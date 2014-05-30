//
//  PreguntasViewController.h
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol preguntasDelegate <NSObject>
@optional
-(void)apretoOkAlFallaPregunta;

@end

@interface PreguntasViewController : UIViewController<UIAlertViewDelegate>
{
    NSArray *ArregloPreguntas;
    BOOL tieneOtraOpcion;
    NSTimer * timer;
   
    
}
@property (nonatomic, weak) id <preguntasDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *VidasReloj;
@property (weak, nonatomic) IBOutlet UIButton *btnReloj;
@property (weak, nonatomic) IBOutlet UIButton *btnBomba;
@property (weak, nonatomic) IBOutlet UIButton *btnOtroOpcion;
@property (weak, nonatomic) IBOutlet UIButton *btnNuevaPregunta;
@property (weak, nonatomic) IBOutlet UILabel *Tiempo;
@property (weak, nonatomic) IBOutlet UIButton *btnRespuesta1;
@property (weak, nonatomic) IBOutlet UIButton *btnRespuesta2;
@property (weak, nonatomic) IBOutlet UIButton *btnRespuesta3;
@property (weak, nonatomic) IBOutlet UIButton *btnRespuesta4;
@property (weak, nonatomic) IBOutlet UILabel *VidasBomba;
@property (weak, nonatomic) IBOutlet UILabel *VidasOtraOpcion;
@property (weak, nonatomic) IBOutlet UILabel *pregunta;
@property (strong, nonatomic) IBOutlet UILabel *VidasNuevaPregunta;
@property (strong, nonatomic) IBOutlet UIProgressView *BarraProgreso;
@property int idtema;
@property NSString *tipo_tema;


@end
