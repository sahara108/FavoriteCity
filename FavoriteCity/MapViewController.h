//
//  MapViewController.h
//  FavoriteCity
//
//  Created by Khanh on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, retain) IBOutlet MKMapView*mapView;
@property (nonatomic, retain) NSDictionary *dictCity;

@end
