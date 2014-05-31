//
//  PreguntasViewController.m
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "PreguntasViewController.h"
#import "ClasePregunta.h"
#import "preguntaProgressView.h"
#import "SingletonJuego.h"
#import "URLsJson.h"
#import <AudioToolbox/AudioToolbox.h>
@interface PreguntasViewController ()

@end

@implementation PreguntasViewController

{
    SingletonJuego *juego;
    ClasePregunta *preguntaActual;
    NSDictionary * respuestajson;
    SystemSoundID audioEffect;
    NSInteger puntajeActual;
    UIAlertView *alertView;

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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
    [self recuperaEcoTipsLider];
    juego= [SingletonJuego sharedManager];

    
    NSUserDefaults * datosUsuario = [NSUserDefaults standardUserDefaults];
    puntajeActual = [datosUsuario doubleForKey:@"puntajeActualJuegoRuleta"];
    
    tieneOtraOpcion=NO;
    self.Tiempo.text= [[NSString alloc] initWithFormat:@"%ld",(long)juego.Tiempo] ;
    self.VidasReloj.text= [[NSString alloc] initWithFormat:@"%ld",(long)juego.VidasReloj] ;
    self.VidasBomba.text= [[NSString alloc] initWithFormat:@"%ld",(long)juego.VidasBomba] ;
    self.VidasOtraOpcion.text= [[NSString alloc] initWithFormat:@"%ld",(long)juego.VidasOtraOpcion] ;
    self.VidasNuevaPregunta.text= [[NSString alloc] initWithFormat:@"%ld",(long)juego.VidasNPregunta] ;
    self.btnReloj.enabled=juego.disponibilidadBoton;
    self.btnBomba.enabled=juego.disponibilidadBoton;
    self.btnOtroOpcion.enabled=juego.disponibilidadBoton;
    self.btnNuevaPregunta.enabled=juego.disponibilidadBoton;
    timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector:@selector(tick) userInfo:nil repeats:YES];
    
    
    self.btnRespuesta1.enabled = juego.disponibilidadRespuesta1;
    self.btnRespuesta2.enabled = juego.disponibilidadRespuesta2;
    self.btnRespuesta3.enabled = juego.disponibilidadRespuesta3;
    self.btnRespuesta4.enabled = juego.disponibilidadRespuesta4;
    
    
}

