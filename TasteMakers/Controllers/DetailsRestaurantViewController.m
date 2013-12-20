//
//  DetailsRestaurantViewController.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "DetailsRestaurantViewController.h"
#import "ReviewDetailsViewController.h"
#import "RestaurantPlacemark.h"
#import <MapKit/MapKit.h>
#import "UserPreferences.h"
#import "RestaurantDetailsManager.h"
#import <QuartzCore/QuartzCore.h>
#import "CAKeyframeAnimation+AHEasing.h"
#import "DetailsPageViewController.h"



@interface DetailsRestaurantViewController ()

@end

@implementation DetailsRestaurantViewController

@synthesize restaurant;
@synthesize blueBackgroundView;
@synthesize PageViewContainer;
@synthesize detailsToolbar;
@synthesize detailsNavigationBar;
@synthesize pageViewControllerInstance;

/*- (IBAction)detailsPanningOccurred:(UIPanGestureRecognizer *)GesturePanRecognizer {
    
    CGPoint positionPan = [GesturePanRecognizer locationInView:self.view.superview];
        
        // calculate the dirrefence in points between the finger and the center of the details bar
        CGPoint positionDetailsPan = [GesturePanRecognizer locationInView:self.view];
        
        
        if (GesturePanRecognizer.state == UIGestureRecognizerStateEnded) {
            
            
            
            
            positionPan.x = self.view.superview.center.x;
            
            
            
            [CATransaction begin];
            CGPoint toTarget = self.view.superview.center;
            
            
            if (positionPan.y < self.view.superview.center.y) {
                CGPoint toTarget = self.view.superview.center;
                NSLog(@"show details");
            }
            else {
                NSLog(@"Hide details");
                //animate to top
                //CGPoint toTarget;
                
                // we don't want the details view to be hidden under the tabbar
                toTarget.y = self.view.superview.frame.size.height;
                toTarget.y += self.view.frame.size.height / 2;
                toTarget.y -= self.tabBarController.tabBar.frame.size.height;
                toTarget.y -= 50;
                
            }
            
            positionPan.y += (self.view.frame.size.height / 2);
            
            [CATransaction setValue:[NSNumber numberWithFloat:0.750] forKey:kCATransactionAnimationDuration];
            
            CAAnimation *detailsViewAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"
                                                                                 function:ExponentialEaseOut
                                                                                fromPoint:positionPan
                                                                                  toPoint:toTarget];
            
            
            [CATransaction setCompletionBlock:^{
                //[self dismissViewControllerAnimated:YES completion:nil];
            }];
            [detailsViewAnimation setDelegate:self];
            CALayer *detailsLayer = [self.view layer];
            [detailsLayer addAnimation:detailsViewAnimation forKey:@"position"];
            
            [CATransaction setCompletionBlock:^{
                NSLog(@"Done");
            }];
            
            [CATransaction commit];
            
            [self.view setCenter:toTarget];
            
        }
        else {
            self.view.frame = CGRectMake(self.view.frame.origin.x, positionPan.y, self.view.frame.size.width, self.view.frame.size.height);
        }
        
    
    
}*/

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
    
    RestaurantDetailsManager *detailsManager = [RestaurantDetailsManager sharedInstance];
    
    self.restaurant = [detailsManager getRestaurant];
    
    
    // add the DetailsPageViewController to the stage
    pageViewControllerInstance = [[DetailsPageViewController alloc] init];
    pageViewControllerInstance.view.frame = PageViewContainer.bounds;
    [PageViewContainer addSubview:pageViewControllerInstance.view];
    
    
    
    
    [detailsToolbar setHidden:YES];
}

- (IBAction)doneButton:(id)sender {
    [[RestaurantDetailsManager sharedInstance] setRestaurant:self.restaurant];
    [self.delegate detailsViewDismissed];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) setMode:(NSString *) mode  {
    if ([mode  isEqual: @"MAP"]) {
        self.mode = mode;
    }
}

