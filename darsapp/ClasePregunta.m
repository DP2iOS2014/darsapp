//
//  ClasePregunta.m
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "ClasePregunta.h"


@implementation ClasePregunta

-(ClasePregunta *)initConPregunta:(NSString *)pregunta Respuestas:(NSArray *)respuestas Puntaje:(NSNumber*) ptj RespCorrecta: (NSNumber*)resp
{
    self = [super init];
    if (self) {
        self.PreguntaARealizar=pregunta;
        self.ArregloRespuestas=respuestas;
        self.PuntajePregunta=ptj;
        self.RespuestaCorrecta=resp;
    }
    
    return self;


}


@end

