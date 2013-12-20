//
//  TasteRestaurantsManager.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TasteApiCommunicator.h"
#import "TasteApiCommunicatorDelegate.h"
#import "TasteRestaurantsDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface TasteRestaurantsManager : NSObject <TasteApiCommunicatorDelegate>
@property (strong, nonatomic) TasteApiCommunicator *communicator;
@property (weak, nonatomic) id<TasteRestaurantsDelegate> delegate;
- (void)fetchRestaurants: (CLLocationCoordinate2D) coordinate withFilter:(NSMutableArray *)filter;
@end
