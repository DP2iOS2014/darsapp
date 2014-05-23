//
//  ResultadoCalificateViewController.m
//  darsapp
//
//  Created by inf227al on 10/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "ResultadoCalificateViewController.h"

@interface ResultadoCalificateViewController ()

@end

@implementation ResultadoCalificateViewController

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
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)RegresarPrincipal:(id)sender {
    
}

-(void) viewWillAppear:(BOOL)animated{
    
    self.lblPuntaje.text = [NSString stringWithFormat:@"%0.2f", self.puntaje];
    
    if(self.puntaje>=0 && self.puntaje<30){
        self.textoResultado.text=@"Practicante Ambiental";
        self.imagenResultado.image = [UIImage imageNamed:@"PracticanteAmbiental.png"];
    };
    if(self.puntaje>=30 && self.puntaje<70){
        self.textoResultado.text=@"Asistente Ambiental";
        self.imagenResultado.image = [UIImage imageNamed:@"AsistenteAmbiental.png"];
    };
    if(self.puntaje>=70 && self.puntaje<120){
        self.textoResultado.text=@"Especialista Ambiental";
        self.imagenResultado.image = [UIImage imageNamed:@"EspecialistaAmbiental.png"];
    };
    if(self.puntaje>=120 && self.puntaje<200){
        self.textoResultado.text=@"Senior Ambiental";
        self.imagenResultado.image = [UIImage imageNamed:@"SeniorAmbiental.png"];
    };
    if(self.puntaje>=200){
        self.textoResultado.text=@"Lider Ambiental";
        self.imagenResultado.image = [UIImage imageNamed:@"LiderAmbiental.png"];
    };
    
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
