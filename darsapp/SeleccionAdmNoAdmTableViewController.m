//
//  SeleccionAdmNoAdmTableViewController.m
//  darsapp
//
//  Created by inf227al on 30/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "SeleccionAdmNoAdmTableViewController.h"
#import "SeleccionAdmNoAdmTableViewCell.h"
@interface SeleccionAdmNoAdmTableViewController ()

@end

@implementation SeleccionAdmNoAdmTableViewController
{
    NSString * esAlumno;
    NSString * esAdm;
    NSString * esVisitante;
    NSArray * arregloImagenes;
    NSArray * arregloTexto;
}
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
    
    NSUserDefaults * datosDeMemoria = [NSUserDefaults standardUserDefaults];
    esAlumno = [datosDeMemoria stringForKey:@"netalu"];
    esAdm = [datosDeMemoria stringForKey:@"netin"];
    esVisitante= [datosDeMemoria stringForKey:@"Visitante"];
    arregloImagenes = [[NSArray alloc] initWithObjects:@"administrativo.png",@"no_administrativo.png", nil];
    arregloTexto = [[NSArray alloc] initWithObjects:@"Administrativo",@"No Administrativo", nil];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if([esAlumno isEqualToString:@"S"] || [esVisitante isEqualToString:@"S"]){
        return 1;
    }else if ([esAdm isEqualToString:@"S"]){
        return 2;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SeleccionAdmNoAdmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"celda" forIndexPath:indexPath];
    
    // Configure the cell...
    if([esAdm isEqualToString:@"S"]){
        cell.imagen.image = [UIImage imageNamed:arregloImagenes[indexPath.row]];
        cell.texto.text = arregloTexto[indexPath.row];
    }else if([esAlumno isEqualToString:@"S"] || [esVisitante isEqualToString:@"S"]){
        cell.imagen.image = [UIImage imageNamed:arregloImagenes[1]];
        cell.texto.text = arregloTexto[1];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([esAlumno isEqualToString:@"S"] || [esVisitante isEqualToString:@"S"]){
        [self performSegueWithIdentifier:@"noAdm" sender:self];
    }else if([esAdm isEqualToString:@"S"]){
        if(indexPath.row == 0){
            [self performSegueWithIdentifier:@"adm" sender:self];
        }else if(indexPath.row == 1){
            [self performSegueWithIdentifier:@"noAdm" sender:self];
        }
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
