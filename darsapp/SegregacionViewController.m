//
//  SegregacionViewController.m
//  darsapp
//
//  Created by inf227al on 7/05/14.
//  Copyright (c) 2014 ___greensoft___. All rights reserved.
//

#import "SegregacionViewController.h"

@interface SegregacionViewController ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation SegregacionViewController

//para el carrusel
@synthesize carruselsegregacion;
@synthesize items;

- (IBAction)seApreto:(id)sender {
     [carruselsegregacion scrollToItemAtIndex:0 animated:YES];
}

- (void)awakeFromNib
{
    //set up data
    //your carousel should always be driven by an array of
    //data of some kind - don't store data in your item views
    //or the recycling mechanism will destroy your data once
    //your item views move off-screen
    self.items = @[@"1_Verde.png",@"2_Plomo.png",@"3_Blanco.png",@"4_Azul.png",@"4_Rojo.png"];
    NSLog(@"%d",self.items.count);
    
}

- (void)dealloc
{
    //it's a good idea to set these to nil here to avoid
    //sending messages to a deallocated viewcontroller
    carruselsegregacion.delegate = nil;
    carruselsegregacion.dataSource = nil;
}


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
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    carruselsegregacion.type=iCarouselTypeCoverFlow;
}

- (void)didReceiveMemoryWarning33

{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///////////////////////////////////////////////
//Para editar las imagenes del carrusel AQUIIIIIIIIII

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    return [items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        
        ((UIImageView *)view).image = [UIImage imageNamed: self.items[index]];
        
        
        
        
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    //label.text = [items[index] stringValue];
    
    return view;
}

-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    
}


@end
