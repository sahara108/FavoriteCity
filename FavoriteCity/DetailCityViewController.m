//
//  DetailCityViewController.m
//  FavoriteCity
//
//  Created by Khanh on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailCityViewController.h"

@interface DetailCityViewController ()

@end

@implementation DetailCityViewController
@synthesize dictCity;
@synthesize lblLat,lblLong,lblState,lblName;
@synthesize mapViewController;

-(void)dealloc
{
    [mapViewController release];
    [lblLat release];
    [lblName release];
    [lblLong release];
    [lblState release];
    [dictCity release];
    [super dealloc];
}
-(IBAction)viewInMap:(id)sender
{
    if (!mapViewController) {
        mapViewController = [[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    }
    if (self.dictCity) {
         mapViewController.dictCity = self.dictCity;
        [self.navigationController pushViewController:mapViewController animated:YES];
    }
   
}
-(void)viewWillAppear:(BOOL)animated
{
    if (dictCity) {
        self.lblName.numberOfLines =3;
        self.lblName.textAlignment = UITextAlignmentCenter;
        lblLat.text = [NSString stringWithFormat:@"%@",[dictCity objectForKey:@"lat"]] ;
        lblLong.text = [NSString stringWithFormat:@"%@",[dictCity objectForKey:@"log"]];
        lblState.text = [dictCity objectForKey:@"state"];
        lblName.text  =[dictCity objectForKey:@"name"];
        
    }
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
