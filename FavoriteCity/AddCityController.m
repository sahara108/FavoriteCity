//
//  AddCityController.m
//  FavoriteCity
//
//  Created by Nguyen Tuan on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddCityController.h"

@interface AddCityController ()

@end

@implementation AddCityController

@synthesize searchBar = _searchBar;
@synthesize resultArray = _resultArray;
@synthesize tableView = _tableView;
@synthesize searchTimer = _searchTimer;
@synthesize delegate = _delegate;

-(void)dealloc
{
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
    [self.resultArray removeAllObjects];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([_searchTimer isValid]) {
        [_searchTimer invalidate];
    }
    self.searchTimer = nil;
    
    self.searchTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(performSearch:) userInfo:searchText repeats:NO];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

-(void)performSearch:(NSString*)searchText
{
    //TODO:
}

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
    if (cell != nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"City_List"] autorelease];
    }
    
    //TODO:
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TODO:
    [self.searchBar resignFirstResponder];
    [self.delegate didAddCity:nil];
}

@end
