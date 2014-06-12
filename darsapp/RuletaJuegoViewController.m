//
//  RuletaJuegoViewController.m
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "RuletaJuegoViewController.h"
#import "PreguntasViewController.h"
#import "UIImage+Tint.h"
#import <AudioToolbox/AudioToolbox.h>
#import "SingletonJuego.h"


@interface RuletaJuegoViewController ()

@end

@implementation RuletaJuegoViewController
{
    SingletonJuego *juego;
    int numerotema;
    CGFloat rotacion;
    SystemSoundID audioEffect;
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
    juego= [SingletonJuego sharedManager];
    
    self.vidasCorazon.image = [self.vidasCorazon.image imageWithColor:[UIColor colorWithRed:213.0/255 green:89.0/255 blue:91.0/255 alpha:1]];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //self.vidasCorazon.image = [self.vidasCorazon.image imageTintedWithColor:[UIColor redColor]]; //Colorful imag


}

- (void) viewWillAppear:(BOOL)animated{
    
    NSUserDefaults * datosDeUsuario = [NSUserDefaults standardUserDefaults];
    
    double puntajeActual = [datosDeUsuario doubleForKey:@"puntajeActualJuegoRuleta"];
    
    self.ptjActual.text = [NSString stringWithFormat:@"%0.2f",puntajeActual];
    
    NSInteger vidas = [datosDeUsuario doubleForKey:@"vidasJuegoRuleta"];

    self.vidasRuleta.text=[NSString stringWithFormat:@"%i",vidas];;
    self.ruleta.transform=CGAffineTransformMakeRotation(0);

    self.btnGiraRuleta.userInteractionEnabled=YES;
    self.navigationItem.hidesBackButton = NO;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SeapretoBoton:(id)sender {
    
    self.navigationItem.backBarButtonItem.enabled=NO;
    self.navigationItem.hidesBackButton = YES;
    NSString *path  = [[NSBundle mainBundle] pathForResource:@"gira_gira_sin_modif" ofType:@"wav"];
    NSURL *pathURL = [NSURL fileURLWithPath : path];
    
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
    AudioServicesPlaySystemSound(audioEffect);
    
    self.btnGiraRuleta.userInteractionEnabled=NO;
    
    [self rotateImageView:self.ruleta ];
    
}

- (void)rotateImageView:(UIImageView *)iv
{
    rotacion=(M_PI/2);
    //rotacion=-(M_PI/2);
    [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         //iv.transform = CGAffineTransformRotate(iv.transform, rotacion);
                         iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                         
                     }
                     completion:^(BOOL finished) {
                         
                      [UIView animateWithDuration:.08 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                          //iv.transform = CGAffineTransformRotate(iv.transform, rotacion);
                          iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                      } completion:^(BOOL finished) {
                          
                          [UIView animateWithDuration:.09 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                              iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                              //iv.transform = CGAffineTransformRotate(iv.transform, rotacion);
                          } completion:^(BOOL finished) {
                              
                              
                              [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                  iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                                  //iv.transform = CGAffineTransformRotate(iv.transform, rotacion);
                              } completion:^(BOOL finished) {
                                  
                                  
                                  [UIView animateWithDuration:.11 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                      iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                                      //iv.transform = CGAffineTransformRotate(iv.transform, rotacion);
                                  } completion:^(BOOL finished) {
                                      
                                      [UIView animateWithDuration:.12 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                          iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                                          //iv.transform = CGAffineTransformRotate(iv.transform, rotacion);
                                      } completion:^(BOOL finished) {
                                          
                                          [UIView animateWithDuration:.13 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                            iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                                            //  iv.transform = CGAffineTransformRotate(iv.transform, rotacion);
                                          } completion:^(BOOL finished) {
                                              
                                              [UIView animateWithDuration:.14 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                  iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                                                  //iv.transform = CGAffineTransformRotate(iv.transform, rotacion);
                                              } completion:^(BOOL finished) {
                                                  
                                                  [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                     iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                                                      //iv.transform = CGAffineTransformRotate(iv.transform, rotacion);
                                                  } completion:^(BOOL finished) {
                                                      
                                                      [UIView animateWithDuration:.19 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                        iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                                                          //iv.transform = CGAffineTransformRotate(iv.transform, rotacion);
                                                      } completion:^(BOOL finished) {
                                                          
                                                          [UIView animateWithDuration:.21 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                              iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                                                              //iv.transform = CGAffineTransformRotate(iv.transform, rotacion);
                                                          } completion:^(BOOL finished) {
                                                              
                                                              [UIView animateWithDuration:.23 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                 iv.layer.transform = CATransform3DRotate(iv.layer.transform, rotacion, 0, 0, 1);
                                                                  
                                                                  
                                                                  //CGAffineTransformRotate(iv.transform, rotacion);
                                                              } completion:^(BOOL finished) {
                                                                
                                                                  
                                                                 
                                                                  
                                                                  CGFloat angulo=72.0f*(M_PI/180.0f);
                                                                  
                                                                      if(finished){
                                                                          numerotema =  arc4random()%4;
                                                                          
                                                                          if(numerotema==0){
                                                                              juego.apretoCorona=YES;
                                                                              AudioServicesDisposeSystemSoundID(audioEffect);
                                                                               [self performSelector:@selector(irASeleccionado2) withObject:nil afterDelay:1];
                                            
                                                                          }else if (numerotema==1){
                                                                              [UIView animateWithDuration:.24 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                                  //iv.transform = CGAffineTransformRotate(iv.transform, angulo);
                                                                                  iv.layer.transform = CATransform3DRotate(iv.layer.transform, angulo, 0, 0, 1);
                                                                              } completion:^(BOOL finished) {
                                                                                  if(finished){
                                                                                    AudioServicesDisposeSystemSoundID(audioEffect);
                                                                                      [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:1];
                                                                                  }
                                                                                  
                                                                              }];
                                                                               
                                                                          }else if (numerotema==2){
                                                                              [UIView animateWithDuration:.24 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                                  
                                                                                  //iv.transform = CGAffineTransformRotate(iv.transform, angulo);
                                                                                  iv.layer.transform = CATransform3DRotate(iv.layer.transform, angulo, 0, 0, 1);
                                                                                  
                                                                              } completion:^(BOOL finished) {
                                                                                  
                                                                                  if(finished){
                                                                                      [UIView animateWithDuration:.24 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                                      
                                                                                          //iv.layer.transform = CGAffineTransformRotate(iv.transform, angulo);
                                                                                          iv.layer.transform = CATransform3DRotate(iv.layer.transform, angulo, 0, 0, 1);
                                                                                      }  completion:^(BOOL finished) {
                                                                                          if(finished){
                                                                                              AudioServicesDisposeSystemSoundID(audioEffect);
                                                                                              [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:1];
                                                                                          }
                                                                                      
                                                                                      
                                                                                  }];
                                                                                  }
  
                                                                              }];
                                                                          }else if (numerotema==3){
                                                                              [UIView animateWithDuration:.24 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                                  
                                                                                  //iv.transform = CGAffineTransformRotate(iv.transform, angulo);
                                                                                       iv.layer.transform = CATransform3DRotate(iv.layer.transform, angulo, 0, 0, 1);
                                                                              } completion:^(BOOL finished) {
                                                                                  
                                                                                  [UIView animateWithDuration:.24 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                                      
                                                                                      //iv.transform = CGAffineTransformRotate(iv.transform, angulo);
                                                                                           iv.layer.transform = CATransform3DRotate(iv.layer.transform, angulo, 0, 0, 1);
                                                                                  } completion:^(BOOL finished) {
                                                                                      [UIView animateWithDuration:.24 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                                          
                                                                                          //iv.transform = CGAffineTransformRotate(iv.transform, angulo);
                                                                                               iv.layer.transform = CATransform3DRotate(iv.layer.transform, angulo, 0, 0, 1);
                                                                                      } completion:^(BOOL finished) {
                                                                                          AudioServicesDisposeSystemSoundID(audioEffect);
                                                                                          [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:1];
                                                                                          
                                                                                      }];
                                                                                      
                                                                                  }];
                                                                                  
                                                                              }];
                                                                              
                                                                          }else{
                                                                              
                                                                              [UIView animateWithDuration:.24 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                                  
                                                                                  //iv.transform = CGAffineTransformRotate(iv.transform, angulo);
                                                                                       iv.layer.transform = CATransform3DRotate(iv.layer.transform, angulo, 0, 0, 1);
                                                                              } completion:^(BOOL finished) {
                                                                                  
                                                                                  [UIView animateWithDuration:.24 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                                      
                                                                                     // iv.transform = CGAffineTransformRotate(iv.transform, angulo);
                                                                                           iv.layer.transform = CATransform3DRotate(iv.layer.transform, angulo, 0, 0, 1);
                                                                                  } completion:^(BOOL finished) {
                                                                                      [UIView animateWithDuration:.24 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                                          
                                                                                         // iv.transform = CGAffineTransformRotate(iv.transform, angulo);
                                                                                               iv.layer.transform = CATransform3DRotate(iv.layer.transform, angulo, 0, 0, 1);
                                                                                      } completion:^(BOOL finished) {
                                                                                          [UIView animateWithDuration:.24 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                                              
                                                                                             // iv.transform = CGAffineTransformRotate(iv.transform, angulo);
                                                                                                   iv.layer.transform = CATransform3DRotate(iv.layer.transform, angulo, 0, 0, 1);
                                                                                          } completion:^(BOOL finished) {
                                                                                              //Esto se ejecuta en un hilo aparte
                                                                                              AudioServicesDisposeSystemSoundID(audioEffect);
                                                                                              [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:1];
                                                                                              
                                                                                          }];
                                                                                          
                                                                                      }];
                                                                                      
                                                                                  }];
                                                                                  
                                                                              }];
                                                                            
                                                                          }
                                                                      }
                                                                      
                                                                          
                                                                     
                                                                      
                                                                  }];
 
                                                              }];

                                                          }];

                                                      }];

                                                  }];

                                              }];

                                          }];

                                      }];

                                  }];

                                  
                              }];


                              
                          }];

                      }];
                         
                        

}

-(void)apretoOkAlFallaPregunta{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)irASeleccionado
{
    [self performSegueWithIdentifier:@"ViewPreguntas" sender:self];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual:@"ViewPreguntas"]) {
        PreguntasViewController *escenadestino = segue.destinationViewController;
        escenadestino.delegate = self;
        //ACA SE PONE EL ID DEL TEMA QUE SALIO EN LA RULETA
        escenadestino.idtema = numerotema;
    }

};

-(void)irASeleccionado2
{
    [self performSegueWithIdentifier:@"ViewCorona" sender:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    
}

-(void)dealloc{
    AudioServicesDisposeSystemSoundID(audioEffect);
}


@end
