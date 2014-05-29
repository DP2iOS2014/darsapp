//
//  SingletonAmbientalizate.m
//  darsapp
//
//  Created by inf227al on 23/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "SingletonAmbientalizate.h"

@implementation SingletonAmbientalizate

static SingletonAmbientalizate *sharedMyManager;

+ (id)sharedManager:(NSInteger)cantidadFilas{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedMyManager = [[self alloc] init];
        sharedMyManager.ArregloEstados = [[NSMutableArray alloc] init];
        
        
        for(int i=0;i<cantidadFilas;i++){
            
            [sharedMyManager.ArregloEstados addObject:[[NSMutableArray alloc] init]];
            
        }
    });
    
    return sharedMyManager;
}

+ (void) setEstado:(NSMutableArray*)arregloEstado yIndice:(NSInteger)indiceArreglo{
    
    [sharedMyManager.ArregloEstados setObject:arregloEstado atIndexedSubscript:indiceArreglo];

}


+ (NSMutableArray*) getEstado: (NSInteger)IndiceArreglo{
    return [sharedMyManager.ArregloEstados objectAtIndex:IndiceArreglo];

}


@end
