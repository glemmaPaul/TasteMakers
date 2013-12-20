//
//  FilterViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 17-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterViewCell.h"
#import "FilterManager.h"
#import "Filter.h"

@interface FilterViewController ()

@end

@implementation FilterViewController
@synthesize filters, manager;
@synthesize filterTableView, selectedFilters;

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
    
    manager = [FilterManager sharedInstance];
    [manager setDelegate:self];
    [manager getFilters];
    
    
    
}

- (void) didFailToRetrieveFilters: (NSError *) error {
    NSLog(@"Error: %@", error);
}

- (void) didRetrievedFilters:(NSMutableArray *)filterObjects {
    filters = filterObjects;
    
    [filterTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [filters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FilterCell";
    UITableViewCell *cell = [filterTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Filter *filter = [self.filters objectAtIndex:indexPath.row];

    [cell.textLabel setText:filter.name];
    
    return cell;
}


- (IBAction)doneButtonClicked:(id)sender {
    
    [self.delegate filterViewDismissedWithSelectedFilters:selectedFilters fromViewController:self];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    // add the filter to the selected filters
    Filter *filter = [self.filters objectAtIndex:indexPath.row];
    [selectedFilters addObject:filter];
    
    

    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    // add the filter to the selected filters
    Filter *filter = [self.filters objectAtIndex:indexPath.row];
    [selectedFilters removeObject:filter];
}


@end
