//
//  puntajeAdministradorViewController.m
//  darsapp
//
//  Created by inf227al on 23/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "puntajeAdministradorViewController.h"

@interface puntajeAdministradorViewController ()

@end

@implementation puntajeAdministradorViewController

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
     [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"congruent_pentagon.png"]]];
    // Do any additional setup after loading the view.
}
- (void) viewWillAppear:(BOOL)animated{
    
    NSUserDefaults * datosDeUsuario = [NSUserDefaults standardUserDefaults];
    
    double puntajeActual = [datosDeUsuario doubleForKey:@"puntajeAcumulado"];
    
    self.puntajeLabel.text = [NSString stringWithFormat:@"%0.2f",puntajeActual];
    
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

@end
