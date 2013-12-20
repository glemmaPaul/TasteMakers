//
//  MapViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TasteRestaurantsManager.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationManagerObserver.h"
#import "RestaurantPlacemark.h"
#import "DetailsViewDelegate.h"
#import "ViewAnimationDelegate.h"
#import "LocationManagerDelegate.h"
#import "FilterViewControllerDelegate.h"
#import "FilterViewController.h"


@interface MapViewController : UIViewController <LocationManagerDelegate, MKMapViewDelegate, DetailsViewDelegate, FilterViewControllerDelegate> {
    LocationManagerObserver *locationManagerObserver;
    CLLocationCoordinate2D lastLocation;
}
@property (weak, nonatomic) id<ViewAnimationDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *loadingContainer;
@property TasteRestaurantsManager *restaurantManager;
@property NSArray *restaurants;
@property NSMutableArray *activeAnnotationViews;
@property (retain, nonatomic) IBOutlet MKMapView *restaurantMapView;


// UIView elements for the annotation view
@property(nonatomic,strong)UIImageView *leftCalloutAccessoryView;
@property(nonatomic,strong)UIButton *rightCalloutAccessoryView;
@property(nonatomic,strong)UILabel *titleView;
@property(nonatomic,strong)UILabel *subTitleView;

@property(strong, nonatomic) FilterViewController *filterViewInstance;

@property NSMutableArray *selectedFilters;
@property (weak, nonatomic) IBOutlet UIView *detailsView;

-(void) detailsButtonPressed;

@end

