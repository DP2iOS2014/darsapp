//
//  BuenaPractica.h
//  darsapp
//
//  Created by inf227al on 14/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Persona;

@interface BuenaPractica : NSManagedObject

@property (nonatomic, retain) NSNumber * estado;
@property (nonatomic, retain) NSNumber * codigoTema;
@property (nonatomic, retain) NSNumber * codigoPractica;
@property (nonatomic, retain) NSSet *personas;
@end

@interface BuenaPractica (CoreDataGeneratedAccessors)

- (void)addPersonasObject:(Persona *)value;
- (void)removePersonasObject:(Persona *)value;
- (void)addPersonas:(NSSet *)values;
- (void)removePersonas:(NSSet *)values;

@end
