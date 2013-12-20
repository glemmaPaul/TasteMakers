//
//  CheckInManager.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TasteApiCommunicator.h"
#import "TasteApiCommunicatorDelegate.h"
#import "CheckInDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "Restaurant.h"

@interface CheckInManager : NSObject <TasteApiCommunicatorDelegate>
@property (strong, nonatomic) TasteApiCommunicator *communicator;
@property (weak, nonatomic) id<CheckInDelegate> delegate;
- (BOOL)checkInForRestaurant: (Restaurant *) restaurantObject;
- (void) getRestaurantsNearby: (CLLocationCoordinate2D) coordinate;
- (NSArray *) getCheckIns;
@end


