//
//  RootViewController.h
//  FavoriteCity
//
//  Created by Nguyen Tuan on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCityController.h"
#import "CityProvider.h"

@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AddCityDelegate,CityProviderParseJSonDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) AddCityController *addController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;	  
@property (nonatomic, retain) CityProvider *requestFavoriteCity;

@end
