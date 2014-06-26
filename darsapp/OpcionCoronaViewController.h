//
//  OpcionCoronaViewController.h
//  darsapp
//
//  Created by inf227al on 11-06-14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "ViewController.h"
#import "PreguntasViewController.h"
@protocol coronaDelagate <NSObject>
@optional
-(void)regresaRaiz;
@end

@interface OpcionCoronaViewController : ViewController <preguntasDelegate>
@property (nonatomic, weak) id <coronaDelagate> delegate;
@end
