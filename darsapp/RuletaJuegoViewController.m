//
//  RuletaJuegoViewController.m
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "RuletaJuegoViewController.h"
#import "ClasePregunta.h"
#import "ClaseRespuesta.h"

@interface RuletaJuegoViewController ()

@end

@implementation RuletaJuegoViewController

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
    ClaseRespuesta *resp1=[[ClaseRespuesta alloc] initConRespuesta:@"Naty" escorrecto:NO];
    ClaseRespuesta *resp2=[[ClaseRespuesta alloc] initConRespuesta:@"Jorge" escorrecto:NO];
    ClaseRespuesta *resp3=[[ClaseRespuesta alloc] initConRespuesta:@"Karina" escorrecto:NO];
    ClaseRespuesta *resp4=[[ClaseRespuesta alloc] initConRespuesta:@"James" escorrecto:YES];
    NSArray *ArregloResp=[NSArray arrayWithObjects:resp1,resp2,resp3,resp4,nil];
    ClasePregunta *pregunta1=[[ClasePregunta alloc] initConPregunta:@"Como me Llamo"  Respuestas:ArregloResp];
    ClaseRespuesta *resp5=[[ClaseRespuesta alloc] initConRespuesta:@"Naty" escorrecto:NO];
    ClaseRespuesta *resp6=[[ClaseRespuesta alloc] initConRespuesta:@"Jorge" escorrecto:NO];
    ClaseRespuesta *resp7=[[ClaseRespuesta alloc] initConRespuesta:@"Karina" escorrecto:NO];
    ClaseRespuesta *resp8=[[ClaseRespuesta alloc] initConRespuesta:@"James" escorrecto:YES];
    NSArray *ArregloResp1=[NSArray arrayWithObjects:resp5,resp6,resp7,resp8,nil];
    ClasePregunta *pregunta2=[[ClasePregunta alloc] initConPregunta:@"Como me Llamo"  Respuestas:ArregloResp1];
    
    
    
    ArregloPreguntas =[NSArray arrayWithObjects:pregunta1,pregunta2,nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SeapretoBoton:(id)sender {
    [self rotateImageView:self.ruleta ];
}

- (void)rotateImageView:(UIImageView *)iv
{
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         iv.transform = CGAffineTransformRotate(iv.transform, M_PI/2);
                         
                     }
                     completion:^(BOOL finished) {
                         if(finished)
                             //Esto se ejecuta en un hilo aparte
                             [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:1];
                         
                         //  [self rotateImageView:iv];
                     }];
}


-(void)irASeleccionado
{
    [self performSegueWithIdentifier:@"ViewPreguntas" sender:self];
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
