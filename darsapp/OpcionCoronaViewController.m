//
//  OpcionCoronaViewController.m
//  darsapp
//
//  Created by inf227al on 11-06-14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "OpcionCoronaViewController.h"
#import "PreguntasViewController.h"

@interface OpcionCoronaViewController ()

@end

@implementation OpcionCoronaViewController

{
    int numerotema;

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ApretoTema1:(id)sender {
    numerotema=1;
    [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:1];
}
- (IBAction)ApretoTema2:(id)sender {
    numerotema=2;
    [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:1];
}
- (IBAction)ApretoTema3:(id)sender {
    numerotema=3;
    [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:1];
}
- (IBAction)ApretoTema4:(id)sender {
    numerotema=4;
    [self performSelector:@selector(irASeleccionado) withObject:nil afterDelay:1];
}


-(void)irASeleccionado
{

    [self performSegueWithIdentifier:@"viewPreguntasSegundo" sender:self];
    
    
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqual:@"viewPreguntasSegundo"]) {
        PreguntasViewController *escenadestino = segue.destinationViewController;
        escenadestino.delegate = self;
        //ACA SE PONE EL ID DEL TEMA QUE SALIO EN LA RULETA
        escenadestino.idtema = numerotema;
    }
    
};

-(void)DesapareceModalCuandoTocoCorona{
    //[self dismissViewControllerAnimated:NO completion:nil];    
        [self.navigationController popViewControllerAnimated:NO];
    
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
