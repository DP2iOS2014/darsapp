//
//  ClasePregunta.h
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClasePregunta : NSObject

@property (nonatomic, strong) NSArray *ArregloRespuestas;
@property (nonatomic, strong) NSString *PreguntaARealizar;
@property (nonatomic, strong) NSNumber* PuntajePregunta;
@property (nonatomic, strong) NSNumber* RespuestaCorrecta;

-(ClasePregunta*)initConPregunta:(NSString*)pregunta Respuestas:(NSArray*)respuestas Puntaje:(NSNumber*)ptj RespCorrecta: (NSNumber*)resp;

@end
