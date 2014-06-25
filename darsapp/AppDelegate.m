//
//  AppDelegate.m
//  darsapp
//
//  Created by inf227al on 16/04/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//


#import "AppDelegate.h"
#import "BuenaPractica.h"
#import "Persona.h"
#import "DatosPersonales.h"
#import "URLsJson.h"
#import "Tacho.h"



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    // Override point for customization after application launch.
   
    [GMSServices provideAPIKey:@"AIzaSyD4Yv_7isiHiXOUc7s4821tCi6tpRILy4s"];
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:85.0/255 green:201.0/255 blue:210.0/255 alpha:1]];
    
    UIImage *backOriginal =[UIImage imageNamed:@"backButton2"];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[backOriginal imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    NSArray * tacho = [Tacho all];
    
    NSArray* dp=[DatosPersonales all];
    
    if(tacho.count != 0)
        
        [self actualizarTachos];
    
    else [self llenaTachos];
    
    if(dp.count ==0 )
        
        [self llenaDp];
    
    //[[IBCoreDataStore mainStore] save];
    
    // Initialize Mixpanel with your project token
    [Mixpanel sharedInstanceWithToken:@"ed4c70d57f14a66161e30f1be2ca0302"];
    
    // Tell iOS you want  your app to receive push
    // notifications
    [[UIApplication sharedApplication]
     registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge |
      UIRemoteNotificationTypeSound |
      UIRemoteNotificationTypeAlert)];
    
    return YES;
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    Mixpanel *mixpanel = [Mixpanel sharedInstance];
    [mixpanel.people addPushDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // Show alert for push notifications recevied while the
    // app is running
    NSString *message = [[userInfo objectForKey:@"aps"]
                         objectForKey:@"alert"];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@""
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
//    [alert release];
}


-(void) llenaDp{
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"ubicacion_dars",@"tipo", nil];
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    NSLog(@"%@", consulta);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:RecuperoTemas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        
        NSDictionary * respuestajson = responseObject;
        
        NSLog(@"JSON: %@", respuestajson);
        
        NSDictionary * cuerpo = [respuestajson objectForKey:@"cuerpo"];
        
        NSArray * listaNodos = [cuerpo objectForKey:@"listaNodos"];
        
        NSString *descripcion = [[listaNodos objectAtIndex:0] objectForKey:@"descripcion"];
        
        NSString *lat = [[listaNodos objectAtIndex:0] objectForKey:@"latitud"];
        
        NSString *lon = [[listaNodos objectAtIndex:0] objectForKey:@"longitud"];
        
        double lt=[lat doubleValue];
        
        double ln=[lon doubleValue];
        
        NSString *nid = [[listaNodos objectAtIndex:0] objectForKey:@"nid"];
        
        NSString *ti = [[listaNodos objectAtIndex:0] objectForKey:@"titulo"];
        
        NSString *vid = [[listaNodos objectAtIndex:0] objectForKey:@"vid"];
        
        DatosPersonales * dp = [DatosPersonales create];
        
        dp.direccion= descripcion;
        
        dp.latitud= [[NSNumber alloc] initWithDouble: lt];
        
        dp.longitud = [[NSNumber alloc] initWithDouble: ln];
        
        dp.nid=[[NSNumber alloc] initWithInt: nid.intValue];
        
        dp.titulo=ti;
        
        dp.vid=[[NSNumber alloc] initWithInt: vid.intValue];
        
        [[IBCoreDataStore mainStore] save];
        
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

