//
//  RootViewController.m
//  FavoriteCity
//
//  Created by Nguyen Tuan on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"
#import "City.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize tableView = _tableView;
@synthesize dataArray = _dataArray;
@synthesize addController = _addController;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize requestFavoriteCity = _requestFavoriteCity;
@synthesize dataSourceCities;
@synthesize arrayDataFavoriteCities;
@synthesize detailCityViewController;

-(void)dealloc
{
    [detailCityViewController release];
    [arrayDataFavoriteCities release];
    [dataSourceCities release];
    [_requestFavoriteCity release];
    [_addController release];
    [_tableView release];
    [_dataArray release];
    
    [super dealloc];
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
    [self loadNewData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)cancel:(id)sender
{
    [self.tableView setEditing:NO animated:YES];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCity:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
}

-(void)enableEdit:(id)sender
{
    [self.tableView setEditing:YES animated:YES];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [self.navigationItem setRightBarButtonItem:cancel];
    [cancel release];
    //TODO:
}
-(void) deleteAllCities
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"City" inManagedObjectContext:_managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *items = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
    
    
    for (NSManagedObject *managedObject in items) {
        [_managedObjectContext deleteObject:managedObject];
        NSLog(@"%@ object deleted",[entity name]);
    }
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error deleting %@ - error:%@",[entity name],error);
    }

}
-(void)addCity:(id)sender
{
    //TODO:
    if (!_addController) {
        _addController = [[AddCityController alloc] initWithNibName:@"AddCityController" bundle:nil];
        _addController.delegate = self;
    }
//    City *addCity = (City *)[NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:_managedObjectContext];
//	
//    
//    [addCity setName:@"City one"];
//    [addCity setLat:[NSNumber numberWithDouble:100]];
//    [addCity setLog:[NSNumber numberWithDouble:100]];
//	
//	
//	
//	// Commit the change.
//	NSError *error;
//	if (![_managedObjectContext save:&error]) {
//		// Handle the error.
//	}else {
//        NSLog(@"done");
//        NSFetchRequest *request = [[NSFetchRequest alloc] init];
//        NSEntityDescription *entity = [NSEntityDescription entityForName:@"City" inManagedObjectContext:_managedObjectContext];
//        [request setEntity:entity];
//        
//       
//        
//        // Execute the fetch -- create a mutable copy of the result.
//        NSError *error = nil;
//        NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
//        if (mutableFetchResults == nil) {
//            // Handle the error.
//        }
//        
//        // Set self's events array to the mutable array, then clean up.
//        if (mutableFetchResults) {
//             City *temp = [mutableFetchResults objectAtIndex:0];
//            _addController.nameTest = [NSString stringWithFormat:@"%@",[temp name]];
//        }
//        [self deleteAllCities];
//        [mutableFetchResults release];
//        [request release];
//        
//        
//
//    }
	[self getDataSoureFromCoreData];
    if (dataSourceCities) {
        _addController.dataSourceCities = self.dataSourceCities;
    }

        
    [self.navigationController pushViewController:_addController animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(enableEdit:)];
    self.navigationItem.leftBarButtonItem = editButton;
    [editButton release];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCity:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    arrayDataFavoriteCities = [userDefault objectForKey:@"favoriteCities"];
    if (!arrayDataFavoriteCities) {
        //            self.arrayDataFavoriteCities = [NSMutableArray array];
    }
    [self.tableView reloadData];
}
-(void)loadNewData
{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BOOL coreDataExist = [[userDefault objectForKey:@"coreDataExist"]boolValue];
    if (coreDataExist==NO) {
        NSLog(@"start Download Data...");
        if (!_requestFavoriteCity) {
            _requestFavoriteCity = [[CityProvider alloc]init];
            _requestFavoriteCity.delegateJson = self;
        }
        
        [_requestFavoriteCity configURL];
        [_requestFavoriteCity requestData];
        
    }else {
        //
        NSLog(@"coredata exist...");
    }

    
   
}
-(void) getDataSoureFromCoreData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"City" inManagedObjectContext:_managedObjectContext];
    [request setEntity:entity];
    
    
    
    // Execute the fetch -- create a mutable copy of the result.
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
    }
    
    // Set self's events array to the mutable array, then clean up.
    if (mutableFetchResults) {
        NSMutableArray *array = [NSMutableArray array];
        for(City *element in mutableFetchResults)
        {
            NSDictionary *dictCity = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [element name],@"name",
                                      [element lat],@"lat",
                                      [element log],@"log",
                                      [element state],@"state",
                                      [element url], @"url",
                                      nil];
            [array addObject:dictCity];
        }
        if (dataSourceCities) {
            [dataSourceCities removeAllObjects];
        }
        self.dataSourceCities = [NSMutableArray arrayWithArray:array];
        //        _addController.dataSourceCities = [NSMutableArray arrayWithArray:array];
        //        [_addController.tableView reloadData];
        
        [mutableFetchResults release];
        [request release];
    }

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark
#pragma mark TableView
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    arrayDataFavoriteCities = [[userDefault objectForKey:@"favoriteCities"] mutableCopy];
    NSDictionary *dictCity = [arrayDataFavoriteCities objectAtIndex:indexPath.row];
    if ([arrayDataFavoriteCities isKindOfClass:[NSMutableArray class]]&&dictCity) {
        [arrayDataFavoriteCities removeObject:dictCity];
        [userDefault setObject:arrayDataFavoriteCities forKey:@"favoriteCities"];
        [userDefault synchronize];
    }
    [self.tableView setEditing:NO animated:YES];
    [self.tableView reloadData];

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCity:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
}
 -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView    
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arrayDataFavoriteCities) {
        return [arrayDataFavoriteCities count];
    }
    return [self.dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"City_List"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"City_List"] autorelease];
    }
    if (self.arrayDataFavoriteCities&& [self.arrayDataFavoriteCities count]>0) {
        NSDictionary *dictCity = [self.arrayDataFavoriteCities objectAtIndex:indexPath.row];
        if (dictCity) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[dictCity objectForKey:@"name"]];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO:
    //push detailtableView
    if (!detailCityViewController) {
        detailCityViewController = [[DetailCityViewController alloc]initWithNibName:@"DetailCityViewController" bundle:nil];
    }
    
    NSDictionary *dictCity = [arrayDataFavoriteCities objectAtIndex:indexPath.row];
    if (dictCity) {
        detailCityViewController.dictCity = dictCity;
        [self.navigationController pushViewController:detailCityViewController animated:YES];

    }
     
}

