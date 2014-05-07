//
//  ClaseRespuesta.m
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "ClaseRespuesta.h"

@implementation ClaseRespuesta

-(ClaseRespuesta*)initConRespuesta:(NSString *)respuesta escorrecto:(BOOL)correcto {
    
    self = [super init];
    if (self) {
        self.respuesta=respuesta;
        self.correcta=correcto;
    }
    
    return self;
    
}


@end
