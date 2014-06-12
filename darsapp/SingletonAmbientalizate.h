//
//  SingletonAmbientalizate.h
//  darsapp
//
//  Created by inf227al on 23/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonAmbientalizate : NSObject
@property (nonatomic,strong) NSMutableArray * ArregloEstados;
@property(nonatomic,strong) NSMutableArray * ArregloNids;
+ (id)sharedManager:(NSInteger) cantidadFilas;
+ (void) setEstado:(NSMutableArray*)arregloEstado yIndice:(NSInteger) indiceArreglo;
+ (NSMutableArray*) getEstado: (NSInteger) IndiceArreglo;

@end





