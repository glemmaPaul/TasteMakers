//
//  UserPreferences.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterUserDelegate.h"
#import "RegisterUserManager.h"
#import "User.h"
#import "Review.h"
#import "CheckIn.h"
#import <sqlite3.h>

@interface UserPreferences : NSObject <RegisterUserDelegate>

@property (nonatomic) NSMutableArray *reviews;
@property (nonatomic) NSMutableArray *checkins;
@property (nonatomic, retain) RegisterUserManager *communicator;
@property (nonatomic) sqlite3 *tastersDatabase;
@property (strong, nonatomic) NSString *databasePath;
@property NSUserDefaults *userDefaults;

-(void) registerUser:(NSString *) username;
-(void) rememberUser:(User *) userObject;
-(BOOL) isUserLoggedIn;
-(NSMutableArray *) getReviews:(NSNumber *)restaurantId;
-(User *) getUserObject;
- (BOOL) addReview:(Review *)reviewObject;
- (BOOL) initializeDatabase;
- (BOOL) addCheckIn:(CheckIn *) checkInObject;
- (NSArray*) getCheckInArray;
- (NSArray *) getHidedRestaurants;
- (void) hideRestaurant:(Restaurant *) restaurantObject;
@end
