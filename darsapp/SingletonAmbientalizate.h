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
+ (id)sharedManager;
+ (void) setEstado:(NSMutableArray*)arregloEstado;
+ (NSMutableArray*) getEstado;

@end





