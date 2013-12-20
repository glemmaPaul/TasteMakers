//
//  RestaurantCollection.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface RestaurantCollection : NSObject

@property (nonatomic, strong) NSMutableArray *restaurants;
+ (NSArray *)fetchRestaurants:(NSArray *)objectNotation error:(NSError **)error;

@end

