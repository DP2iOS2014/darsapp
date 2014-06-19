//
//  puntajeAdministradorViewController.m
//  darsapp
//
//  Created by inf227al on 23/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "puntajeAdministradorViewController.h"
#import "SingletonAmbientalizate.h"
#import "URLsJson.h"

@interface puntajeAdministradorViewController ()

@end

@implementation puntajeAdministradorViewController{
    SingletonAmbientalizate *Ambientalizate;
    NSMutableArray *NidsArregloJson;
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
    
    Ambientalizate= [SingletonAmbientalizate sharedManager:(NSInteger)self.cantidadFilas];
    
    NidsArregloJson = [ [NSMutableArray alloc] init];
    
    for (int i=0; i< self.cantidadFilas; i++){
        for (int j=0; j<[[Ambientalizate.ArregloEstados objectAtIndex:i] count]; j++){
            if ( ((NSNumber*)Ambientalizate.ArregloEstados[i][j]).intValue == 1 ){
                [NidsArregloJson addObject:Ambientalizate.ArregloNids[i][j]];
            }
        }
    }
    
    
    
     [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]]];
    // Do any additional setup after loading the view.
    //[self enviaPuntaje];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}



-(void) enviaPuntaje{

    NSDictionary *listanodos = [[NSDictionary alloc] init];
    NSMutableArray *cuerpo2;
    
    for(int i=0;i<NidsArregloJson.count;i++){
        listanodos = [ listanodos initWithObjectsAndKeys:@"100","puntaje",NidsArregloJson[i],@"nid",nil];
        [cuerpo2 addObject:listanodos];
    
    }

    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"config", @"username", cuerpo2, @"listaNodos", nil];
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Accion",@"operacion",@"registro_votosxusuario",@"desc",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@", consulta);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:RecuperoTemas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        //respuestatemas = responseObject;
        //NSLog(@"JSON: %@", respuestatemas);
        
        //NSDictionary * diccionarioPosiciones = [respuestatemas objectForKey:@"cuerpo"];
        //NSArray * arregloPosiciones = [diccionarioPosiciones objectForKey:@"listaNodos"];
        
        //PARA SACAR LOS DATOS
        

        
        //[self.tableView reloadData];
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


- (void) viewWillAppear:(BOOL)animated{
    
    NSUserDefaults * datosDeUsuario = [NSUserDefaults standardUserDefaults];
    
    double puntajeActual = [datosDeUsuario doubleForKey:@"puntajeAcumulado"];
    
    self.puntajeLabel.text = [NSString stringWithFormat:@"%0.2f",puntajeActual];
    
    //PARA MOSTRAR IMAGEN Y TEXTO RESULTADO
    
    if(puntajeActual>=0 && puntajeActual<30){
        self.textoResultado.text=@"Practicante Ambiental";
        self.imagenResultado.image = [UIImage imageNamed:@"PracticanteAmbiental.png"];
    };
    if(puntajeActual>=30 && puntajeActual<70){
        self.textoResultado.text=@"Asistente Ambiental";
        self.imagenResultado.image = [UIImage imageNamed:@"AsistenteAmbiental.png"];
    };
    if(puntajeActual>=70 && puntajeActual<120){
        self.textoResultado.text=@"Especialista Ambiental";
        self.imagenResultado.image = [UIImage imageNamed:@"EspecialistaAmbiental.png"];
    };
    if(puntajeActual>=120 && puntajeActual<200){
        self.textoResultado.text=@"Senior Ambiental";
        self.imagenResultado.image = [UIImage imageNamed:@"SeniorAmbiental.png"];
    };
    if(puntajeActual>=200){
        self.textoResultado.text=@"Lider Ambiental";
        self.imagenResultado.image = [UIImage imageNamed:@"LiderAmbiental.png"];
    };
    
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
