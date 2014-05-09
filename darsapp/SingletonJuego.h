//
//  SingletonJuego.h
//  darsapp
//
//  Created by inf227al on 8/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonJuego : NSObject

@property NSInteger VidasReloj;
@property NSInteger Tiempo;
@property NSInteger VidasBomba;
@property NSInteger VidasOtraOpcion;
@property BOOL tieneOtraOpcion;
@property BOOL disponibilidadBoton;
+ (id)sharedManager;
@end
