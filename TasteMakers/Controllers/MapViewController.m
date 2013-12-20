//
//  MapViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "MapViewController.h"

#import "TasteApiCommunicator.h"
#import "TasteRestaurantsManager.h"
#import "TasteRestaurantsDelegate.h"
#import "Restaurant.h"
#import "DetailsRestaurantViewController.h"
#import "RestaurantDetailsManager.h"
#import "FilterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CAKeyframeAnimation+AHEasing.h"
#import "NotificationManager.h"

@interface MapViewController () <TasteRestaurantsDelegate>

@end

@implementation MapViewController

@synthesize restaurantManager, restaurants, restaurantMapView, activeAnnotationViews, detailsView, filterViewInstance;

@synthesize loadingContainer;

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
    
    // first set up the location manager. So we can show the location a good region, so he don't has to go to Holland to have a dinner, when he's in New York.
    locationManagerObserver = [[LocationManagerObserver alloc] init];
    locationManagerObserver.delegate = self;
    [locationManagerObserver setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    locationManagerObserver.locationManager.distanceFilter = 30;
    
    [locationManagerObserver startUpdatingLocation];
    
    restaurantMapView.showsUserLocation = TRUE;
    
    // giving the loading holder a border radius
    UIRectCorner borderCorners = UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerTopLeft | UIRectCornerTopRight;
    CGSize borderRadius = CGSizeMake(5.0f, 5.0f);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:loadingContainer.bounds
                                               byRoundingCorners:borderCorners
                                                     cornerRadii:borderRadius];
    
    // Mask the container view’s layer to round the corners.
    CAShapeLayer *cornerMaskLayer = [CAShapeLayer layer];
    [cornerMaskLayer setPath:path.CGPath];
    loadingContainer.layer.mask = cornerMaskLayer;
    
    
    [self showContainerView];
    
    // load the restaurantManager. Fetch all the restaurants.
    
    restaurantManager = [[TasteRestaurantsManager alloc] init];
    restaurantManager.communicator = [[ TasteApiCommunicator alloc] init];
    restaurantManager.communicator.delegate = restaurantManager;
    restaurantManager.delegate = self;
    
    
    [self createFilterView];
    
    
    
}



- (void) locationUpdatedWithDesiredAccuracy:(CLLocation *)location {
    
    CLLocationCoordinate2D coord = {
        .latitude = location.coordinate.latitude,
        .longitude = location.coordinate.longitude};
    
    [restaurantManager fetchRestaurants:coord withFilter:[[NSMutableArray alloc] init]];
    
    MKCoordinateRegion region;
    region.center = coord;
    
    MKCoordinateSpan span = {.latitudeDelta = 0.05, .longitudeDelta = 0.05};
    region.span = span;
    
    [restaurantMapView setRegion:region animated:YES];
    
    lastLocation = coord;
    
    // sorry location manager we dont need you anymore
    [locationManagerObserver stopUpdatingLocation];
}

-(void)assignPlacemarkers {
    
   
    
    Restaurant *_restaurant = [[Restaurant alloc] init];
    
    for (_restaurant in self.restaurants) {
        
        if (!_restaurant.hided) {
            [restaurantMapView addAnnotation:_restaurant.placemark];
        }
        
    }
    
    
}

- (void) filterViewDismissedWithSelectedFilters:(NSMutableArray *)filters fromViewController:(UIViewController *)viewController {
    
    
    [restaurantManager fetchRestaurants:lastLocation withFilter:filters];
    
    [self hideFilterView:viewController];
    
}

- (void) createFilterView {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FilterViewController *filterViewController = (FilterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"filterView"];
    
    UIView *filterView = filterViewController.view;
    // set the view to -50, because we want some padding
    filterView.frame = CGRectMake(-filterView.frame.size.width, filterView.frame.origin.y, filterView.frame.size.width -50,  filterView.frame.size.height);
    
    // create the green border on the right
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake(filterView.frame.size.width - 2, 0.0f, 2.0f, filterView.frame.size.height);
    rightBorder.backgroundColor = [[UIColor alloc] initWithRed:20.0f green:10.0f blue:0.0f alpha:1].CGColor;
    [filterView.layer addSublayer:rightBorder];
    [self.view addSubview:filterViewController.view];
    [self addChildViewController:filterViewController];
    
    //Create the black alpha to hide the maps
    
    
    [filterViewController setDelegate:self];
    
    
    filterViewInstance = filterViewController;
    

}

- (void) hideFilterView:(UIViewController *) activeViewController {
    
    CGPoint toPoint = self.view.center;
    toPoint.x = - filterViewInstance.view.frame.size.width/2;
    
    CGPoint fromPoint = filterViewInstance.view.center;
    
    CALayer *layer= [filterViewInstance.view layer];
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.50] forKey:kCATransactionAnimationDuration];
    
    CAAnimation *filterViewAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"
                                                                     function:ExponentialEaseInOut
                                                                    fromPoint:fromPoint
                                                                      toPoint:toPoint];
    
    
    
    [filterViewAnimation setDelegate:self];
    [layer addAnimation:filterViewAnimation forKey:@"position"];
    
    
    [CATransaction commit];
    
    [filterViewInstance.view setCenter:toPoint];
}

