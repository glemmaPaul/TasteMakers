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
#import "Filter.h"

@implementation TasteRestaurantsManager

- (void)fetchRestaurants:(CLLocationCoordinate2D) coordinate withFilter:(NSMutableArray *) filters
{
    
    NSString *filterQuery = @"";
    
    
    
    if ([filters count] > 0) {
        
        // create the filters id in a comma seperate list
        NSMutableArray *filterArray = [NSMutableArray alloc];
    
        for (Filter *_filter  in filters) {
            [filterArray addObject:_filter.identifier];
        }
    
        filterQuery = [filterArray componentsJoinedByString:@","];
    }
    
   
    
   
    
    
    
    [self.communicator getRestaurants:coordinate withFilters:filterQuery ];
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
