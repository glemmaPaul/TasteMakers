//
//  NewTasteViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "NewTasteViewController.h"
#import "TasteApiCommunicator.h"
#import "Restaurant.h"
#import "User.h"
#import "UserPreferences.h"
#import "NotificationManager.h"
#import "FilterViewController.h"
@interface NewTasteViewController ()

@end

@implementation NewTasteViewController
@synthesize currentLocation;
@synthesize manager;
@synthesize nameTextField;
@synthesize descriptionTextField;
@synthesize saveButton;
@synthesize cancelButton;
@synthesize selectedFilters;


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
    
    locationManager = [LocationManagerObserver sharedInstance];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    locationManager.locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    manager = [[CreateTasteManager alloc] init];
    manager.communicator = [[ TasteApiCommunicator alloc] init];
    manager.communicator.delegate = manager;
    manager.delegate = self.delegate;

    

}




/*
 This function checks if the user has his location services turned on,
 when not. He will dismiss the view
*/
- (void) checkLocationSetting {
    // get current location
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied) {
        // we can get the location
        
    }
    else {
        // we can't! it's disabled
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oeps! Can't find you"
                                                        message:@"We need your location to add a taste. Give us the permission, and we promise that you can add a taste again"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveTaste:(id)sender {
    
    [self checkLocationSetting];
    
    if (CLLocationCoordinate2DIsValid(currentLocation)) {
        
        
        Restaurant *restaurant = [[Restaurant alloc] init];
        restaurant.title = nameTextField.text;
        restaurant.description = descriptionTextField.text;
        restaurant.location = currentLocation;
        
        UserPreferences *_userPreferences = [[UserPreferences alloc] init];
        restaurant.user = [_userPreferences getUserObject];
        
        
        
        
        
        // change save button to disabled
        [saveButton setEnabled:NO];
        
        
        
        [manager createRestaurant:restaurant];
        
        
        
    } else {
        // we can't! it's disabled
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops! Can't find you"
                                                        message:@"We are waiting for your current location. When we find it, you can try to save it again!"
                                                       delegate:nil
                                              cancelButtonTitle:@"I'll wait"
                                              otherButtonTitles:nil];
        [alert show];
        
       

    }
    
    
    
    
}
- (IBAction)chooseFiltersPushed:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FilterViewController *filterViewController = (FilterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"filterView"];
    [filterViewController setDelegate:self];
    [self presentViewController:filterViewController animated:YES completion:nil];
}

- (void) filterViewDismissedWithSelectedFilters:(NSMutableArray *)filters fromViewController:(UIViewController *)viewController {
    NSLog(@"Filters are in");
    selectedFilters = filters;
    
    [viewController dismissViewControllerAnimated:YES completion:nil];
}



- (IBAction)cancelCreatingTaste:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    if ((oldLocation.coordinate.longitude != newLocation.coordinate.longitude)
        || (oldLocation.coordinate.latitude != newLocation.coordinate.latitude)) {
        
        currentLocation = newLocation.coordinate;
        
    }
    
    
}



@end
