//
//  RootViewController.h
//  FavoriteCity
//
//  Created by Nguyen Tuan on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddCityController.h"

@interface RootViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,AddCityDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *dataArray;
@property (nonatomic, retain) AddCityController *addController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;	    

@end
