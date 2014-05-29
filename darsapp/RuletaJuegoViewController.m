//
//  RuletaJuegoViewController.m
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "RuletaJuegoViewController.h"
#import "PreguntasViewController.h"


@interface RuletaJuegoViewController ()

@end

@implementation RuletaJuegoViewController

    NSInteger *numerotema;

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

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)SeapretoBoton:(id)sender {
    self.btnGiraRuleta.userInteractionEnabled=NO;
    [self rotateImageView:self.ruleta ];
    self.btnGiraRuleta.userInteractionEnabled=YES;
    
}

- (void)rotateImageView:(UIImageView *)iv
{
    [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                         
                     }
                     completion:^(BOOL finished) {
                         
                      [UIView animateWithDuration:.08 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                          iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                      } completion:^(BOOL finished) {
                          
                          [UIView animateWithDuration:.09 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                              
                              iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                          } completion:^(BOOL finished) {
                              
                              
                              [UIView animateWithDuration:.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                  
                                  iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                              } completion:^(BOOL finished) {
                                  
                                  
                                  [UIView animateWithDuration:.11 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                      
                                      iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                                  } completion:^(BOOL finished) {
                                      
                                      [UIView animateWithDuration:.12 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                          
                                          iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                                      } completion:^(BOOL finished) {
                                          
                                          [UIView animateWithDuration:.13 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                              
                                              iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                                          } completion:^(BOOL finished) {
                                              
                                              [UIView animateWithDuration:.14 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                  
                                                  iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                                              } completion:^(BOOL finished) {
                                                  
                                                  [UIView animateWithDuration:.15 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                      
                                                      iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                                                  } completion:^(BOOL finished) {
                                                      
                                                      [UIView animateWithDuration:.19 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                          
                                                          iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                                                      } completion:^(BOOL finished) {
                                                          
                                                          [UIView animateWithDuration:.21 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                              
                                                              iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                                                          } completion:^(BOOL finished) {
                                                              
                                                              [UIView animateWithDuration:.23 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                  
                                                                  iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                                                              } completion:^(BOOL finished) {
                                                                  
                                                                  [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                                                                      
                                                                      iv.transform = CGAffineTransformRotate(iv.transform, (M_PI/2));
                                                                  } completion:^(BOOL finished) {
                                                                      if(finished)
                                                                          //Esto se ejecuta en un hilo aparte
                                                                          [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:1];
                                                                      
                                                                      //  [self rotateImageView:iv];
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
                         
                        
                     }];


}


-(void)irASeleccionado
{
    [self performSegueWithIdentifier:@"ViewPreguntas" sender:self];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual:@"ViewPreguntas"]) {
        PreguntasViewController *escenadestino = segue.destinationViewController;
        
        //ACA SE PONE EL ID DEL TEMA QUE SALIO EN LA RULETA
        escenadestino.idtema = 1;
    }

};

@end
