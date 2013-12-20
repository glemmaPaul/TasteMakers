//
//  RestaurantTableViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TasteRestaurantsManager.h"
@interface RestaurantTableViewController : UITableViewController
@property TasteRestaurantsManager *restaurantManager;
@property NSArray *restaurants;
@end