- (IBAction)createFilterView:(id)sender {
    
    
    
    
    UIView *filterView = filterViewInstance.view;
    
    CGPoint targetCenter = self.view.center;
    targetCenter.x -= 25;
    CGPoint fromTarget = targetCenter;
    fromTarget.x -= [self.view frame].size.width - 50;
    
    CGPoint mapViewTarget = targetCenter;
    mapViewTarget.x += filterView.frame.size.width;
    
    
    
    CALayer *layer= [filterView layer];
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.50] forKey:kCATransactionAnimationDuration];
    
    CAAnimation *redViewAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"
                                                                     function:ExponentialEaseInOut
                                                                    fromPoint:fromTarget
                                                                      toPoint:targetCenter];
    
    
    
    [CATransaction setCompletionBlock:^{
        NSLog(@"Done");
    }];
    
    
    [redViewAnimation setDelegate:self];
    [layer addAnimation:redViewAnimation forKey:@"position"];
    
    
    [CATransaction commit];
    
    [filterView setCenter:targetCenter];
    
}

- (void) removePlacemarkers {
    [restaurantMapView removeAnnotations:restaurantMapView.annotations];
}

/*
 This class adds the placemark onto the mapview.
 We want to add some nice images to it
*/
 
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
  
    MKAnnotationView *pinView = nil;
    if(annotation != mapView.userLocation)
    {
        static NSString *defaultPinID = @"CustomPin";
        pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
        if ( pinView == nil )
            pinView = [[MKAnnotationView alloc]
                       initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        pinView.canShowCallout = YES;
        
        pinView.image = [UIImage imageNamed:@"PlaceMark"];    //as suggested by Squatch
        
        // Create a UIButton object to add on the
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
        [pinView setRightCalloutAccessoryView:rightButton];
        
        [activeAnnotationViews addObject:annotation];
    }
    else {
        [mapView.userLocation setTitle:@"You're here"];
    }
    return pinView;
    
}


- (void) hideContainerView {
    
    NSLog(@"Hiding container");
    
    
    [UIView animateWithDuration:0.3f delay:0.1f options:0 animations:^{
        loadingContainer.frame = CGRectMake(loadingContainer.frame.origin.x, -100, loadingContainer.bounds.size.width, loadingContainer.bounds.size.height );
        
        
    }completion:^(BOOL finished) {
        [loadingContainer removeFromSuperview];
        NSLog(@"Container view is gone");
    }];

}

- (void) showContainerView {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) errorDuringFetchingRestaurants:(NSError *)error {
    [[NotificationManager alloc] showErrorNotification:[NSString stringWithFormat:@"Error: %@", [error localizedDescription]]];
}

- (void) didReceiveRestaurants:(NSArray *)_restaurants {
    
    self.restaurants = _restaurants;
    
    [self hideContainerView];
    
    [self assignPlacemarkers];
    
}

- (void) detailsViewDismissed {
    // get the restaurant that was in the details
    Restaurant *restaurant = [[RestaurantDetailsManager sharedInstance] getRestaurant];
    if (restaurant.hided) {
        for (RestaurantPlacemark * mapAnnotation in restaurantMapView.annotations) {
            
            if ([mapAnnotation isKindOfClass:[RestaurantPlacemark class]]) {
                
            
                if (restaurant.reference == mapAnnotation.reference) {
                    [restaurantMapView removeAnnotation:mapAnnotation];
                }
            }
        }
    }
}
/*

 // This function is commented because it gave a memory error. It was too much to handle. I've left it in the code for you to review it, and maybe there were things that could be better.. Feedback is much appreciated
 
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
   
        
    RestaurantPlacemark *_placemark = [view annotation];
    Restaurant *_restaurant;
    for (_restaurant in self.restaurants) {
            // check the placemarker reference with that from a restaurant
        if (_restaurant.reference == _placemark.reference) {
            _restaurant = _restaurant;
            break;
        }
    }
    RestaurantDetailsManager *detailsManager = [RestaurantDetailsManager sharedInstance];
    [detailsManager setRestaurant:_restaurant];
    [detailsManager setViewMode:@"MAP"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DetailsRestaurantViewController *infoViewController = (DetailsRestaurantViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RestaurantDetails"];
    
    [detailsView removeFromSuperview];
        
    infoViewController.view.backgroundColor = [UIColor clearColor];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    detailsView = infoViewController.view;
    detailsView.frame = CGRectMake(0, (self.view.frame.size.height - self.tabBarController.tabBar.frame.size.height) - 50,detailsView.frame.size.width, detailsView.frame.size.height);
    [self.view addSubview:detailsView]; 
    [self addChildViewController:infoViewController];
    
        
        
        
    

}
 */


- (void) didFailToGetLocationPermissions:(NSError *)error {
    
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    if ([(UIButton*)control buttonType] == UIButtonTypeDetailDisclosure){
        
        RestaurantPlacemark *_placemark = [view annotation];
        Restaurant *_restaurant;
        for (_restaurant in self.restaurants) {
            // check the placemarker reference with that from a restaurant
            if (_restaurant.reference == _placemark.reference) {
                _restaurant = _restaurant;
                break;
            }
        }
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        DetailsRestaurantViewController *infoViewController = (DetailsRestaurantViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RestaurantDetails"];
        [infoViewController setDelegate:self];
        [[RestaurantDetailsManager sharedInstance] setRestaurant:_restaurant];
        
        infoViewController.view.backgroundColor = [UIColor whiteColor];
        self.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self.parentViewController presentViewController:infoViewController animated:YES completion:nil];
       

        
        
        
    } 
}

- (void) hideDetailsView {
    [self dismissViewControllerAnimated:YES completion:^{[self dismissViewControllerAnimated:YES completion:nil];}];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // check if container view is needed
    
    
}

-(void) detailsButtonPressed {
    NSLog(@"Pressed");
}



@end
