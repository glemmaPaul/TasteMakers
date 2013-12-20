//
//  TasteApiCommunicator.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"
#import "User.h"
#import <CoreLocation/CoreLocation.h>

@protocol TasteApiCommunicatorDelegate;

@interface TasteApiCommunicator : NSObject

@property (weak, nonatomic) id<TasteApiCommunicatorDelegate> delegate;
- (void)getRestaurants:(CLLocationCoordinate2D)coordinate withFilters:(NSMutableArray *) filters;
- (void)createRestaurant:(NSDictionary *) restaurantObject;
- (void) registerUser: (NSString *) username;
- (void) getRestaurantsByUser: (User *) userObject;
- (void)getRestaurants:(CLLocationCoordinate2D)coordinate withRange:(NSNumber*)range;
- (void) getFilters;
@end
