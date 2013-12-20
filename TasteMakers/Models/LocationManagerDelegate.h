//
//  LocationManagerDelegate.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 18-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol LocationManagerDelegate <NSObject>
@optional

- (void)didFailToGetLocation: (NSError *)error;
- (void)didFailToGetLocationPermissions: (NSError *)error;
- (void)didFailToGetLocationWithUnknownError: (NSError *)error;
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
- (void)locationUpdatedWithDesiredAccuracy:(CLLocation *)location;

@end
