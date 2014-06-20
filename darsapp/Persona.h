//
//  Persona.h
//  darsapp
//
//  Created by inf227al on 20-06-14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BuenaPractica;

@interface Persona : NSManagedObject

@property (nonatomic, retain) NSNumber * edad;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSNumber * sexo;
@property (nonatomic, retain) NSSet *buenasPracticas;
@end

@interface Persona (CoreDataGeneratedAccessors)

- (void)addBuenasPracticasObject:(BuenaPractica *)value;
- (void)removeBuenasPracticasObject:(BuenaPractica *)value;
- (void)addBuenasPracticas:(NSSet *)values;
- (void)removeBuenasPracticas:(NSSet *)values;

@end
