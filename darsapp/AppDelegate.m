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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:@"AIzaSyD4Yv_7isiHiXOUc7s4821tCi6tpRILy4s"];
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:85.0/255 green:201.0/255 blue:210.0/255 alpha:1]];
    
    UIImage *backOriginal =[UIImage imageNamed:@"backButton2"];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[backOriginal imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];

    
    BuenaPractica * buenaPractica = [BuenaPractica create];
    buenaPractica.codigoPractica = @12;
    
    [[IBCoreDataStore mainStore] save];
    
    
    return YES;
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
