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
@property (nonatomic, retain) NSMutableArray *arrayDataFavoriteCities;
@property (nonatomic, retain) IBOutlet UIButton *btnAdd;
@property (nonatomic, retain) IBOutlet UILabel *lbUrl;

-(IBAction)viewInMap:(id)sender;
-(IBAction)addCity:(id)sender;
-(IBAction)openCityUrl:(id)gesture;
@end
