//
//  ClaseRespuesta.h
//  darsapp
//
//  Created by inf227al on 6/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClaseRespuesta : NSObject
@property (nonatomic, strong) NSString *respuesta;
@property BOOL correcta;
-(ClaseRespuesta*)initConRespuesta:(NSString*)respuesta escorrecto:(BOOL)correcto;
@end
