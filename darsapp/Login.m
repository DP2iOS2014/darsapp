//
//  Login.m
//  darsapp
//
//  Created by inf227al on 18-06-14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "Login.h"
#import "URLsJson.h"

@implementation Login

static Login *sharedMyManager;

+ (id)sharedManager{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedMyManager = [[Login alloc] init];
    
    
});
    
    return sharedMyManager;
}


+(void) jsonLoginConUsuarioPersistente:(NSString*)NombreUsuario yPassword:(NSString*)ContraseñaUsuario{
    Login *objetoLogin = [Login sharedManager];
    
    NSArray *keys = [NSArray arrayWithObjects:@"hacer", @"username",@"password", nil];
        NSArray *objects = [NSArray arrayWithObjects:@"login",NombreUsuario, ContraseñaUsuario, nil];
        NSDictionary *dictionaryUsuario = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys: dictionaryUsuario, @"cuerpo",@"Autenticacion", @"operacion", nil];
    NSLog(@"JSON: %@", consulta);
    

AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
manager.requestSerializer = [AFJSONRequestSerializer serializer];

[manager POST:login parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
    NSDictionary * respuesta = responseObject;
    NSLog(@"JSON: %@", respuesta);
    int netin = ((NSString*)[[respuesta objectForKey:@"cuerpo"] objectForKey:@"netin"]).intValue;
    int netalu = ((NSString*)[[respuesta objectForKey:@"cuerpo"] objectForKey:@"netalu"]).intValue;
    if ( netin == 1 || netalu == 1) {
        if(netin ==1){
            [[NSUserDefaults standardUserDefaults] setObject:@"S" forKey:@"netin"];
            [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:@"netalu"];
        }else if(netalu == 1){
            [[NSUserDefaults standardUserDefaults] setObject:@"S" forKey:@"netalu"];
            [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:@"netin"];
        }
        
        //[self performSegueWithIdentifier:@"exito_login" sender:self];
        [objetoLogin.delegate loginExito];
    }
    else {
        [objetoLogin.delegate loginFallo:@"Debe volver a iniciar sesión"];
        /*UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Debe volver a iniciar sesión" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [miAlert show];*/
    
        //self.cargando.alpha = 0 ;
    }
    
} failure:^(AFHTTPRequestOperation *task, NSError *error) {
    [objetoLogin.delegate falloServidor];
    /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No choco con el servidor"
                                                        message:[error localizedDescription]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil]; */
    //[alertView show];
    //self.cargando.alpha = 0 ;
}];
}

+(void) jsonLoginConUsuario:(NSString*)NombreUsuario yPassword:(NSString*)ContraseñaUsuario{
    Login *objetoLogin = [Login sharedManager];
    
    NSArray *keys = [NSArray arrayWithObjects:@"hacer", @"username",@"password", nil];
    // Arreglo de los objeto que se tendran dentro del diccionario
    NSArray *objects = [NSArray arrayWithObjects:@"login" ,NombreUsuario, ContraseñaUsuario, nil];
    //Primera forma de inicializar un diccionario pasandole un arreglo de indices y de objetos
    NSDictionary *dictionaryUsuario = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    
    //Segunda forma de inicializar un diccionario pasandole primero un indice y luego un objeto y asi consecutivamente
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys: dictionaryUsuario, @"cuerpo",@"Autenticacion", @"operacion", nil];
    
    //NSArray *keys = [NSArray arrayWithObjects:@"ApiToken", @"IdUsuarioLog", nil];
    //NSArray *objects = [NSArray arrayWithObjects:@"6aa83532910737795239f1d30cb9c0f6493c60bc" ,@106,  nil];
    //NSDictionary *consulta = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    //{"ApiToken":"6aa83532910737795239f1d30cb9c0f6493c60bc","IdUsuarioLog":106}
    NSLog(@"JSON: %@", consulta);
    
    //NSURL *URL = [NSURL URLWithString:login];
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:login parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        NSDictionary * respuesta;
        respuesta = responseObject;
        
        
        if (((NSString*)[[respuesta objectForKey:@"cuerpo"] objectForKey:@"netin"]).intValue == 1) {
            
            [[NSUserDefaults standardUserDefaults] setObject:NombreUsuario forKey:@"NombreUsuario"];
            [[NSUserDefaults standardUserDefaults] setObject:ContraseñaUsuario forKey:@"ContraseñaUsuario"];
            [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:@"Visitante"];
            
            int netin = ((NSString*)[[respuesta objectForKey:@"cuerpo"] objectForKey:@"netin"]).intValue;
            int netalu = ((NSString*)[[respuesta objectForKey:@"cuerpo"] objectForKey:@"netalu"]).intValue;
            if ( netin == 1 || netalu == 1) {
                if(netin ==1){
                    [[NSUserDefaults standardUserDefaults] setObject:@"S" forKey:@"netin"];
                    [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:@"netalu"];
                }else if(netalu == 1){
                    [[NSUserDefaults standardUserDefaults] setObject:@"S" forKey:@"netalu"];
                    [[NSUserDefaults standardUserDefaults] setObject:@"N" forKey:@"netin"];
                }
                [objetoLogin.delegate loginExito];
            }else{
                //Entra Dos veces
                [objetoLogin.delegate loginExito];
            
            }
            
        }else if([NombreUsuario isEqualToString:@""] && [ContraseñaUsuario isEqualToString:@""]){
            //Falta colocar usuario y contrasena
            [objetoLogin.delegate loginFallo:@"Debe ingresar Usuario y/o Contraseña"];
            /*UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Debe ingresar Usuario y/o Contraseña" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [miAlert show];
            self.cargando.alpha = 0 ;*/
            
        }else if([NombreUsuario isEqualToString:@""] && ![ContraseñaUsuario isEqualToString:@""]){
            //Falta colocar usuario
            [objetoLogin.delegate loginFallo:@"Debe ingresar Usuario"];
            /*UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Debe ingresar Usuario" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [miAlert show];
            self.cargando.alpha = 0 ;*/
            
        }else if(![NombreUsuario isEqualToString:@""] && [ContraseñaUsuario isEqualToString:@""]){
            //Falta colocar contrasenha
            [objetoLogin.delegate loginFallo:@"Debe ingresar Contraseña"];
            /*UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Debe ingresar Contraseña" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [miAlert show];
            self.cargando.alpha = 0 ;*/
        }
        else {
            [objetoLogin.delegate loginFallo:@"Usuario o contraseña incorrecta" ];
            /*UIAlertView * miAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Usuario o contraseña incorrecta" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [miAlert show];
            self.cargando.alpha = 0 ;*/
        }
        
    } failure:^(AFHTTPRequestOperation *task, NSError *error) {
        [objetoLogin.delegate falloServidor];
        /*UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No choco con el servidor"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        self.cargando.alpha = 0 ;*/
    }];
    
 
}


@end
