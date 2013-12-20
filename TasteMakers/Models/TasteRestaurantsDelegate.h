//
//  TasteRestaurantsDelegate.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>



@protocol TasteRestaurantsDelegate <NSObject>


- (void)didReceiveRestaurants:(NSArray *)restaurants;
- (void)errorDuringFetchingRestaurants:(NSError *)error;

@end
