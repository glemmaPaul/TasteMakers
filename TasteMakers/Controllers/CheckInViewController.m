//
//  CheckInViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "CheckInViewController.h"

#import "TasteApiCommunicator.h"
#import "TasteRestaurantsManager.h"
#import "TasteRestaurantsDelegate.h"
#import "Restaurant.h"
#import "DetailsRestaurantViewController.h"
#import "RestaurantTableViewCell.h"
#import "NotificationManager.h"

@interface CheckInViewController ()

@end

@implementation CheckInViewController

@synthesize manager, restaurants, CheckInTableView;

@synthesize bestEffortAtLocation;

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
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    // we set the accuracy a little better, because we went to check in really specific
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    // setting up manager
    manager = [[CheckInManager alloc] init];
    manager.communicator = [[TasteApiCommunicator alloc] init];
    manager.delegate = self;
    manager.communicator.delegate = manager;
}

- (void)locationManager:(CLLocationManager *)currentLocationManager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    
    // test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    if (locationAge > 5.0) return;
    
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) return;
    
    // test the measurement to see if it is more accurate than the previous measurement
    if (bestEffortAtLocation == nil || bestEffortAtLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
        // store the location as the "best effort"
        self.bestEffortAtLocation = newLocation;
        
        // test the measurement to see if it meets the desired accuracy
        //
        // IMPORTANT!!! kCLLocationAccuracyBest should not be used for comparison with location coordinate or altitidue
        // accuracy because it is a negative value. Instead, compare against some predetermined "real" measure of
        // acceptable accuracy, or depend on the timeout to stop updating. This sample depends on the timeout.
        //
        if (newLocation.horizontalAccuracy <= locationManager.desiredAccuracy) {
            // we have a measurement that meets our requirements, so we can stop updating the location
            //
            // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
            //
            [locationManager stopUpdatingLocation];
            
            CLLocationCoordinate2D coord = {
                .latitude = newLocation.coordinate.latitude,
                .longitude = newLocation.coordinate.longitude};
            
            // setting up manager
            manager = [[CheckInManager alloc] init];
            manager.communicator = [[TasteApiCommunicator alloc] init];
            manager.delegate = self;
            manager.communicator.delegate = manager;
            
            [manager getRestaurantsNearby:coord];
            
            
            
            // we can also cancel our previous performSelector:withObject:afterDelay: - it's no longer necessary
            [NSObject cancelPreviousPerformRequestsWithTarget:self];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.restaurants count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"RestaurantCell";
    RestaurantTableViewCell *cell = [CheckInTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Restaurant *_restaurant = [self.restaurants objectAtIndex:indexPath.row];
    
    [cell setTitle:_restaurant.title andSubTitle:_restaurant.description];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:NO];
    // ret the restaurant object
    Restaurant *restaurant = [self.restaurants objectAtIndex:indexPath.row];
    
    [manager checkInForRestaurant:restaurant];
    
    [[NotificationManager alloc] showSuccessNotification:@"You're checked in!"];
    
    
}


-(void) errorDuringGettingRestaurants:(NSError *)error {
    NotificationManager *notificationManager = [[NotificationManager alloc] init];
    [notificationManager showErrorNotification:@"Couldn't retrieve the restaurants. Try again later."];
}

-(void) didReceiveRestaurants:(NSArray *)restaurantArray {
    self.restaurants = restaurantArray;
    
    

    [CheckInTableView reloadData];
}

@end