-(void)llenaTachos{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:1990];
    
    [components setMonth:9];
    
    [components setDay:28];
    
    NSDate *fecha = [calendar dateFromComponents:components];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *dateString = [format stringFromDate:fecha];
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"contenedor",@"tipo", @"incremental",@"forma",dateString ,@"fecha", nil];
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    
    
    NSLog(@"%@", consulta);
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    
    [manager POST:RecuperoTemas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        
        NSDictionary * respuestajson = responseObject;
        
        NSLog(@"JSON: %@", respuestajson);
        
        
        
        NSDictionary * cuerpo = [respuestajson objectForKey:@"cuerpo"];
        
        NSArray * listaNodos = [cuerpo objectForKey:@"listaNodos"];
        
        
        
        for(int i = 0; i < listaNodos.count; i++){
            
            
            
            NSString *lat = [[listaNodos objectAtIndex:i] objectForKey:@"latitud"];
            
            NSString *lon = [[listaNodos objectAtIndex:i] objectForKey:@"longitud"];
            
            NSString *tipo = [[listaNodos objectAtIndex:i] objectForKey:@"tipo_tacho"];
            
            double lt=[lat doubleValue];
            
            double ln=[lon doubleValue];
            
            NSString *name = [[listaNodos objectAtIndex:i] objectForKey:@"title"];
            
            NSString *fecha = [[listaNodos objectAtIndex:i] objectForKey:@"fecha_modificacion"];
            
            NSString *nid = [[listaNodos objectAtIndex:i] objectForKey:@"nid"];
            
            
            
            Tacho * tacho = [Tacho create];
            
            
            
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            
            [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSDate * dateNotFormatted = [format dateFromString:fecha];
            
            
            
            tacho.descripcion = name;
            
            tacho.fecha = dateNotFormatted;
            
            
            
            
            
            tacho.lt = [[NSNumber alloc] initWithDouble: lt];
            
            tacho.ln = [[NSNumber alloc] initWithDouble: ln];
            
            tacho.tipo = tipo;
            
            tacho.nid= [[NSNumber alloc] initWithInt: nid.intValue];
            
            
            
            //Agregar los tachos a coredata
            
            
            
        }
        
        NSDate *now = [NSDate date];
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        
        
        NSString *dateString = [format stringFromDate:now];
        
        
        
        [[NSUserDefaults standardUserDefaults] setObject:dateString forKey:@"ultActualizacionTachos"];
        
        [[IBCoreDataStore mainStore] save];
        
        
        
        
        
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





-(void) actualizarTachos{
    
    NSDate *now = [NSDate date];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    NSString *dateString = [format stringFromDate:now];
    
    NSDictionary *cuerpo = [NSDictionary dictionaryWithObjectsAndKeys:@"contenedor",@"tipo", @"nid",@"forma",dateString ,@"fecha", nil];
    
    
    
    NSDictionary * consulta = [NSDictionary dictionaryWithObjectsAndKeys:@"Consulta",@"operacion",cuerpo,@"cuerpo" , nil];
    
    
    
    NSLog(@"%@", consulta);
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    
    [manager POST:RecuperoTemas parameters:consulta success:^(AFHTTPRequestOperation *task, id responseObject) {
        
        NSDictionary * respuestajson = responseObject;
        
        NSLog(@"JSON: %@", respuestajson);
        
        
        
        NSDictionary * cuerpo = [respuestajson objectForKey:@"cuerpo"];
        
        NSArray * listaNodos = [cuerpo objectForKey:@"listaNodos"];
        
        
        
        NSArray * tachos = [Tacho all];
        
        BOOL esta;
        
        for(int i = 0; i < tachos.count; i++){
            
            esta = NO;
            
            
            
            //Compara los nids que ya se tienen con los pedidos para borrar los que sobran
            
            for(int j=0;j<listaNodos.count;j++){
                
                NSNumber * nid = [[listaNodos objectAtIndex:j]objectForKey:@"nid"];
                
                if( ((Tacho*)tachos[i]).nid.intValue == nid.intValue){
                    
                    esta = YES;
                    
                }
                
            }
            
            if(!esta) [tachos[i] destroy];
            
            
            
        }
        
        [[IBCoreDataStore mainStore] save];
        
        
        
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



/*
 
 -(void)cargarBuenasPracticas
 
 {
 
 
 
 NSArray *todas = [BuenaPractica allOrderedBy:@"codigoPractica" ascending:YES];
 
 
 
 BuenaPractica *unica = [BuenaPractica all][0];
 
 unica.codigoTema = nil;
 
 
 
 Persona *nuevaPersona = [Persona create];
 
 nuevaPersona.nombre = @"Israelito";
 
 
 
 //1
 
 [nuevaPersona addBuenasPracticasObject:unica];
 
 //2
 
 [unica addPersonasObject:nuevaPersona];
 
 
 
 
 
 NSSortDescriptor *miDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"codigoPractica" ascending:YES];
 
 
 
 
 
 [nuevaPersona.buenasPracticas allObjects];
 
 [nuevaPersona.buenasPracticas sortedArrayUsingDescriptors:@[miDescriptor]];
 
 
 
 
 
 
 
 unica = nil;
 
 [unica destroy];
 
 [BuenaPractica destroyAll];
 
 
 
 
 
 [BuenaPractica allForPredicate:[NSPredicate predicateWithFormat:@"c.codigoPractica == 12"]];
 
 
 
 
 
 
 
 
 
 
 
 [[IBCoreDataStore mainStore] save];
 
 }
 
 
 
 */


- (void)applicationWillResignActive:(UIApplication *)application

{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}



- (void)applicationDidEnterBackground:(UIApplication *)application

{
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
}



- (void)applicationWillEnterForeground:(UIApplication *)application

{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
}



- (void)applicationDidBecomeActive:(UIApplication *)application

{
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}



- (void)applicationWillTerminate:(UIApplication *)application

{
    
    
    
}



@end

