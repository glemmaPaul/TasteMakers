//
//  MyTasteManager.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "MyTasteManager.h"
#import "User.h"
#import "RestaurantCollection.h"

@implementation MyTasteManager
@synthesize communicator;
- (void) getMyRestaurants:(User *) user {
    [communicator getRestaurantsByUser:user];
}

- (void) didReceiveData:(NSMutableDictionary *)jsonData {
    
    NSLog(@"Great!");
    
    NSArray *results = [jsonData objectForKey:@"results"];
    NSError *error = nil;
    NSArray *restaurants = [RestaurantCollection fetchRestaurants:results error:&error];
    
    if (error != nil) {
        [self.delegate errorDuringFetchingRestaurants:error];
        
    } else {
        [self.delegate didReceiveRestaurants:restaurants];
    }

    
}

- (void) fetchingError:(NSError *)error {
    [self.delegate errorDuringFetchingRestaurants:error];
}

@end
