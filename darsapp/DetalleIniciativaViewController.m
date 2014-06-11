//
//  DetalleIniciativaViewController.m
//  darsapp
//
//  Created by inf227al on 11-06-14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "DetalleIniciativaViewController.h"

@interface DetalleIniciativaViewController ()

@end

@implementation DetalleIniciativaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.starRating.backgroundColor  = [UIColor clearColor];
    self.starRating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.starRating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.starRating.maxRating = 5.0;
    self.starRating.delegate = self;
    self.starRating.horizontalMargin = 15.0;
    self.starRating.editable=YES;
    self.starRating.rating= 2.5;
    self.starRating.displayMode=EDStarRatingDisplayHalf;
    [self.starRating  setNeedsDisplay];
    self.starRating.tintColor = [[UIColor alloc] initWithRed:63.0/255.0 green:192.0/255.0 blue:169.0/255.0 alpha:1];
    [self starsSelectionChanged:self.starRating rating:2.5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
