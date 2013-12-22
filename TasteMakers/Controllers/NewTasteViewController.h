//
//  NewTasteViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateTasteManager.h"
#import <CoreLocation/CoreLocation.h>
#import "CreateTasteDelegate.h"
#import "FilterViewController.h"
#import "LocationManagerDelegate.h"
#import "LocationManagerObserver.h"

@interface NewTasteViewController : UIViewController <LocationManagerDelegate, FilterViewControllerDelegate> {
    LocationManagerObserver *locationManager;
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    UILabel *loadingLabel;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property CreateTasteManager *manager;
@property CLLocationCoordinate2D currentLocation;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;
@property NSMutableArray *selectedFilters;
@property id<CreateTasteDelegate> delegate;

@end
