//
//  RestaurantDetailsManager.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 17-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "RestaurantDetailsManager.h"
#import "Restaurant.h"

@implementation RestaurantDetailsManager
@synthesize currentRestaurant;
@synthesize viewMode;

+ (id)sharedInstance {
    static RestaurantDetailsManager *sharedInstance = nil;
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

- (void) setRestaurant:(Restaurant *) restaurantObject {
    currentRestaurant = restaurantObject;
}



- (Restaurant *) getRestaurant {
    return currentRestaurant;
}

@end
