//
//  GrillaInicialAmbientalizate.m
//  darsapp
//
//  Created by inf227al on 23/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "GrillaInicialAmbientalizate.h"

@interface GrillaInicialAmbientalizate ()

@end

@implementation GrillaInicialAmbientalizate

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.parentViewController.view.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cerrarSesion:(id)sender {
    
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Cerrar Sesión"
                                                        message:@"Está seguro que desea cerrar sesión?"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Si",nil];
    [alertView show];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==1){
        
        UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"Main_iPhone"
                                                      bundle:nil];
        UIViewController* vc = [sb instantiateViewControllerWithIdentifier:@"login"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"netin"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"netalu"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"Visitante"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"NombreUsuario"];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ContraseñaUsuario"];
        
        [self presentViewController:vc animated:YES completion:nil];
        
    }
    
}

@end
