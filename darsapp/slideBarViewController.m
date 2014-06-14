//
//  slideBarViewController.m
//  darsapp
//
//  Created by inf227al on 14/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//



#import "slideBarViewController.h"

@interface slideBarViewController ()
@end

@implementation slideBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    ultimaTraslacion = 0;
}

- (IBAction)seEstaHaciendoPan:(UIPanGestureRecognizer *)sender {
    int traslacionX = [sender translationInView:self.view].x+ultimaTraslacion;
    CATransform3D miTransform = sender.view.layer.transform;
    
    miTransform = CATransform3DMakeTranslation(traslacionX, 0, 0);
    
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        if (ABS(traslacionX) > self.view.frame.size.width/2 ) {
            ultimaTraslacion = -1*self.menuContainterView.frame.size.width;
            
            
        }
        else
        {
            ultimaTraslacion = 0;
        }
        
        
        miTransform = CATransform3DMakeTranslation(ultimaTraslacion, 0, 0);
    }
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        sender.view.layer.transform = miTransform;
    } completion:nil];
}


-(void)principalApretoBotonDerecho
{
    if (ultimaTraslacion == 0) {
        
        ultimaTraslacion = -1*self.menuContainterView.frame.size.width;
        
    }
    else
    {
        ultimaTraslacion = 0;
    }
    
    CATransform3D miTransform = self.principalContainerView.layer.transform;
    miTransform = CATransform3DMakeTranslation(ultimaTraslacion, 0, 0);
    
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        self.principalContainerView.layer.transform = miTransform;
        
    } completion:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"principalSegue"]) {
        //UINavigationController *navDestino = segue.destinationViewController;
        //InicioJuegoViewController *destino = navDestino.viewControllers[0];
        
        InicioJuegoViewController *destino=segue.destinationViewController;
        destino.miDelegado = self;
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
