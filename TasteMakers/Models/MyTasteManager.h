//
//  MyTasteManager.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TasteApiCommunicator.h"
#import "TasteApiCommunicatorDelegate.h"
#import "TasteRestaurantsDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "User.h"

@interface MyTasteManager : NSObject <TasteApiCommunicatorDelegate>
@property (strong, nonatomic) TasteApiCommunicator *communicator;
@property (weak, nonatomic) id<TasteRestaurantsDelegate> delegate;
- (void)getMyRestaurants: (User *) user;
@end
