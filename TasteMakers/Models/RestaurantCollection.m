//
//  RestaurantCollection.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "RestaurantCollection.h"

#import "Restaurant.h"
#import "RestaurantPlacemark.h"
#import "User.h"
#import "Filter.h"

#import "UserPreferences.h"

@implementation RestaurantCollection

+ (NSArray *)fetchRestaurants:(NSArray *)results error:(NSError **)error {
    
    
    NSMutableArray *restaurants = [[NSMutableArray alloc] init];
    
    
    NSArray *hided_restaurants = [[ UserPreferences alloc] getHidedRestaurants];
       
    for (NSDictionary *restaurantDict in results) {
        Restaurant *restaurant = [[Restaurant alloc] init];
        restaurant.title = [restaurantDict valueForKey:@"name"];
        restaurant.description = [restaurantDict valueForKey:@"description"];
        restaurant.reference = [restaurantDict valueForKey:@"id"];
        
        
        
        if ([hided_restaurants containsObject:restaurant.reference]) {
            restaurant.hided = YES;
        }
        
        // assign the user with a user object
        User *user = [[User alloc] init];
        
        if ([restaurantDict valueForKey:@"user"] != nil) {
            NSMutableArray *userDict = [restaurantDict valueForKey:@"user"];
        
            user.identifier = [userDict valueForKey:@"id"];
            user.username = [userDict valueForKey:@"username"];
            
        }
        
        restaurant.user = user;
        
        
        /// Insert the filters with filter objects
        NSMutableArray *filters = [[NSMutableArray alloc] init];
        
        if ([restaurantDict valueForKey:@"filters"] != nil) {
            NSMutableArray *filtersDict = [restaurantDict valueForKey:@"filters"];
            
            
            for (NSMutableDictionary *_filterData in filtersDict) {
                Filter *_filterObject = [[Filter alloc] init];
                _filterObject.name = [_filterData valueForKey:@"name"];
                _filterObject.identifier = [_filterData valueForKey:@"id"];
                [filters addObject:_filterObject];
            }
        }
        
        restaurant.filters = filters;
        
        
        
        
        // create the placemark
        RestaurantPlacemark *_placemark = [[RestaurantPlacemark alloc] init];
        
        CLLocationCoordinate2D coord;
        coord.longitude = [[restaurantDict objectForKey:@"longitude"] floatValue];
        coord.latitude = [[restaurantDict objectForKey:@"latitude"] floatValue];
        
        // get the reviews
        NSMutableArray *reviews = [[UserPreferences alloc] getReviews:restaurant.reference];
        restaurant.reviews = reviews;
        
        [_placemark initWithCoordinate:coord andMarkTitle:restaurant.title andMarkSubTitle:restaurant.description andReference:restaurant.reference];
        restaurant.placemark = _placemark;

        
        [restaurants addObject:restaurant];
    }
    
    return restaurants;
}





@end
