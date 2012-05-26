//
//  AddCityController.h
//  FavoriteCity
//
//  Created by Nguyen Tuan on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddCityDelegate <NSObject>

-(void)didAddCity:(NSDictionary*)city;

@end

@interface AddCityController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic, retain) NSMutableArray *resultArray;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSTimer *searchTimer;
@property (nonatomic, assign) id<AddCityDelegate> delegate;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) NSString *nameTest;

@end
