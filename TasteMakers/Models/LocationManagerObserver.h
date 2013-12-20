//
//  LocationManagerObserver.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 18-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationManagerDelegate.h"

@interface LocationManagerObserver : NSObject <CLLocationManagerDelegate>  {
    
    CLLocationManager* locationManager;
    CLLocation* location;
    __weak id delegate;
}

@property(nonatomic) CLLocation *bestEffortAtLocation;

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CLLocation* location;
@property (nonatomic, weak) id<LocationManagerDelegate>  delegate;

+ (LocationManagerObserver*)sharedInstance; // Singleton method
- (void) setDesiredAccuracy:(CLLocationAccuracy)locationAccuracy;
- (void) startUpdatingLocation;
- (void) stopUpdatingLocation;
- (CLLocation *) getLastLocation;
@end