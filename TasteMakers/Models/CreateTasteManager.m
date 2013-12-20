//
//  CreateTasteManager.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "CreateTasteManager.h"
#import "RestaurantCollection.h"
#import "Restaurant.h"
@implementation CreateTasteManager
@synthesize communicator;
- (void) createRestaurant:(Restaurant *)restaurantObject {
    //[self showLoadingActivity];
    // coordinate is valid..
    NSMutableDictionary *restaurantData = [[NSMutableDictionary alloc] init];
    [restaurantData setValue:restaurantObject.title forKey:@"name"];
    [restaurantData setValue:restaurantObject.description forKey:@"description"];
    [restaurantData setValue:[NSNumber numberWithFloat:restaurantObject.location.latitude] forKey:@"latitude"];
    [restaurantData setValue:[NSNumber numberWithFloat:restaurantObject.location.longitude] forKey:@"longitude"];
    [restaurantData setValue:restaurantObject.user.username forKey:@"username"];

    [communicator createRestaurant:restaurantData];
}

- (void) didReceiveData:(NSDictionary *)jsonData {
    
    NSError *_error = [[NSError alloc] init];
    NSArray *_restaurantArray = [RestaurantCollection fetchRestaurants:[jsonData objectForKey:@"results"] error:&_error];
    
    [self.delegate savingTasteSuccess:[_restaurantArray firstObject]];
}

-(void) fetchingError:(NSError *)error {
    [self.delegate errorDuringSavingTaste:error];
}

@end
