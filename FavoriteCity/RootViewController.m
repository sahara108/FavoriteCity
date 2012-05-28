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

-(void)dealloc
{
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)enableEdit:(id)sender
{
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
    City *addCity = (City *)[NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:_managedObjectContext];
	
    
    [addCity setName:@"City one"];
    [addCity setLat:[NSNumber numberWithDouble:100]];
    [addCity setLog:[NSNumber numberWithDouble:100]];
	
	
	
	// Commit the change.
	NSError *error;
	if (![_managedObjectContext save:&error]) {
		// Handle the error.
	}else {
        NSLog(@"done");
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
             City *temp = [mutableFetchResults objectAtIndex:0];
            _addController.nameTest = [NSString stringWithFormat:@"%@",[temp name]];
        }
        [self deleteAllCities];
        [mutableFetchResults release];
        [request release];
        if (!_requestFavoriteCity) {
            _requestFavoriteCity = [[CityProvider alloc]init];
            _requestFavoriteCity.delegateJson = self;
        }
            
        [_requestFavoriteCity configURL];
        [_requestFavoriteCity requestData];
        

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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark
#pragma mark TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"City_List"];
    if (cell != nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"City_List"] autorelease];
    }
    
    //TODO:
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO:
    //push detailtableView
    DetailViewController *detail = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
}

#pragma mark
#pragma mark AddCityDelegate

-(void)didAddCity:(NSDictionary *)city
{
    //TODO:
}
#pragma mark-
#pragma mark City Provider Delegatte
-(void)CityProviderDidFinishParseJSon:(CityProvider *)provider
{
    if (provider.resultContent) {
        for( NSDictionary *dictCity in provider.resultContent)
        {
            City *addCity = (City *)[NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:_managedObjectContext];
            
            NSNumber *temp = [dictCity objectForKey:@"primary_latitude"];
            double t1 = temp.doubleValue;
            NSNumber *temp2 = [dictCity objectForKey:@"primary_longitude"];
            double t2 = temp2.doubleValue;
            [addCity setName:[dictCity objectForKey:@"name"]];
            [addCity setState:[dictCity objectForKey:@"state_name"]];
            [addCity setLat:[NSNumber numberWithDouble:t1]];
            [addCity setLog:[NSNumber numberWithDouble:t2]];
            NSError *error;
            if (![_managedObjectContext save:&error]) {
                // Handle the error.
            }else {
                NSLog(@"insert successfull %@",[addCity name]);
            }
        }
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
                                           nil];
                [array addObject:dictCity];
            }
            _addController.dataSourceCities = [NSMutableArray arrayWithArray:array];
            [_addController.tableView reloadData];
        }
        
        [mutableFetchResults release];
        [request release];
        
        
    }
}
@end
