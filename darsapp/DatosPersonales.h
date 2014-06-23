//
//  DatosPersonales.h
//  darsapp
//
//  Created by inf227al on 23/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DatosPersonales : NSManagedObject

@property (nonatomic, retain) NSNumber * latitud;
@property (nonatomic, retain) NSString * direccion;
@property (nonatomic, retain) NSNumber * longitud;
@property (nonatomic, retain) NSNumber * nid;
@property (nonatomic, retain) NSString * titulo;
@property (nonatomic, retain) NSNumber * vid;

@end