-(void) recuperaEcoTipsLider{
    
    
    
    NSInteger puntaje;
    
    //NSInteger idtipopregunta=0;
    NSString *tipotema;
    
    puntaje = 10;
    
    
    //PARA ENVIAR PRIMI
    
    if(self.idtema==0){
        tipotema=@"Proyectos DARS" ;
    }
    
    if(self.idtema==1){
        tipotema= @"Segregación";
    }
    
    if(self.idtema==2){
        tipotema= @"Cultura Ambiental";
    }
    
    if(self.idtema==3){
        tipotema= @"Datos Curiosos";
    }
    
    if(self.idtema==4){
        tipotema= @"Segregación";
    }
    
 
    NSDictionary *cuerpo2 = [NSDictionary dictionaryWithObjectsAndKeys:tipotema,@"tipo_pregunta",nil];
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"pregunta", @"tipo", cuerpo2, @"taxonomias", nil];
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@", consulta);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:Preguntas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuestajson = responseObject;
        NSLog(@"JSON: %@", respuestajson);
        
        NSDictionary * diccionarioPosiciones = [respuestajson objectForKey:@"cuerpo"];
        NSArray * arregloPosiciones = [diccionarioPosiciones objectForKey:@"listaNodos"];
        

        //PARA SACAR LOS DATOS
        
        //for(int i=0; i<[arregloPosiciones count];i++){
            NSString *rpta_indice = [[arregloPosiciones objectAtIndex:0] objectForKey:@"field_respcorr_value"];
        
            NSInteger rpta = rpta_indice.intValue;
            
            NSString *tipo_pregunta = [[arregloPosiciones objectAtIndex:0] objectForKey:@"tipo_pregunta"];
            NSString *titulo = [[arregloPosiciones objectAtIndex:0] objectForKey:@"title"];
            NSNumber *tema_id = [[arregloPosiciones objectAtIndex:0] objectForKey:@"tid"];
            NSArray *opciones=[[NSArray alloc] initWithArray:[[arregloPosiciones objectAtIndex:0] objectForKey:@"listaPreguntas"]];
                 
       // };
        

        
        
        preguntaActual=[[ ClasePregunta alloc] initConPregunta:titulo Respuestas:opciones Puntaje: [[NSNumber alloc] initWithInteger:puntaje ] RespCorrecta:[[NSNumber alloc] initWithInteger:rpta]];
    
        
        self.pregunta.text=preguntaActual.PreguntaARealizar;
        [self.btnRespuesta1 setTitle: [preguntaActual.ArregloRespuestas objectAtIndex:0] forState: UIControlStateNormal];
        [self.btnRespuesta2 setTitle: [preguntaActual.ArregloRespuestas objectAtIndex:1] forState: UIControlStateNormal];
        [self.btnRespuesta3 setTitle: [preguntaActual.ArregloRespuestas objectAtIndex:2] forState: UIControlStateNormal];
        [self.btnRespuesta4 setTitle: [preguntaActual.ArregloRespuestas objectAtIndex:3] forState: UIControlStateNormal];
        
        //self.pregunta.text=titulo;
        //[self.btnRespuesta1 setTitle: [opciones objectAtIndex:0] forState: UIControlStateNormal];
        //[self.btnRespuesta2 setTitle: [opciones objectAtIndex:1] forState: UIControlStateNormal];
        //[self.btnRespuesta3 setTitle: [opciones objectAtIndex:2] forState: UIControlStateNormal];
        //[self.btnRespuesta4 setTitle: [opciones objectAtIndex:3] forState: UIControlStateNormal];
        
        
    }
          failure:^(AFHTTPRequestOperation *task, NSError *error) {
              alertView = [[UIAlertView alloc] initWithTitle:@"No choco con el servidor" message:[error localizedDescription]
                                                                 delegate:nil
                                                        cancelButtonTitle:@"Ok"
                                                        otherButtonTitles:nil];
              [alertView show];
          }];

    
   
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) terminarJuego: (BOOL) Correcta
{
    
    
    if(Correcta){
        
        puntajeActual = puntajeActual + [preguntaActual.PuntajePregunta integerValue];
        
        [[NSUserDefaults standardUserDefaults] setInteger:puntajeActual forKey:@"puntajeActualJuegoRuleta"];
    
        juego.Tiempo = 30;
        juego.tieneOtraOpcion = NO;
        juego.disponibilidadBoton=YES;
        juego.disponibilidadRespuesta1 = YES;
        juego.disponibilidadRespuesta2 = YES;
        juego.disponibilidadRespuesta3 = YES;
        juego.disponibilidadRespuesta4 = YES;
        [timer invalidate];
        [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:4];
        
    }else{
        //Mandar puntaje a back END
        NSUserDefaults * datosUsuario = [NSUserDefaults standardUserDefaults];
        int puntajeMaximo = [datosUsuario doubleForKey:@"puntajeMaximoRuleta"];
        if(puntajeActual>puntajeMaximo){
            [[NSUserDefaults standardUserDefaults] setDouble:puntajeActual forKey:@"puntajeMaximoRuleta"];
            
        }
        [self performSelector:@selector(irAHacerHora) withObject:nil afterDelay:2];
        
    }
    
    

}

