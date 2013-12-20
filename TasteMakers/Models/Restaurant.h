//
//  Restaurant.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestaurantPlacemark.h"
#import "User.h"

@interface Restaurant : NSObject
@property NSString *title;
@property NSString *description;
@property NSMutableArray *reviews;
@property NSArray *tweets;
@property NSNumber *reference;
@property User *user;
@property CLLocationCoordinate2D location;
@property RestaurantPlacemark *placemark;
@property BOOL hided;

@end