CGRect screenBoundsDependOnOrientation()
{
    CGRect screenBounds = [UIScreen mainScreen].bounds ;
    CGFloat width = CGRectGetWidth(screenBounds)  ;
    CGFloat height = CGRectGetHeight(screenBounds) ;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        screenBounds.size = CGSizeMake(width, height);
    }else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        screenBounds.size = CGSizeMake(height, width);
    }
    return screenBounds ;
}

/*
 This function is for animating the objects
 */
- (IBAction)hideRestaurant:(id)sender {
    
    [[ UserPreferences alloc] hideRestaurant:self.restaurant];
    
    // we don't want to lose the reviews etc.
    Restaurant *_restaurant = [[RestaurantDetailsManager sharedInstance] getRestaurant];
    _restaurant.hided = YES;
    [[ RestaurantDetailsManager sharedInstance] setRestaurant:_restaurant];
    
    UIView *hideView = [[UIView alloc] initWithFrame:screenBoundsDependOnOrientation()];
    //hideView.frame = rootView.frame;
    hideView.backgroundColor = [UIColor redColor];
    
    
    [self.view addSubview:hideView];
    
    CGPoint targetCenter = self.view.center;
    CGPoint fromTarget = targetCenter;
    fromTarget.y -= [self.view frame].size.height;
    

    
    CALayer *layer= [hideView layer];
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.750] forKey:kCATransactionAnimationDuration];
    
    CAAnimation *redViewAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"
                                                          function:ExponentialEaseInOut
                                                         fromPoint:fromTarget
                                                           toPoint:targetCenter];
    [CATransaction setCompletionBlock:^{
        // create the hide image
        UIImage *hideImage = [UIImage imageNamed:@"HideRestaurant"];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:hideImage];
        imageView.frame = CGRectMake(0, 0, 114, 114);
        imageView.center = self.view.center;
        imageView.alpha = 0;
        
        [self.view addSubview:imageView];
        
        [UIView animateWithDuration:0.4f animations:^{
            imageView.alpha = 1;
        } completion:^(BOOL finished) {
            [[RestaurantDetailsManager sharedInstance] setRestaurant:self.restaurant];
            [self.delegate detailsViewDismissed];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        
        
        //[self dismissViewControllerAnimated:YES completion:nil];
    }];
    [redViewAnimation setDelegate:self];
    [layer addAnimation:redViewAnimation forKey:@"position"];
    
    [CATransaction commit];
    
    [hideView setCenter:targetCenter];
    

}
- (IBAction)getDirections:(id)sender {
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        
        MKPlacemark *destination = [[MKPlacemark alloc] initWithCoordinate:restaurant.placemark.coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:destination];
        [mapItem setName:restaurant.title];
        
        // Set the directions mode to "Walking"
        // Can use MKLaunchOptionsDirectionsModeDriving instead
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking};
        // Get the "Current User Location" MKMapItem
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        // Pass the current location and destination map items to the Maps app
        // Set the direction mode in the launchOptions dictionary
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}
- (IBAction)checkInButtonPressed:(id)sender {
    
}

- (IBAction)toReviews:(id)sender {
    [pageViewControllerInstance animateToReviewPage];
        
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) animateDetailsToolbar {
    
    CGPoint fromPoint = [[UIApplication sharedApplication] keyWindow].center;
    fromPoint.y = -30;

    
    CGPoint toPoint = fromPoint;
    toPoint.y = detailsNavigationBar.frame.size.height / 2;
    
    
    
    CALayer *layer= [detailsToolbar layer];
    [CATransaction begin];
    [detailsToolbar setHidden:NO];
    [CATransaction setValue:[NSNumber numberWithFloat:0.500] forKey:kCATransactionAnimationDuration];
    
    CAAnimation *toolbarAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"
                                                                     function:BounceEaseOut
                                                                    fromPoint:fromPoint
                                                                      toPoint:toPoint];
    [toolbarAnimation setDelegate:self];
    [layer addAnimation:toolbarAnimation forKey:@"position"];
    
    [CATransaction commit];
    
    [detailsToolbar setFrame:CGRectMake(toPoint.x, toPoint.y, detailsToolbar.frame.size.width, detailsToolbar.frame.size.height)];

    
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self animateDetailsToolbar];
    
    [super viewDidAppear:animated];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