-(void)irAHacerHora{
    if(!alertView.visible){
    alertView = [[UIAlertView alloc] initWithTitle:@"Haz Perdido"
                                                        message:@"Vuelve a Intentarlo"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
    }
}

-(void)irASeleccionado
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
        [timer invalidate];
        [self.delegate apretoOkAlFallaPregunta];
        [self dismissViewControllerAnimated:YES completion:nil];
    
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
//-(void) CreaPregunta:(NSInteger) numero{
    //preguntaActual=[ArregloPreguntas objectAtIndex:numero];
  //  self.pregunta.text=titulo;
    //NSArray *resp=[[ArregloPreguntas objectAtIndex:numero] ArregloRespuestas];
    
    //[self.btnRespuesta1 setTitle: [opciones objectAtIndex:0] forState: UIControlStateNormal];
    //[self.btnRespuesta2 setTitle: [opciones objectAtIndex:1] forState: UIControlStateNormal];
    //[self.btnRespuesta3 setTitle: [opciones objectAtIndex:2] forState: UIControlStateNormal];
    //[self.btnRespuesta4 setTitle: [opciones objectAtIndex:3] forState: UIControlStateNormal];

    
//}

- (IBAction)SeApretoReloj:(id)sender {
    if( juego.VidasReloj  >0) {
        juego.Tiempo= juego.Tiempo;
        self.Tiempo.text= [[NSString alloc] initWithFormat:@"%ld",(long)juego.Tiempo] ;
        juego.VidasReloj=juego.VidasReloj-1;
        self.VidasReloj.text=[[NSString alloc] initWithFormat:@"%ld", (long)juego.VidasReloj];
        juego.disponibilidadBoton=NO;
        self.btnReloj.enabled=juego.disponibilidadBoton;
        self.btnBomba.enabled=juego.disponibilidadBoton;
        self.btnOtroOpcion.enabled=juego.disponibilidadBoton;
        self.btnNuevaPregunta.enabled=juego.disponibilidadBoton;
        
    }
}
- (IBAction)SeApretoBomba:(id)sender {
    
    if( [self.VidasBomba.text intValue]  >0) {
        NSString *path  = [[NSBundle mainBundle] pathForResource:@"Bomb" ofType:@"wav"];
        NSURL *pathURL = [NSURL fileURLWithPath : path];
        
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
        
        int value=[preguntaActual.RespuestaCorrecta intValue];
        
        int valor1 = arc4random()%3;
        int valor2 = arc4random()%3;
        
        while (valor1 == value) {
            
            valor1 = arc4random()%3;
        }
        
        while(valor2 == valor1 || valor2 == value){
            
            valor2 = arc4random()%3;
            
        }

        
        if (valor1 == 0 || valor2 == 0) {
            self.btnRespuesta1.enabled=NO;
        }
        if (valor1 == 1 || valor2 == 1) {
            self.btnRespuesta2.enabled=NO;
        }
        if (valor1 == 2 || valor2 == 2) {
            self.btnRespuesta3.enabled=NO;
        }
        if (valor1 == 3 || valor2 == 3) {
            self.btnRespuesta4.enabled=NO;
        }
        
        juego.VidasBomba=juego.VidasBomba-1;
        self.VidasBomba.text=[[NSString alloc] initWithFormat:@"%ld", (long)juego.VidasBomba];
        self.btnReloj.enabled=NO;
        self.btnBomba.enabled=NO;
        self.btnOtroOpcion.enabled=NO;
        self.btnNuevaPregunta.enabled=NO;
    }
    
    
    
}

- (IBAction)SeApretoOtraOpcion:(id)sender {
    if( [self.VidasOtraOpcion.text intValue]  >0) {
        self.VidasOtraOpcion.text=[[NSString alloc] initWithFormat:@"%d", [ self.VidasOtraOpcion.text intValue]-1];
        juego.VidasOtraOpcion=juego.VidasOtraOpcion-1;
        tieneOtraOpcion=YES;
        self.btnReloj.enabled=NO;
        self.btnBomba.enabled=NO;
        self.btnOtroOpcion.enabled=NO;
        self.btnNuevaPregunta.enabled=NO;
        
    }
}
- (IBAction)SeApretoNuevaPregunta:(id)sender {
    if( [self.VidasNuevaPregunta.text intValue]  >0) {
        self.VidasNuevaPregunta.text=[[NSString alloc] initWithFormat:@"%d", [ self.VidasNuevaPregunta.text intValue]-1];
        juego.VidasNPregunta=juego.VidasNPregunta-1;
        self.btnReloj.enabled=NO;
        self.btnBomba.enabled=NO;
        self.btnOtroOpcion.enabled=NO;
        self.btnNuevaPregunta.enabled=NO;
        [self recuperaEcoTipsLider];
    }
}

-(void)SeApretoRespuesta:(NSInteger)opcion{
    BOOL correcto=NO;
    if (opcion==[preguntaActual.RespuestaCorrecta integerValue]) {
        correcto=YES;
    };
    
    if(correcto==YES){
        if(opcion==0){
            [self.btnRespuesta1 setTitle:@"Correcto" forState:(UIControlStateNormal)];
            self.btnRespuesta1.userInteractionEnabled = NO;
            self.btnRespuesta2.enabled = NO;
            self.btnRespuesta3.enabled = NO;
            self.btnRespuesta4.enabled = NO;
            [self terminarJuego:TRUE];
            
        }else if (opcion==1) {
            [self.btnRespuesta2 setTitle:@"Correcto" forState:(UIControlStateNormal)];
            self.btnRespuesta1.enabled = NO;
            self.btnRespuesta2.userInteractionEnabled = NO;
            self.btnRespuesta3.enabled = NO;
            self.btnRespuesta4.enabled = NO;
            [self terminarJuego:TRUE];
        }else if (opcion==2) {
            [self.btnRespuesta3 setTitle:@"Correcto" forState:(UIControlStateNormal)];
            self.btnRespuesta1.enabled = NO;
            self.btnRespuesta2.enabled = NO;
            self.btnRespuesta3.userInteractionEnabled = NO;
            self.btnRespuesta4.enabled = NO;
            [self terminarJuego:TRUE];
        }else if (opcion==3) {
            [self.btnRespuesta4 setTitle:@"Correcto" forState:(UIControlStateNormal)];
            self.btnRespuesta1.enabled = NO;
            self.btnRespuesta2.enabled = NO;
            self.btnRespuesta3.enabled = NO;
            self.btnRespuesta4.userInteractionEnabled = NO;
            [self terminarJuego:TRUE];
        }

    }else{
        if(tieneOtraOpcion){
            if(opcion==0){
                [self.btnRespuesta1 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
                self.btnRespuesta1.enabled=NO;
            }else if (opcion==1) {
                [self.btnRespuesta2 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
                self.btnRespuesta2.enabled=NO;
            }else if (opcion==2) {
                [self.btnRespuesta3 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
                self.btnRespuesta3.enabled=NO;
            }else if (opcion==3) {
                [self.btnRespuesta4 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
                self.btnRespuesta4.enabled=NO;
            }
            tieneOtraOpcion=NO;
            
        }else{
            NSInteger value= [preguntaActual.RespuestaCorrecta integerValue];
            if(opcion==0){
                [self.btnRespuesta1 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
                self.btnRespuesta1.enabled = NO;
                self.btnRespuesta2.enabled = NO;
                self.btnRespuesta3.enabled = NO;
                self.btnRespuesta4.enabled = NO;
                
            }else if (opcion==1) {
                [self.btnRespuesta2 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
                self.btnRespuesta1.enabled = NO;
                self.btnRespuesta2.enabled = NO;
                self.btnRespuesta3.enabled = NO;
                self.btnRespuesta4.enabled = NO;
            }else if (opcion==2) {
                [self.btnRespuesta3 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
            }else if (opcion==3) {
                [self.btnRespuesta4 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
            }
        
            if(value==0){
                [self.btnRespuesta1 setTitle:@"Correcto" forState:(UIControlStateNormal)];
                self.btnRespuesta1.userInteractionEnabled = NO;
                self.btnRespuesta2.enabled = NO;
                self.btnRespuesta3.enabled = NO;
                self.btnRespuesta4.enabled = NO;
                [self terminarJuego:FALSE];
            }else if (value==1) {
                [self.btnRespuesta2 setTitle:@"Correcto" forState:(UIControlStateNormal)];
                self.btnRespuesta1.enabled = NO;
                self.btnRespuesta2.userInteractionEnabled = NO;
                self.btnRespuesta3.enabled = NO;
                self.btnRespuesta4.enabled = NO;
                [self terminarJuego:FALSE];
            }else if (value==2) {
                [self.btnRespuesta3 setTitle:@"Correcto" forState:(UIControlStateNormal)];
                self.btnRespuesta1.enabled = NO;
                self.btnRespuesta2.enabled = NO;
                self.btnRespuesta3.userInteractionEnabled = NO;
                self.btnRespuesta4.enabled = NO;
                [self terminarJuego:FALSE];
            }else if (value==3) {
                [self.btnRespuesta4 setTitle:@"Correcto" forState:(UIControlStateNormal)];
                self.btnRespuesta1.enabled = NO;
                self.btnRespuesta2.enabled = NO;
                self.btnRespuesta3.enabled = NO;
                self.btnRespuesta4.userInteractionEnabled = NO;
                [self terminarJuego:FALSE];
            }
        }
    
    }
    

}

- (IBAction)VerificarRespuesta1:(id)sender {
    [self SeApretoRespuesta:0];
}

- (IBAction)VerificarRespuesta2:(id)sender {
    [self SeApretoRespuesta:1];
}
- (IBAction)VerificarRespuesta3:(id)sender {
    [self SeApretoRespuesta:2];
}
- (IBAction)VerificarRespuesta4:(id)sender {
    [self SeApretoRespuesta:3];
}

- (void)viewWillAppear:(BOOL)animated {
    
    //[self CreaPregunta:0];

}

- (void) tick {

   self.Tiempo.text = [ [NSString alloc] initWithFormat:@"%d", [self.Tiempo.text intValue] -1] ;
    
    [self.BarraProgreso setProgress:(1-[self.Tiempo.text floatValue]/30) animated:YES];
    
    if([self.Tiempo.text intValue] == 0){
        [timer invalidate];
        [self terminarJuego:FALSE];
        
        
    }
    
    
    
    
}


-(void)dealloc{
    AudioServicesDisposeSystemSoundID(audioEffect);
}



@end
