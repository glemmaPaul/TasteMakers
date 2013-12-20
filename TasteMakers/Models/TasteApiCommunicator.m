//
//  TasteApiCommunicator.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "TasteApiCommunicator.h"
#import "TasteApiCommunicatorDelegate.h"
#import "Restaurant.h"
#import "user.h"
#import "AFHTTPRequestOperationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "Filter.h"

#define APIRootURL @"http://www.taste.rs/api"

@implementation TasteApiCommunicator


- (void)getRestaurants:(CLLocationCoordinate2D) coordinate withFilters:(NSString *) filters
{
    
    [self executeGetToServer:[NSString stringWithFormat:@"%@/restaurant/?filters=%@?latitude=%f&longitude=%f", APIRootURL, filters, coordinate.latitude, coordinate.longitude] ];
   
}

- (void)createRestaurant: (NSDictionary *)restaurantObject
{
    NSLog(@"Create restaurant");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = restaurantObject;
    
    [manager  POST:[NSString stringWithFormat:@"%@/restaurant/create", APIRootURL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        [self.delegate didReceiveData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [self.delegate fetchingError:error];
    }];
}

- (void) registerUser: (NSString *) username {
    
    NSDictionary *parameters = @{@"username": username};
    
    [self executePostToServer:[NSString stringWithFormat:@"%@/user/signup", APIRootURL] withParameters:parameters];
    
    
}

- (void) getRestaurantsByUser:(User *)userObject {
    
    NSDictionary *parameters = @{@"username": userObject.username};
    [self executePostToServer:[NSString stringWithFormat:@"%@/user/restaurants", APIRootURL] withParameters:parameters];
    
    
}

- (void)getRestaurants:(CLLocationCoordinate2D)coordinate withRange:(NSNumber*)range {
    
    [self executeGetToServer:[NSString stringWithFormat:@"%@/restaurant/?range=%@&latitude=%f&longitude=%f", APIRootURL, [range stringValue], coordinate.latitude, coordinate.longitude]];
    
}

- (void) getFilters {
    [self executeGetToServer:[NSString stringWithFormat:@"%@/restaurant/filters", APIRootURL]];
}

- (void) executePostToServer:(NSString *)url withParameters:(NSDictionary *) parameters {
    NSLog(@"Posting to %@", url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager  POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON %@", responseObject);
        [self.delegate didReceiveData:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error : %@", error);
        
        [self.delegate fetchingError:error];
    }];
    
}

- (void) executeGetToServer:(NSString *)url {
    NSLog(@"Getting to %@", url);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self.delegate didReceiveData:responseObject];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self.delegate fetchingError:error];
        
    }];
}



@end
