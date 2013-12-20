//
//  UserPreferences.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "UserPreferences.h"
#import "Review.h"
#import "CheckIn.h"
#import "RegisterUserManager.h"
#define ReviewKey @"reviews"
#define UserKey @"user"
#define HidedRestaurantsKey @"hided_restaurants"
@implementation UserPreferences

@synthesize reviews, checkins, communicator, userDefaults, tastersDatabase;

- (void) alloc {
    
}

- (NSMutableArray *) getReviews:(NSNumber *) restaurantId {
    const char *dbpath = [[self getSqlPath] UTF8String];
    sqlite3_stmt    *statement;
    
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // clean reviews
    self.reviews = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(dbpath, &tastersDatabase) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT content, date FROM reviews WHERE restaurant_reference = %@", restaurantId];
        
        const char *queryStatement = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(tastersDatabase,
                               queryStatement, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // create a review object out of the database
                
                
                
                Review *_reviewObject = [[Review alloc] init];
                _reviewObject.content = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
                _reviewObject.date = [_dateFormatter dateFromString:[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1)]];
                [reviews addObject:_reviewObject];
                
            }
            
            sqlite3_finalize(statement);
        }
        else {
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(tastersDatabase));

        }
        sqlite3_close(tastersDatabase);
    }
    
    
    return reviews;
}

- (NSString *) getSqlPath {
    // allocating variables
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"tasters.db"]];

    return _databasePath;
}


- (BOOL) addCheckIn:(CheckIn *) checkInObject {
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    NSLog(@"%@", checkInObject);
    NSString *insertSQL = [NSString stringWithFormat:
                           @"INSERT INTO check_in (name, description, date, restaurant_reference) VALUES (\"%@\", \"%@\", \"%@\", \"%@\")",
                           checkInObject.name, checkInObject.description, [_dateFormatter stringFromDate:checkInObject.date], checkInObject.reference];
    
    return [self executeInsertQuery:insertSQL];

}

- (NSArray*) getCheckInArray {
    const char *dbpath = [[self getSqlPath] UTF8String];
    sqlite3_stmt    *statement;
    
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // clean check ins
    self.checkins = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(dbpath, &tastersDatabase) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat:
                              @"SELECT name, description, date, restaurant_reference FROM check_in ORDER BY date DESC"];
        
        const char *queryStatement = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(tastersDatabase,
                               queryStatement, -1, &statement, NULL) == SQLITE_OK)
        {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                // create a review object out of the database
                
                
                
                CheckIn *_checkInObject = [[CheckIn alloc] init];
                _checkInObject.description = [[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 0)];
                _checkInObject.date = [_dateFormatter dateFromString:[[NSString alloc] initWithUTF8String: (const char *) sqlite3_column_text(statement, 1)]];
                [checkins addObject:_checkInObject];
                
                NSLog(@"Check in added %@", _checkInObject.description);
                
            }
            
            sqlite3_finalize(statement);
        }
        else {
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(tastersDatabase));
            
        }
        sqlite3_close(tastersDatabase);
    }
    
    
    return checkins;
}

- (BOOL) executeInsertQuery:(NSString *) query {
    sqlite3_stmt * statement;
    
    const char * databasePath = [[self getSqlPath] UTF8String];

    if (sqlite3_open(databasePath, &tastersDatabase) == SQLITE_OK)
    {
        
        NSString *insertSQL = query;
        
        const char *insertStatement = [insertSQL UTF8String];
        sqlite3_prepare_v2(tastersDatabase, insertStatement, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        } else {
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(tastersDatabase));
            return NO;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(tastersDatabase);
    }
    
    return NO;

}



