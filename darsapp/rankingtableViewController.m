//
//  RankingTableViewController.m
//  darsapp
//
//  Created by inf227al on 20/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "RankingTableViewController.h"
#import "URLsJson.h"
#import "RankingTableViewCell.h"
@interface RankingTableViewController ()

@end

@implementation RankingTableViewController
{
    NSMutableArray *puntajes;
    NSMutableArray *nombres;
    NSDictionary * respuesta;

}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return @"Ranking";
    }
    return @"";
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
    
    [self recuperaRanking];
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) recuperaRanking{
    
    //PARA ENVIAR PRIMI
    
    nombres = [[NSMutableArray alloc] init];
    puntajes = [[NSMutableArray alloc]init];

    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"puntaje_juego", @"tipo", @"10", @"usuario", nil];
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@", consulta);
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:Buenaspracticas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        respuesta = responseObject;
        NSLog(@"JSON: %@", respuesta);
        
        NSDictionary * diccionarioPosiciones = [respuesta objectForKey:@"cuerpo"];
        NSArray * arregloPosiciones = [diccionarioPosiciones objectForKey:@"listaNodos"];
        
        //PARA SACAR LOS DATOS
        
        @try {
            for(int i=0; i<[arregloPosiciones count];i++){
                NSString *nombre = [[arregloPosiciones objectAtIndex:i] objectForKey:@"usuario"];
                NSString *puntaje = [[arregloPosiciones objectAtIndex:i] objectForKey:@"puntaje"];

                
                [nombres addObject:nombre];
                [puntajes   addObject:puntaje];
  
                
            }
             [self.tableView reloadData];
           
        }
        @catch (NSException *exception) {
            NSLog( @"NSException caught" );
            NSLog( @"Name: %@", exception.name);
            NSLog( @"Reason: %@", exception.reason );
            return;
        }
        @finally {
            NSLog( @"In finally block");
        }
        
        
    }
          failure:^(AFHTTPRequestOperation *task, NSError *error) {
              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No choco con el servidor"
                                                                  message:[error localizedDescription]
                                                                 delegate:nil
                                                        cancelButtonTitle:@"Ok"
                                                        otherButtonTitles:nil];
              [alertView show];
          }];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return puntajes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Celda" forIndexPath:indexPath];
    
    cell.nombreUsuario.text=[nombres objectAtIndex:indexPath.row];
    cell.puntajeUsuario.text=[puntajes objectAtIndex:indexPath.row];
    
    return cell;
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
