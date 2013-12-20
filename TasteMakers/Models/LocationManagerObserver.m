//
//  LocationManager.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 18-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//



#import "LocationManagerObserver.h"



@implementation LocationManagerObserver
@synthesize locationManager, location, delegate, bestEffortAtLocation;

+ (LocationManagerObserver *)sharedInstance
{
    static LocationManagerObserver *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return self;
}


- (void) setDesiredAccuracy:(CLLocationAccuracy)locationAccuracy {
    self.locationManager.desiredAccuracy = locationAccuracy;
}

-(void) startUpdatingLocation {
    [locationManager startUpdatingLocation];
}

- (void) stopUpdatingLocation {
    [locationManager stopUpdatingLocation];
}

-(CLLocation *) getLastLocation {
    return self.bestEffortAtLocation;
}

- (void)locationManager:(CLLocationManager*)manager
    didUpdateToLocation:(CLLocation*)newLocation
           fromLocation:(CLLocation*)oldLocation
{
    
    

    // check if the location is old. Sometimes the location is cached by the phone.
    // We want fresh, and accurate location data.
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    // check if locationData is higher than 5 seconds. If yes, quit
    if (locationAge > 5.0) return;
    
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) return;
    
    // Check if the new location accuracy is better than before
    if (bestEffortAtLocation == nil || bestEffortAtLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
        // store the location as the "best effort"
        self.bestEffortAtLocation = newLocation;
        
        
        if (newLocation.horizontalAccuracy <= locationManager.desiredAccuracy) {
            if ([self.delegate respondsToSelector:@selector(locationUpdatedWithDesiredAccuracy:)]) {
                [self.delegate locationUpdatedWithDesiredAccuracy:self.bestEffortAtLocation];
            }
        }
    }
   
    // just the old fashioned way.
    if ([self.delegate respondsToSelector:@selector(locationManager:didUpdateToLocation:fromLocation:)]) {
        [self.delegate locationManager:manager didUpdateToLocation:newLocation fromLocation:oldLocation];
    }
    
    
}

- (void)locationManager:(CLLocationManager*)manager
       didFailWithError:(NSError*)error
{
    switch([error code])
    {
        case kCLErrorNetwork: // general, network-related error
        {
            if ([self.delegate respondsToSelector:@selector(didFailToGetLocation:)]) {
                [self.delegate didFailToGetLocation:error];
            }
        }
            break;
        case kCLErrorDenied:{
            if ([self.delegate respondsToSelector:@selector(didFailToGetLocationPermissions:)]) {
                [self.delegate didFailToGetLocationPermissions:error];
            }

        }
            break;
        default:
        {
            if ([self.delegate respondsToSelector:@selector(didFailToGetLocationWithUnknownError:)]) {
                [self.delegate didFailToGetLocationWithUnknownError:error];
            }

        }
            break;
    }
}




@end