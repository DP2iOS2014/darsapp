//
//  ClasePregunta.m
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "ClasePregunta.h"
#import "ClaseRespuesta.h"

@implementation ClasePregunta

-(ClasePregunta *)initConPregunta:(NSString *)pregunta Respuestas:(NSArray *)respuestas
{
    self = [super init];
    if (self) {
        self.PreguntaARealizar=pregunta;
        self.ArregloRespuestas=respuestas;
    }
    
    return self;


}

- (BOOL)EsPreguntaCorrecta:(NSInteger)opcion{
    return [[self.ArregloRespuestas objectAtIndex:opcion] correcta];
}


@end

