//
//  ContactanosTableViewController.m
//  darsapp
//
//  Created by inf227al on 16/04/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "ContactanosTableViewController.h"
#import <MessageUI/MessageUI.h>

@interface ContactanosTableViewController ()

@end

@implementation ContactanosTableViewController

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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString * miURLString;
    
    if(indexPath.section == 0){
        if(indexPath.row==0){
            //fb
            if([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"fb://"]]){
                miURLString = @"fb://profile/106346966142394";
            }else{
                miURLString = @"https://www.facebook.com/pucpdars";
            }
        }else{
            //twitter
            if([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"twitter://"]]){
                miURLString = @"twitter://user?screen_name=dars_pucp";
            }else{
                miURLString = @"https://twitter.com/user/dars_pucp";
            }
        }
    }else{
        //llamo
        
        if(indexPath.section==1){
            if(indexPath.row==0){
            //ubicanos
            }
            else if (indexPath.row==1){
                NSUserDefaults * datosDeMemoria = [NSUserDefaults standardUserDefaults];
                NSString * visitante = [datosDeMemoria stringForKey:@"Visitante"];
                if ([visitante isEqualToString:@"S"]) {
                    UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No puede realizar llamadas como visitante" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [miAlert show];
                }else{
            //telefono
                
                if([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"tel://991370292"]]){
                    miURLString = @"tel://991370292";
                }else{
                    miURLString = @"";
                    UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No se puede llamar" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [miAlert show];
                }
                    
                }
            } else{
                
                //correo
                
                MFMailComposeViewController *miComposer = [[MFMailComposeViewController alloc] init];
                miComposer.mailComposeDelegate = self;
                
                //Aqui le metemos el destinatario y el cuerpo
                [miComposer setSubject:@"Mensaje a la DARS"];
                [miComposer setMessageBody:@"Escribe aqui tu sugerencia - Prueba 1" isHTML:NO];
                [miComposer setToRecipients:@[@"dars@pucp.edu.pe"]];
                //
                
                [self presentViewController:miComposer animated:YES completion:nil];
            }
        }
        
        
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:miURLString]];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex != alertView.cancelButtonIndex){
        
    }
}


// Para el boton compartir


- (IBAction)seApretoCompartir:(UIBarButtonItem *)sender {
    
    UIActivityViewController *miActivity = [[UIActivityViewController alloc] initWithActivityItems:@[@"Descargate esta aplicación de la DARS en la siguente web: http://200.16.7.111/dp2/rc/"] applicationActivities:nil];
    
    miActivity.excludedActivityTypes = @[UIActivityTypeMail];
    
    [self presentViewController:miActivity animated:YES completion:nil];}




@end
