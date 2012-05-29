//
//  AddCityController.m
//  FavoriteCity
//
//  Created by Nguyen Tuan on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddCityController.h"
#import "City.h"

@interface AddCityController ()

@end

@implementation AddCityController

@synthesize searchBar = _searchBar;
@synthesize resultArray = _resultArray;
@synthesize tableView = _tableView;
@synthesize searchTimer = _searchTimer;
@synthesize delegate = _delegate;
@synthesize nameTest = _nameTest;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize dataSourceCities ;
@synthesize detailViewController;

-(void)dealloc
{
    [detailViewController release];
    [_managedObjectContext release];
    [dataSourceCities release];
    [_nameTest release];
    if ([_searchTimer isValid]) {
        [_searchTimer invalidate];
    }
    [_searchBar release];
    [_searchTimer release];
    [_tableView release];
    [_resultArray release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataSourceCities =[NSMutableArray array];
        self.resultArray = [NSMutableArray array];
        
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.resultArray) {
        [self.resultArray removeAllObjects];
    }
    [self.searchBar becomeFirstResponder];
    [self setTitle:_nameTest];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
//    if ([_searchTimer isValid]) {
//        [_searchTimer invalidate];
//    }
//    self.searchTimer = nil;
//    
//    self.searchTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(performSearch:) userInfo:searchText repeats:NO];
    if (self.resultArray) {
        [self.resultArray removeAllObjects];
    }
    for(NSDictionary *dictCity in dataSourceCities)
    {
        NSString *name = [dictCity objectForKey:@"name"];
        if ([name hasPrefix:searchText]) {
            [self.resultArray addObject:dictCity];
        }
    }
    [self.tableView reloadData];
   
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)performSearch:(NSString*)searchText
{
    //TODO:
    
}
#pragma makr -
#pragma mark Table View Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.resultArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"City_List"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"City_List"] autorelease];
    }
    if (self.resultArray&& [self.resultArray count]>0) {
        NSDictionary *dictCity = [self.resultArray objectAtIndex:indexPath.row];
        if (dictCity) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[dictCity objectForKey:@"name"]];
        }
    }
    //TODO:
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO:
    [self.searchBar resignFirstResponder];
//    [self.delegate didAddCity:nil];
    NSDictionary *dictCity = [self.resultArray objectAtIndex:indexPath.row];
    
    if (!detailViewController) {
        detailViewController =[[DetailCityViewController alloc]initWithNibName:@"DetailCityViewController" bundle:nil];
    }
    if (dictCity) {
        detailViewController.dictCity = dictCity;
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    }
    
}

@end
