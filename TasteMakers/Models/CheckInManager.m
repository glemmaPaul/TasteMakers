//
//  CheckInManager.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "CheckInManager.h"
#import "CheckIn.h"
#import "RestaurantCollection.h"
#import "UserPreferences.h"

@implementation CheckInManager
@synthesize communicator;
- (BOOL) checkInForRestaurant:(Restaurant *)restaurantObject {
    
    CheckIn *checkInObject = [[CheckIn alloc]init];
    checkInObject.name = restaurantObject.title;
    checkInObject.description = restaurantObject.description;
    checkInObject.date = [[NSDate alloc] init];
    checkInObject.reference = restaurantObject.reference;
    
    return [[UserPreferences alloc] addCheckIn:checkInObject];
}

- (NSArray *) getCheckIns {
    return [[ UserPreferences alloc] getCheckInArray];
}

- (void) getRestaurantsNearby: (CLLocationCoordinate2D) coordinate {
    NSLog(@"Getting nearby restaurants");
    NSNumber *range = [[NSNumber alloc] initWithInt:2];
    [communicator getRestaurants:coordinate withRange:range];
}

- (void) fetchingError:(NSError *)error {
    [self.delegate errorDuringGettingRestaurants:error];
}

- (void) didReceiveData:(NSMutableDictionary *)jsonData {
   // turn them into restaurants
    NSArray *_restaurants = [NSArray alloc];
    
    NSError *error = [NSError alloc];
    
    if ([jsonData valueForKey:@"results"] != nil) {
        _restaurants = [RestaurantCollection fetchRestaurants:[jsonData valueForKey:@"results"] error:&error];
        
    
    }
    
    [self.delegate didReceiveRestaurants:_restaurants];
    
}
@end
