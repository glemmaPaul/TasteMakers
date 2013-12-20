//
//  TasteRestaurantsManager.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "TasteRestaurantsManager.h"
#import "RestaurantCollection.h"
#import <CoreLocation/CoreLocation.h>

@implementation TasteRestaurantsManager

- (void)fetchRestaurants:(CLLocationCoordinate2D) coordinate withFilter:(NSMutableArray *) filter
{
    [self.communicator getRestaurants:coordinate withFilters:filter];
}


- (void)didReceiveData:(NSDictionary *)jsonData
{
    if ([jsonData objectForKey:@"results"] != nil) {
        NSArray *results = [jsonData objectForKey:@"results"];
        NSError *error = nil;
        NSArray *restaurants = [RestaurantCollection fetchRestaurants:results error:&error];
    
        if (error != nil) {
            [self.delegate errorDuringFetchingRestaurants:error];
        
        } else {
            [self.delegate didReceiveRestaurants:restaurants];
        }
    }
    else {
        [self.delegate didReceiveRestaurants:[NSArray alloc]];
    }
    
}

- (void)fetchingError:(NSError *)error
{
    [self.delegate errorDuringFetchingRestaurants:error];
}
@end
