//
//  RestaurantDetailsManager.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 17-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"

@interface RestaurantDetailsManager : NSObject

@property (nonatomic, retain) Restaurant *currentRestaurant;
+(id) sharedInstance;
-(Restaurant *) getRestaurant;
- (void) setRestaurant:(Restaurant *)restaurantObject;

@end;
