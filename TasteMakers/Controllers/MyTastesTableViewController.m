//
//  MyTastesTableViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "MyTastesTableViewController.h"
#import "RestaurantTableViewCell.h"
#import "TasteApiCommunicator.h"
#import "User.h"
#import "RestaurantDetailsManager.h"
#import "DetailsRestaurantViewController.h"

@interface MyTastesTableViewController ()

@end

@implementation MyTastesTableViewController

@synthesize manager, restaurants, userPreferences, MyTastersTableView;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSLog(@"%@", [userPreferences getUserObject]);
    
    manager = [[MyTasteManager alloc] init];
    manager.communicator = [[TasteApiCommunicator alloc] init];
    manager.communicator.delegate = manager;
    manager.delegate = self;
    
    [self refreshMyTastersTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didReceiveRestaurants:(NSArray *)restaurantsArray {
    NSLog(@"I have retrieved them");
    self.restaurants = restaurantsArray;
    [MyTastersTableView reloadData];
    
}

- (void) errorDuringFetchingRestaurants:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops! There's a problem"
                                                    message:@"We couldn't retrieve your tastes, try again later!"
                                                   delegate:nil
                                          cancelButtonTitle:@"I'll try later"
                                          otherButtonTitles:nil];
    [alert show];

}


- (void) refreshMyTastersTableView {
    [manager getMyRestaurants:[[UserPreferences alloc] getUserObject]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   return [self.restaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RestaurantCell";
    RestaurantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //[cell setTitle:@"Test" andSubTitle:@"test"];
    //cell.textLabel.text = @"test";
    Restaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    [cell setTitle:restaurant.title andSubTitle:restaurant.description];
    // Configure the cell...
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Restaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    
    [[RestaurantDetailsManager sharedInstance] setRestaurant:restaurant];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsRestaurantViewController *infoViewController = (DetailsRestaurantViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RestaurantDetails"];
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self.parentViewController presentViewController:infoViewController animated:YES completion:nil];

}



@end
