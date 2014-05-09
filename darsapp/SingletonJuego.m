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

    static SingletonJuego *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
            sharedMyManager.VidasReloj = 3;
            sharedMyManager.Tiempo = 20;
            sharedMyManager.VidasBomba = 3;
            sharedMyManager.VidasOtraOpcion = 3;
            sharedMyManager.tieneOtraOpcion = NO;
            sharedMyManager.disponibilidadBoton=YES;
    }
    
    
    return sharedMyManager;
}

@end
