//
//  slideBarViewController.h
//  darsapp
//
//  Created by inf227al on 14/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "InicioJuegoViewController.h"

@interface slideBarViewController : UIViewController <PrincipalDelegado>
{
    int ultimaTraslacion;
}
@property (strong, nonatomic) IBOutlet UIView *menuContainterView;
@property (strong, nonatomic) IBOutlet UIView *principalContainerView;

@end
