//
//  SingletonJuego.m
//  darsapp
//
//  Created by inf227al on 8/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "SingletonJuego.h"

@implementation SingletonJuego

+ (id)sharedManager{

    static dispatch_once_t once;
    static SingletonJuego *sharedMyManager;
    dispatch_once(&once, ^{
        
        
        sharedMyManager = [[self alloc] init];
        sharedMyManager.Tiempo = 30;
        sharedMyManager.VidasReloj = 3;
        sharedMyManager.VidasBomba = 3;
        sharedMyManager.VidasNPregunta=3;
        sharedMyManager.VidasOtraOpcion = 3;
        sharedMyManager.tieneOtraOpcion = NO;
        sharedMyManager.disponibilidadBoton=YES;
        
        
    });
    
    return sharedMyManager;
}


@end
