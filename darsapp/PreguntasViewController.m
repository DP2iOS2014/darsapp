//
//  PreguntasViewController.m
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "PreguntasViewController.h"
#import "ClasePregunta.h"
#import "ClaseRespuesta.h"
#import "preguntaProgressView.h"
#import "SingletonJuego.h"
@interface PreguntasViewController ()

@end

@implementation PreguntasViewController

{
    ClasePregunta *preguntaActual;
}
static SingletonJuego *juego;

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
    juego= [SingletonJuego sharedManager];
    ClaseRespuesta *resp1=[[ClaseRespuesta alloc] initConRespuesta:@"Naty" escorrecto:NO];
    ClaseRespuesta *resp2=[[ClaseRespuesta alloc] initConRespuesta:@"Jorge" escorrecto:NO];
    ClaseRespuesta *resp3=[[ClaseRespuesta alloc] initConRespuesta:@"Karina" escorrecto:NO];
    ClaseRespuesta *resp4=[[ClaseRespuesta alloc] initConRespuesta:@"James" escorrecto:YES];
    NSArray *ArregloResp=[NSArray arrayWithObjects:resp1,resp2,resp3,resp4,nil];
    ClasePregunta *pregunta1=[[ClasePregunta alloc] initConPregunta:@"Como me Llamo?"  Respuestas:ArregloResp];
    ClaseRespuesta *resp5=[[ClaseRespuesta alloc] initConRespuesta:@"Naty" escorrecto:NO];
    ClaseRespuesta *resp6=[[ClaseRespuesta alloc] initConRespuesta:@"Jorge" escorrecto:NO];
    ClaseRespuesta *resp7=[[ClaseRespuesta alloc] initConRespuesta:@"Karina" escorrecto:NO];
    ClaseRespuesta *resp8=[[ClaseRespuesta alloc] initConRespuesta:@"James" escorrecto:YES];
    NSArray *ArregloResp1=[NSArray arrayWithObjects:resp5,resp6,resp7,resp8,nil];
    ClasePregunta *pregunta2=[[ClasePregunta alloc] initConPregunta:@"Como me Llamo?"  Respuestas:ArregloResp1];
    
    
    
    ArregloPreguntas =[NSArray arrayWithObjects:pregunta1,pregunta2,nil];
    
    tieneOtraOpcion=NO;
    self.Tiempo.text= [[NSString alloc] initWithFormat:@"%ld",(long)juego.Tiempo] ;
    self.VidasReloj.text= [[NSString alloc] initWithFormat:@"%ld",(long)juego.VidasReloj] ;
    self.VidasBomba.text= [[NSString alloc] initWithFormat:@"%ld",(long)juego.VidasBomba] ;
    self.VidasOtraOpcion.text= [[NSString alloc] initWithFormat:@"%ld",(long)juego.VidasOtraOpcion] ;
    
    self.btnReloj.enabled=juego.disponibilidadBoton;
    self.btnBomba.enabled=juego.disponibilidadBoton;
    self.btnOtroOpcion.enabled=juego.disponibilidadBoton;
    self.btnNuevaPregunta.enabled=juego.disponibilidadBoton;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)SeApretoReloj:(id)sender {
    if( juego.VidasReloj  >0) {
        juego.Tiempo= juego.Tiempo+30;
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
        //int value= [self.Tiempo.text intValue]+30;
        //self.Tiempo.text= [[NSString alloc] initWithFormat:@"%d",value] ;
        
        int valor1 = arc4random()%4;
        int valor2 = arc4random()%4;
        while(valor1 == valor2){
            valor2 = arc4random()%4;
        }
        
        if (valor1 == 1 || valor2 == 1) {
            self.btnRespuesta1.enabled=NO;
        }
        if (valor1 == 2 || valor2 == 2) {
            self.btnRespuesta2.enabled=NO;
        }
        if (valor1 == 3 || valor2 == 3) {
            self.btnRespuesta3.enabled=NO;
        }
        if (valor1 == 4 || valor2 == 4) {
            self.btnRespuesta4.enabled=NO;
        }
        
        self.VidasBomba.text=[[NSString alloc] initWithFormat:@"%d", [ self.VidasReloj.text intValue]-1];
        self.btnReloj.enabled=NO;
        self.btnBomba.enabled=NO;
        self.btnOtroOpcion.enabled=NO;
        self.btnNuevaPregunta.enabled=NO;
    }
    
    
    
}

- (IBAction)SeApretoOtraOpcion:(id)sender {
    if( [self.VidasOtraOpcion.text intValue]  >0) {
        self.VidasOtraOpcion.text=[[NSString alloc] initWithFormat:@"%d", [ self.VidasOtraOpcion.text intValue]-1];
        tieneOtraOpcion=YES;
        self.btnReloj.enabled=NO;
        self.btnBomba.enabled=NO;
        self.btnOtroOpcion.enabled=NO;
        self.btnNuevaPregunta.enabled=NO;
    }
}

-(void)SeApretoRespuesta:(NSInteger)opcion{
    BOOL correcto=[preguntaActual EsPreguntaCorrecta:opcion];
    
    
    if(correcto==YES){
        if(opcion==0){
            [self.btnRespuesta1 setTitle:@"Correcto" forState:(UIControlStateNormal)];
        }else if (opcion==1) {
            [self.btnRespuesta2 setTitle:@"Correcto" forState:(UIControlStateNormal)];
        }else if (opcion==2) {
            [self.btnRespuesta3 setTitle:@"Correcto" forState:(UIControlStateNormal)];
        }else if (opcion==3) {
            [self.btnRespuesta4 setTitle:@"Correcto" forState:(UIControlStateNormal)];
        }

        

    }else{
    
    
    
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
    
 //   NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target: self selector:@selector(tick) userInfo:nil repeats:YES];
    
    preguntaActual=[ArregloPreguntas objectAtIndex:0];
    self.pregunta.text=[[ArregloPreguntas objectAtIndex:0] PreguntaARealizar];
    NSArray *resp=[[ArregloPreguntas objectAtIndex:0] ArregloRespuestas];
    
    [self.btnRespuesta1 setTitle: [[resp objectAtIndex:0] respuesta] forState: UIControlStateNormal];
    [self.btnRespuesta2 setTitle: [[resp objectAtIndex:1] respuesta] forState: UIControlStateNormal];
    [self.btnRespuesta3 setTitle: [[resp objectAtIndex:2] respuesta] forState: UIControlStateNormal];
    [self.btnRespuesta4 setTitle: [[resp objectAtIndex:3] respuesta] forState: UIControlStateNormal];
    
    

}

//- (void) tick {

  //  TimarLabel.text = [ [NSString alloc] initWithFormat:@"%d", [TimarLabel.text intValue] -1];
    
//}


@end
