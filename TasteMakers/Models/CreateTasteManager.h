//
//  CreateTasteManager.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TasteApiCommunicator.h"
#import "TasteApiCommunicatorDelegate.h"
#import "CreateTasteDelegate.h"
#import "Restaurant.h"

@interface CreateTasteManager : NSObject <TasteApiCommunicatorDelegate>

@property (strong, nonatomic) TasteApiCommunicator *communicator;
@property (weak, nonatomic) id<CreateTasteDelegate> delegate;
- (void) createRestaurant:(Restaurant *) restaurantObject;
@end
