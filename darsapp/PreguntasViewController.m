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
#import "SFSConfettiScreen.h"
#import "YLProgressBar.h"
#import "UIImage+Tint.h"

@interface PreguntasViewController ()

@end

typedef void (^myCompletion)(BOOL);

@implementation PreguntasViewController

{
    SingletonJuego *juego;
    ClasePregunta *preguntaActual;
    NSDictionary * respuestajson;
    SystemSoundID audioEffect;
    NSInteger puntajeActual;
    NSInteger vidasActual;
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


- (void)initRoundedFatProgressBar
{
    
    _progressBarRoundedFat.progressTintColor        = [UIColor colorWithRed:68/255.0f green:195/255.0f blue:172/255.0f alpha:1.0f];
    _progressBarRoundedFat.stripesColor             = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.36f];
    
}



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //Barra de progreso
    [self initRoundedFatProgressBar];
    //Fondo de pantalla
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
    
    
    [self recuperaEcoTipsLider];
    juego= [SingletonJuego sharedManager];

    
    NSUserDefaults * datosUsuario = [NSUserDefaults standardUserDefaults];
    puntajeActual = [datosUsuario doubleForKey:@"puntajeActualJuegoRuleta"];
    vidasActual = [datosUsuario doubleForKey:@"vidasJuegoRuleta"];
    
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
    
    self.btnReloj.userInteractionEnabled=YES;
    self.btnBomba.userInteractionEnabled=YES;
    self.btnOtroOpcion.userInteractionEnabled=YES;
    self.btnNuevaPregunta.userInteractionEnabled=YES;
    
    self.btnReloj.imageView.image = [self.btnReloj.imageView.image imageWithColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1]];
    self.btnBomba.imageView.image = [self.btnBomba.imageView.image imageWithColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1]];
    self.btnOtroOpcion.imageView.image = [self.btnOtroOpcion.imageView.image imageWithColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1]];
    self.btnNuevaPregunta.imageView.image = [self.btnNuevaPregunta.imageView.image imageWithColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1]];
    
    
}

- (void)viewDidUnload
{
    self.progressBarRoundedFat        = nil;
    self.colorsSegmented              = nil;
    
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else
    {
        return UIInterfaceOrientationMaskAll;
    }
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [_progressBarRoundedFat setProgress:progress animated:animated];
}



-(void) recuperaEcoTipsLider{
    
    
    
    NSInteger puntaje;
    
    //NSInteger idtipopregunta=0;
    NSString *tipotema;
    
    puntaje = 10;
    
    
    //PARA ENVIAR PRIMI
    
    if(self.idtema==0){

    }
    
    if(self.idtema==1){
        tipotema=@"Proyectos DARS" ;
        
    }
    
    if(self.idtema==2){
         tipotema= @"Datos Curiosos";
        
    }
    
    if(self.idtema==3){
       tipotema= @"Cultura Ambiental";
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
       
        
    }
          failure:^(AFHTTPRequestOperation *task, NSError *error) {
              if(!alertView.visible){
              alertView = [[UIAlertView alloc] initWithTitle:@"No choco con el servidor" message:[error localizedDescription]
                                                                 delegate:nil
                                                        cancelButtonTitle:@"Ok"
                                                        otherButtonTitles:nil];
              [alertView show];
              }
          }];

    
   
    
}




/*Seleccion de Poderes*/

