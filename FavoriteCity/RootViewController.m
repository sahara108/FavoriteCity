//
//  RootViewController.m
//  FavoriteCity
//
//  Created by Nguyen Tuan on 26/05/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize tableView = _tableView;
@synthesize dataArray = _dataArray;
@synthesize addController = _addController;

-(void)dealloc
{
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

-(void)addCity:(id)sender
{
    //TODO:
    if (!_addController) {
        _addController = [[AddCityController alloc] initWithNibName:@"AddCityController" bundle:nil];
        _addController.delegate = self;
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

@end