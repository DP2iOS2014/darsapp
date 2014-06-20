//
//  Tacho.h
//  darsapp
//
//  Created by inf227al on 20/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tacho : NSManagedObject

@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSDate * fecha;
@property (nonatomic, retain) NSNumber * ln;
@property (nonatomic, retain) NSNumber * lt;
@property (nonatomic, retain) NSNumber * nid;
@property (nonatomic, retain) NSString * tipo;

@end