- (IBAction)SeApretoReloj:(id)sender {
    
    if( juego.VidasReloj  >0) {
        NSString *path  = [[NSBundle mainBundle] pathForResource:@"clock" ofType:@"wav"];
        NSURL *pathURL = [NSURL fileURLWithPath : path];
        
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
        
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
   UIColor * color = [UIColor colorWithRed:210/255.0f green:9/255.0f blue:0/255.0f alpha:1.0f];
    if( [self.VidasBomba.text intValue]  >0) {
        NSString *path  = [[NSBundle mainBundle] pathForResource:@"Bomb" ofType:@"wav"];
        NSURL *pathURL = [NSURL fileURLWithPath : path];
        
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
        
        int value=[preguntaActual.RespuestaCorrecta intValue];
        
        int valor1 = arc4random()%4;
        int valor2 = arc4random()%4;
        
        while (valor1 == value) {
            
            valor1 = arc4random()%4;
        }
        
        while(valor2 == valor1 || valor2 == value){
            
            valor2 = arc4random()%4;
            
        }

        
        if (valor1 == 0 || valor2 == 0) {
            self.btnRespuesta1.enabled=NO;
            [self.btnRespuesta1 setTitleColor:color forState:UIControlStateNormal];
            
        }
        if (valor1 == 1 || valor2 == 1) {
            self.btnRespuesta2.enabled=NO;
             [self.btnRespuesta2 setTitleColor:color forState:UIControlStateNormal];
            
        }
        if (valor1 == 2 || valor2 == 2) {
            self.btnRespuesta3.enabled=NO;
             [self.btnRespuesta3 setTitleColor:color forState:UIControlStateNormal];
            
        }
        if (valor1 == 3 || valor2 == 3) {
            self.btnRespuesta4.enabled=NO;
             [self.btnRespuesta4 setTitleColor:color forState:UIControlStateNormal];
            
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
       // NSString *path  = [[NSBundle mainBundle] pathForResource:@"Bomb" ofType:@"wav"];
       // NSURL *pathURL = [NSURL fileURLWithPath : path];
        
        
        //AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        //AudioServicesPlaySystemSound(audioEffect);
        
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
        NSString *path  = [[NSBundle mainBundle] pathForResource:@"repregunta" ofType:@"wav"];
        NSURL *pathURL = [NSURL fileURLWithPath : path];
        
        
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
        
        self.VidasNuevaPregunta.text=[[NSString alloc] initWithFormat:@"%d", [ self.VidasNuevaPregunta.text intValue]-1];
        juego.VidasNPregunta=juego.VidasNPregunta-1;
        self.btnReloj.enabled=NO;
        self.btnBomba.enabled=NO;
        self.btnOtroOpcion.enabled=NO;
        self.btnNuevaPregunta.enabled=NO;
        [self recuperaEcoTipsLider];
    }
}

/* termino se apreto boton*/

/*Selecciono pregunta*/
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

-(void)SeApretoRespuesta:(NSInteger)opcion{
    BOOL correcto=NO;
    if (opcion==[preguntaActual.RespuestaCorrecta integerValue]) {
        correcto=YES;
    };
    
    if(correcto==YES){
        if(opcion==0){
            [self.btnRespuesta1 setTitle:@"Correcto" forState:(UIControlStateNormal)];
            [self.btnRespuesta1  setTitleColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1] forState:UIControlStateNormal];
            self.btnRespuesta1.titleLabel.font = [UIFont systemFontOfSize:25];
            self.btnRespuesta1.userInteractionEnabled = NO;
            self.btnRespuesta2.enabled = NO;
            self.btnRespuesta3.enabled = NO;
            self.btnRespuesta4.enabled = NO;
            self.btnReloj.userInteractionEnabled=NO;
            self.btnBomba.userInteractionEnabled=NO;
            self.btnOtroOpcion.userInteractionEnabled=NO;
            self.btnNuevaPregunta.userInteractionEnabled=NO;
            [self terminarJuego:0];
            
        }else if (opcion==1) {
            [self.btnRespuesta2 setTitle:@"Correcto" forState:(UIControlStateNormal)];
            [self.btnRespuesta2  setTitleColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1] forState:UIControlStateNormal];
            self.btnRespuesta2.titleLabel.font = [UIFont systemFontOfSize:25];
            self.btnRespuesta1.enabled = NO;
            self.btnRespuesta2.userInteractionEnabled = NO;
            self.btnRespuesta3.enabled = NO;
            self.btnRespuesta4.enabled = NO;
            self.btnReloj.userInteractionEnabled=NO;
            self.btnBomba.userInteractionEnabled=NO;
            self.btnOtroOpcion.userInteractionEnabled=NO;
            self.btnNuevaPregunta.userInteractionEnabled=NO;
            [self terminarJuego:0];
        }else if (opcion==2) {
            [self.btnRespuesta3 setTitle:@"Correcto" forState:(UIControlStateNormal)];
            [self.btnRespuesta3  setTitleColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1] forState:UIControlStateNormal];
            self.btnRespuesta3.titleLabel.font = [UIFont systemFontOfSize:25];
            self.btnRespuesta1.enabled = NO;
            self.btnRespuesta2.enabled = NO;
            self.btnRespuesta3.userInteractionEnabled = NO;
            self.btnRespuesta4.enabled = NO;
            self.btnReloj.userInteractionEnabled=NO;
            self.btnBomba.userInteractionEnabled=NO;
            self.btnOtroOpcion.userInteractionEnabled=NO;
            self.btnNuevaPregunta.userInteractionEnabled=NO;
            [self terminarJuego:0];
        }else if (opcion==3) {
            [self.btnRespuesta4 setTitle:@"Correcto" forState:(UIControlStateNormal)];
            [self.btnRespuesta4  setTitleColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1] forState:UIControlStateNormal];
            self.btnRespuesta4.titleLabel.font = [UIFont systemFontOfSize:25];
            self.btnRespuesta1.enabled = NO;
            self.btnRespuesta2.enabled = NO;
            self.btnRespuesta3.enabled = NO;
            self.btnRespuesta4.userInteractionEnabled = NO;
            self.btnReloj.userInteractionEnabled=NO;
            self.btnBomba.userInteractionEnabled=NO;
            self.btnOtroOpcion.userInteractionEnabled=NO;
            self.btnNuevaPregunta.userInteractionEnabled=NO;
            [self terminarJuego:0];
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
            vidasActual=vidasActual-1;
            if(opcion==0){
                [self.btnRespuesta1 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
                [self.btnRespuesta1  setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                self.btnRespuesta1.titleLabel.font = [UIFont systemFontOfSize:25];
                
            }else if (opcion==1) {
                [self.btnRespuesta2 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
                [self.btnRespuesta2  setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                self.btnRespuesta2.titleLabel.font = [UIFont systemFontOfSize:25];
                
            }else if (opcion==2) {
                [self.btnRespuesta3 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
                [self.btnRespuesta3  setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                self.btnRespuesta3.titleLabel.font = [UIFont systemFontOfSize:25];
            }else if (opcion==3) {
                [self.btnRespuesta4 setTitle:@"InCorrecto" forState:(UIControlStateNormal)];
                [self.btnRespuesta4  setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                self.btnRespuesta4.titleLabel.font = [UIFont systemFontOfSize:25];
            }
        
            self.btnReloj.userInteractionEnabled=NO;
            self.btnBomba.userInteractionEnabled=NO;
            self.btnOtroOpcion.userInteractionEnabled=NO;
            self.btnNuevaPregunta.userInteractionEnabled=NO;
            
            
            if(value==0){
                [self.btnRespuesta1 setTitle:@"Correcto" forState:(UIControlStateNormal)];
                self.btnRespuesta1.userInteractionEnabled = NO;
                [self.btnRespuesta1  setTitleColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1] forState:UIControlStateNormal];
                self.btnRespuesta2.enabled = NO;
                self.btnRespuesta3.enabled = NO;
                self.btnRespuesta4.enabled = NO;
                if(vidasActual==0){
                    [self terminarJuego:1];
                }else {
                    [self terminarJuego:2];
                    
                }
            }else if (value==1) {
                [self.btnRespuesta2 setTitle:@"Correcto" forState:(UIControlStateNormal)];
                [self.btnRespuesta2  setTitleColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1] forState:UIControlStateNormal];
                self.btnRespuesta1.enabled = NO;
                self.btnRespuesta2.userInteractionEnabled = NO;
                self.btnRespuesta3.enabled = NO;
                self.btnRespuesta4.enabled = NO;
                if(vidasActual==0){
                    [self terminarJuego:1];
                }else {
                    [self terminarJuego:2];
                    
                }
            }else if (value==2) {
                [self.btnRespuesta3 setTitle:@"Correcto" forState:(UIControlStateNormal)];
                [self.btnRespuesta3  setTitleColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1] forState:UIControlStateNormal];
                self.btnRespuesta1.enabled = NO;
                self.btnRespuesta2.enabled = NO;
                self.btnRespuesta3.userInteractionEnabled = NO;
                self.btnRespuesta4.enabled = NO;
                if(vidasActual==0){
                    [self terminarJuego:1];
                }else {
                    [self terminarJuego:2];
                    
                }
            }else if (value==3) {
                [self.btnRespuesta4 setTitle:@"Correcto" forState:(UIControlStateNormal)];
                [self.btnRespuesta4  setTitleColor:[UIColor colorWithRed:63.0/255 green:192.0/255 blue:169.0/255 alpha:1] forState:UIControlStateNormal];
                self.btnRespuesta1.enabled = NO;
                self.btnRespuesta2.enabled = NO;
                self.btnRespuesta3.enabled = NO;
                self.btnRespuesta4.userInteractionEnabled = NO;
                if(vidasActual==0){
                    [self terminarJuego:1];
                }else {
                    [self terminarJuego:2];
                    
                }
                
            }
        }
    
    }
    

}

/* termino seleccionar respuesta*/


/*Terminar Juego*/
-(void) terminarJuego: (int) Correcta
{
    // 0: Acerto a la pregunta , 1: Perdio todo el juego , 2:Fallo pregunta pero aun tiene vidas
    if(Correcta==0){
        SFSConfettiScreen * confetti = [[SFSConfettiScreen alloc] initWithFrame:CGRectMake(0, 0, 400, 400)];
        [self.view addSubview:confetti];
        
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
        [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:3];
        
    }else if (Correcta==1){
        //Mandar puntaje a back END
        NSUserDefaults * datosUsuario = [NSUserDefaults standardUserDefaults];
        
        NSString * nombreUsuario = [datosUsuario stringForKey:@"Visitante"];
        [[NSUserDefaults standardUserDefaults] setInteger:vidasActual forKey:@"vidasJuegoRuleta"];
        
        if([nombreUsuario isEqualToString:@"N"]){
            int puntajeMaximo = [datosUsuario doubleForKey:@"puntajeMaximoRuleta"];
            if(puntajeActual>puntajeMaximo){
            [[NSUserDefaults standardUserDefaults] setDouble:puntajeActual forKey:@"puntajeMaximoRuleta"];
            [self GuardarPuntajeJuego];
            }
        }
        [self performSelector:@selector(irAHacerHora) withObject:nil afterDelay:2];
        
    }else if (Correcta==2){
        [[NSUserDefaults standardUserDefaults] setInteger:vidasActual forKey:@"vidasJuegoRuleta"];
        juego.Tiempo = 30;
        juego.tieneOtraOpcion = NO;
        juego.disponibilidadBoton=YES;
        juego.disponibilidadRespuesta1 = YES;
        juego.disponibilidadRespuesta2 = YES;
        juego.disponibilidadRespuesta3 = YES;
        juego.disponibilidadRespuesta4 = YES;
        [timer invalidate];
        [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:3];
    }
    
    
    
}

-(void)GuardarPuntajeJuego{
    NSUserDefaults * datosUsuario = [NSUserDefaults standardUserDefaults];
    NSString * nombreUsuario = [datosUsuario stringForKey:@"NombreUsuario"];

    NSDictionary *cuerpo = [[NSDictionary alloc] initWithObjectsAndKeys:@"guardarPuntaje",@"tipo",nombreUsuario,@"usuario", [NSString stringWithFormat:@"%d",puntajeActual],@"puntaje", nil];
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Almacenamiento",@"operacion",cuerpo,@"cuerpo", nil];
    
    NSLog(@"%@", consulta);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:RecuperoTemas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        
        NSDictionary * respuestajson = responseObject;
        
        NSLog(@"JSON: %@", respuestajson);
        
        //NSDictionary * cuerpo = [respuestajson objectForKey:@"cuerpo"];
        
        //NSArray * listaNodos = [cuerpo objectForKey:@"listaNodos"];
        
        //NSString *estado = [[listaNodos objectAtIndex:0] objectForKey:@"estado"];
        
        
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
    if(juego.apretoCorona){
        juego.apretoCorona=NO;
        //[self dismissViewControllerAnimated:YES completion:nil];
        [self myMethod:^(BOOL finished) {
            if(finished){
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        
        
        

    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void) myMethod:(myCompletion) compblock {
    [self.delegate DesapareceModalCuandoTocoCorona];
    compblock (YES);

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [timer invalidate];
    
   
    //[self dismissViewControllerAnimated:YES completion:nil];
    
    if(juego.apretoCorona){
        juego.apretoCorona=NO;
        //[self dismissViewControllerAnimated:YES completion:nil];
        [self myMethod:^(BOOL finished) {
            if(finished){
                [self.delegate apretoOkAlFallaPregunta2];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        
        
        
        
    }else{
    [self.delegate apretoOkAlFallaPregunta];
    [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

/*Se termino el termino juego*/






- (void) tick {

   self.Tiempo.text = [ [NSString alloc] initWithFormat:@"%d", [self.Tiempo.text intValue] -1] ;
   //[self.BarraProgreso setProgress:(1-[self.Tiempo.text floatValue]/30) animated:YES];
    
    [self.progressBarRoundedFat setProgress:(1-[self.Tiempo.text floatValue]/30) animated:YES];
    if([self.Tiempo.text intValue] == 0){
        [timer invalidate];
        NSUserDefaults * datosDeUsuario = [NSUserDefaults standardUserDefaults];
        NSInteger vidas = [datosDeUsuario doubleForKey:@"vidasJuegoRuleta"];
        vidasActual=vidasActual-1;
        self.btnRespuesta1.enabled = NO;
        self.btnRespuesta2.enabled = NO;
        self.btnRespuesta3.enabled = NO;
        self.btnRespuesta4.enabled = NO;
        if(vidas>0){
            [self terminarJuego:2];
        }else{
            [self terminarJuego:1];
        }
        
        
    }
}


-(void)dealloc{
    AudioServicesDisposeSystemSoundID(audioEffect);
}



@end
