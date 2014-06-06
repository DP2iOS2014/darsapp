//
//  EventosViewController.h
//  darsapp
//
//  Created by inf227al on 4/06/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "ViewController.h"

@interface EventosViewController : ViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tablaeventos;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipoSegmentedControl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipoSegmentedControl2;

@end
