//
//  SingletonEcoTips.m
//  darsapp
//
//  Created by inf227al on 23/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "SingletonEcoTips.h"

@implementation SingletonEcoTips
static SingletonEcoTips *sharedMyManager;

+ (id)sharedManager{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedMyManager = [[self alloc] init];
        sharedMyManager.ArregloEstados = [[NSMutableArray alloc] init];
    });
    
    return sharedMyManager;
}

+ (void) setEstado:(NSMutableArray*)arregloEstado{
    sharedMyManager.ArregloEstados=arregloEstado;
    
}


+ (NSMutableArray*) getEstado{
    return sharedMyManager.ArregloEstados;
    
}
@end
