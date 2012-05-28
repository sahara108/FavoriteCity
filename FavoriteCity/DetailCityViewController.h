//
//  DetailCityViewController.h
//  FavoriteCity
//
//  Created by Khanh on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface DetailCityViewController : UIViewController

@property (nonatomic, retain) NSDictionary *dictCity;
@property (nonatomic, retain) IBOutlet UILabel *lblLat;
@property (nonatomic, retain) IBOutlet UILabel *lblLong;
@property (nonatomic, retain) IBOutlet UILabel *lblState;
@property (nonatomic, retain) IBOutlet UILabel *lblName;
@property (nonatomic, retain) MapViewController *mapViewController;

-(IBAction)viewInMap:(id)sender;
@end
