//
//  DarsLocalizacionAnnotation.h
//  darsapp
//
//  Created by inf227al on 30/04/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface DarsLocalizacionAnnotation : NSObject

- (id)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate;
- (MKMapItem*)mapItem;

@end
