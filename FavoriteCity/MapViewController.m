//
//  MapViewController.m
//  FavoriteCity
//
//  Created by Khanh on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "CustomAnnotation.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView;
@synthesize dictCity;
-(void)dealloc
{
    [dictCity release];
    [mapView release];
    [super dealloc];
}
-(void)viewWillAppear:(BOOL)animated
{
    if (dictCity) {
        CLLocation *spin = [[CLLocation alloc]initWithLatitude:[[dictCity objectForKey:@"lat"] floatValue] longitude:[[dictCity objectForKey:@"log"] floatValue]];
        
        NSLog(@"%f %f",spin.coordinate.latitude,spin.coordinate.longitude);
        CLLocationCoordinate2D coor = {.latitude = spin.coordinate.latitude , .longitude =  spin.coordinate.longitude};
        
        MKCoordinateSpan span = {.latitudeDelta = 0.01,.longitudeDelta = 0.01};
        MKCoordinateRegion region ={coor,span};
        mapView.mapType = MKMapTypeStandard;
        //  region2 = [mapView regionThatFits:region2];
        [mapView setRegion:region animated:YES];
        mapView.showsUserLocation = YES;

        NSString *name = [dictCity objectForKey:@"name"];
       
        CustomAnnotation *annotation = [[CustomAnnotation alloc]initWithLocation:spin.coordinate description:name address:@""];
        [mapView addAnnotation:annotation];
        [annotation release];
        [spin release];
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

-(MKAnnotationView *)mapView:(MKMapView *)mapView12 viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[CustomAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView* pinView = (MKPinAnnotationView*)[mapView12 dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        if (!pinView)
        {
            //            NSLog(@"MKPinAnnotationView");
            // If an existing pin view was not available, create one.
            pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotation"]autorelease];
            pinView.pinColor = MKPinAnnotationColorRed;
            pinView.animatesDrop = YES;  
            pinView.canShowCallout = YES;
            //            [[pinView annotation] coordinate].
                  
            
            //            if (showDetail) {
            //                pinView.canShowCallout = YES;
            //            }else {
            //                pinView.canShowCallout = NO;
            //            }
            
        }
        else
        {
            NSLog(@"annotation");
            pinView.annotation = annotation;
        }
        return pinView;
    }
    
    return nil;
}


@end