#pragma mark
#pragma mark AddCityDelegate

-(void)didAddCity:(NSDictionary *)city
{
    //TODO:
}
#pragma mark-
#pragma mark City Provider Delegate
-(void)CityProviderDidFinishParseJSon:(CityProvider *)provider
{
    
    [self getDataSoureFromCoreData];
    if (provider.resultContent) {
        for( NSDictionary *dictCity in provider.resultContent)
        {
            BOOL needAdd = YES;
            
            for(NSDictionary *dictCityExist in self.dataSourceCities)
            {
                if ([[dictCityExist objectForKey:@"name"]isEqual:[dictCity objectForKey:@"name"]]) {
                    needAdd = NO;
                    break;
                }
            }
            if (needAdd) {
                
                City *addCity = (City *)[NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:_managedObjectContext];
                
                NSNumber *temp = [dictCity objectForKey:@"primary_latitude"];
                double t1 = temp.doubleValue;
                NSNumber *temp2 = [dictCity objectForKey:@"primary_longitude"];
                double t2 = temp2.doubleValue;
                [addCity setName:[dictCity objectForKey:@"name"]];
                [addCity setState:[dictCity objectForKey:@"state_name"]];
                [addCity setLat:[NSNumber numberWithDouble:t1]];
                [addCity setLog:[NSNumber numberWithDouble:t2]];
                [addCity setUrl:[dictCity objectForKey:@"url"]];
                NSError *error;
                if (![_managedObjectContext save:&error]) {
                    // Handle the error.
                }else {
                    NSLog(@"insert successfull %@",[addCity name]);
                }

            }
        }
        [self getDataSoureFromCoreData];
        [self.tableView reloadData];
        
        
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        BOOL coreDataExist = [[userDefault objectForKey:@"coreDataExist"]boolValue];
        coreDataExist = YES;
        
        [userDefault setObject:[NSNumber numberWithBool:coreDataExist] forKey:@"coreDataExist"];
        [userDefault synchronize];
        
        
        
    }
}
@end
