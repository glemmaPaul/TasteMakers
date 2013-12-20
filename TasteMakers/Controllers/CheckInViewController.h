//
//  CheckInViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CheckInDelegate.h"
#import "CheckInManager.h"
#import "LocationManagerObserver.h"
#import "LocationManagerDelegate.h"

@interface CheckInViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, LocationManagerDelegate, CheckInDelegate> {
    LocationManagerObserver *locationManager;
}

@property(nonatomic) CLLocation *bestEffortAtLocation;
@property(nonatomic) CheckInManager *manager;
@property(nonatomic) NSArray *restaurants;
@property (weak, nonatomic) IBOutlet UITableView *CheckInTableView;

@end
