//
//  RestaurantTableViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "RestaurantTableViewController.h"

#import "TasteApiCommunicator.h"
#import "TasteRestaurantsManager.h"
#import "TasteRestaurantsDelegate.h"
#import "Restaurant.h"

#import "DetailsRestaurantViewController.h"

@interface RestaurantTableViewController ()  <TasteRestaurantsDelegate>

@end

@implementation RestaurantTableViewController
@synthesize restaurantManager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    restaurantManager = [[TasteRestaurantsManager alloc] init];
    restaurantManager.communicator = [[ TasteApiCommunicator alloc] init];
    restaurantManager.communicator.delegate = restaurantManager;
    restaurantManager.delegate = self;
    
    
    //[restaurantManager fetchRestaurants];
    
    [self setEditing:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.restaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TastMakersRestaurantCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Restaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    
    cell.textLabel.text = restaurant.title;
    cell.detailTextLabel.text = restaurant.description;
    
    
    return cell;
}

- (void) errorDuringFetchingRestaurants:(NSError *)error {
    NSLog(@"%@", error);
}

- (void) didReceiveRestaurants:(NSArray *)restaurants {
    self.restaurants = restaurants;
    [self.tableView reloadData];
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // ret the restaurant object
    //Restaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsRestaurantViewController *infoViewController = (DetailsRestaurantViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RestaurantDetails"];
    
   
    infoViewController.view.backgroundColor = [UIColor clearColor];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [self presentViewController:infoViewController animated:NO completion:nil];
    
    [infoViewController startAnimatingObjects];
   

    
    
}

@end