- (BOOL) addReview:(Review *)reviewObject {
    sqlite3_stmt * statement;
    const char * databasePath = [[self getSqlPath] UTF8String];
    
    NSDateFormatter *_dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    if (sqlite3_open(databasePath, &tastersDatabase) == SQLITE_OK)
    {
        
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO reviews (content, date, restaurant_reference) VALUES (\"%@\", \"%@\", \"%@\")",
                               reviewObject.content, [_dateFormatter stringFromDate:reviewObject.date], reviewObject.restaurant_reference];
        
        const char *insertStatement = [insertSQL UTF8String];
        sqlite3_prepare_v2(tastersDatabase, insertStatement, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            return YES;
        } else {
            NSLog(@"Error %s while preparing statement", sqlite3_errmsg(tastersDatabase));
            return NO;
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(tastersDatabase);
    }
    else {
        NSLog(@"error logging in at database");
    }
    
    return NO;
    
}



- (void) registerUser:(NSString *)username {
    NSLog(@"Registering user");
    [communicator registerUser:username];
    
}

-(void) rememberUser:(User *)userObject {
    NSLog(@"Remembering user");
    NSMutableDictionary *userDictionary = [[NSMutableDictionary alloc] init];
    [userDictionary setValue:userObject.username forKey:@"username"];
    [userDictionary setValue:userObject.identifier forKey:@"id"];
    [[NSUserDefaults standardUserDefaults] setObject:userDictionary forKey:UserKey];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL) isUserLoggedIn {
    NSMutableDictionary *_userDictionary = [[ NSUserDefaults standardUserDefaults] objectForKey:UserKey];
    
    if ([_userDictionary objectForKey:@"username"] != nil && [_userDictionary objectForKey:@"id"] != nil) {
        return YES;
    }
    
    return NO;
    
}

- (User *) getUserObject {
    NSMutableDictionary *_userDictionary = [[ NSUserDefaults standardUserDefaults] objectForKey:UserKey];
    User *_user = [[User alloc] init];
    _user.username = [_userDictionary valueForKey:@"username"];
    _user.identifier = [_userDictionary valueForKey:@"id"];
    return _user;
    
}

- (NSArray *) getHidedRestaurants {
    
    NSArray *_hidedRestaurants = [[NSUserDefaults standardUserDefaults] objectForKey:HidedRestaurantsKey];
    return _hidedRestaurants;
}

- (void) hideRestaurant:(Restaurant *)restaurantObject {
    
    NSMutableArray *_hidedRestaurants = [[[NSUserDefaults standardUserDefaults] objectForKey:HidedRestaurantsKey] mutableCopy];
    if (!_hidedRestaurants) {
        _hidedRestaurants = [[NSMutableArray alloc] init];
    }
    
    [_hidedRestaurants addObject:restaurantObject.reference];
    
    NSArray *_saveToUserDefaults = [[NSArray alloc] initWithArray:_hidedRestaurants];
    
    [[NSUserDefaults standardUserDefaults] setObject:_saveToUserDefaults forKey:HidedRestaurantsKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

}


- (void) errorDuringFetchingUser:(NSError *)error {
    NSLog(@"Error");
}

- (void) didReceiveUser:(User *)userObject {
    NSLog(@"received");
}

- (void) didReceiveData:(NSData *)jsonData {
    
}

/*
 This function checks if a reviews database is already created.
 If not, it will create a new one.
*/
- (BOOL) initializeDatabase {
   
    
    // Build the path to the database file
    _databasePath = [self getSqlPath];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, & tastersDatabase) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS REVIEWS (ID INTEGER PRIMARY KEY AUTOINCREMENT, CONTENT TEXT, DATE TEXT, RESTAURANT_REFERENCE INTEGER); CREATE TABLE IF NOT EXISTS CHECK_IN (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, DESCRIPTION TEXT, DATE, RESTAURANT_REFERENCE INTEGGER)";
            
            if (sqlite3_exec(tastersDatabase, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Error %s while preparing statement", sqlite3_errmsg(tastersDatabase));

            }
            sqlite3_close(tastersDatabase);
        } else {
            NSLog(@"Error %s while preparing database", sqlite3_errmsg(tastersDatabase));
        }
    }
    else {
        NSLog(@"Database exists");

    }
    
    
    
    
    
    return YES;
}



@end
