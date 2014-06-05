//
//  TableViewControllerGrillaEventosInicial.m
//  darsapp
//
//  Created by inf227al on 4/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "TableViewControllerGrillaEventosInicial.h"
#import "URLsJson.h"
#import "CeldaTemas.h"
#import "UIImageView+AFNetworking.h"
@interface TableViewControllerGrillaEventosInicial ()

@end

@implementation TableViewControllerGrillaEventosInicial{
    
    
    NSDictionary * respuestajson;
    NSMutableArray * titulos;
    NSMutableArray * urlImagenes;
    
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
    titulos = [[NSMutableArray alloc]init];
    urlImagenes =[[NSMutableArray alloc]init];
    [self recuperoEventos];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void) recuperoEventos{
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"evento",@"tipo", nil];
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@", consulta);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:RecuperoTemas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
      respuestajson = responseObject;
        NSLog(@"JSON: %@", respuestajson);
        
        NSDictionary * cuerpo = [respuestajson objectForKey:@"cuerpo"];
        NSArray * eventos = [cuerpo objectForKey:@"listaNodos"];
        
        for(int i = 0; i < eventos.count; i++){
            
            NSString * tituloEvento = [[eventos objectAtIndex:i]objectForKey:@"field_nombre_evento_value"];
            
            NSString *postFijo = [[eventos objectAtIndex:i] objectForKey:@"url_archivo"];
            
            NSString *urlImagen = [NSString stringWithFormat:@"%@%@",@"http://200.16.7.111/dp2/rc/",[postFijo stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            [titulos addObject:tituloEvento];
            [urlImagenes addObject:urlImagen];
            
        }
        
        [self.tableView reloadData];

            
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return titulos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier: @"celdaeventos"];
    ((CeldaTemas*)cell).lblTema.text=titulos[indexPath.row];
    
    
    
    [((CeldaTemas*)cell).imagen setImageWithURL:[NSURL URLWithString:urlImagenes[indexPath.row]] placeholderImage:[UIImage imageNamed:@"congruent_pentagon"]];
    
    
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
