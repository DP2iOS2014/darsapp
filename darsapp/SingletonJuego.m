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
        sharedMyManager.disponibilidadRespuesta1 = YES;
        sharedMyManager.disponibilidadRespuesta2 = YES;
        sharedMyManager.disponibilidadRespuesta3 = YES;
        sharedMyManager.disponibilidadRespuesta4 = YES;
        sharedMyManager.apretoCorona=NO;
        
        
    });
    
    return sharedMyManager;
}

+(void) ResetearValores{
    SingletonJuego * temporal = [self sharedManager];
    temporal.Tiempo = 30;
    temporal.VidasReloj = 3;
    temporal.VidasBomba = 3;
    temporal.VidasNPregunta=3;
    temporal.VidasOtraOpcion = 3;
    temporal.tieneOtraOpcion = NO;
    temporal.disponibilidadBoton=YES;
    temporal.disponibilidadRespuesta1 = YES;
    temporal.disponibilidadRespuesta2 = YES;
    temporal.disponibilidadRespuesta3 = YES;
    temporal.disponibilidadRespuesta4 = YES;
    temporal.apretoCorona=NO;
    

    
    
}

@end
