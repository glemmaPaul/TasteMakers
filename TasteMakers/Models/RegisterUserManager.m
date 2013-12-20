//
//  RegisterManager.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "RegisterUserManager.h"
#import "TasteApiCommunicator.h"
#import "User.h"

@implementation RegisterUserManager
@synthesize communicator;

-(void) registerUser:(NSString *)username {
    [communicator registerUser:username];
}

- (void) didReceiveData:(NSDictionary *)jsonData {
    // asign if there are local errors e.g. JSON data decode errors
    NSError *localError = nil;
    NSDictionary *parsedObject = jsonData;
    
    NSLog(@"Thank you communicator JSON DATA: %@", jsonData);
    
    if (localError != nil) {
        NSError *error = localError;
        [self.delegate errorDuringFetchingUser:error];
    }
    else {
        // check if there is an error in the json response
        NSDictionary *errorData = [parsedObject valueForKey:@"error"];
        
        if ([errorData valueForKey:@"error_code"] != nil) {
            [self.delegate errorDuringFetchingUser:localError];
        }
    }
    
    NSDictionary *userData = [parsedObject valueForKey:@"user"];
    
    
    User *_user = [[User alloc] init];
    _user.username = [userData valueForKey:@"username"];
    _user.identifier = [userData valueForKey:@"id"];
    
    [self.delegate didReceiveUser:_user];
    
}

- (void) fetchingError:(NSError *)error {
    [self.delegate errorDuringFetchingUser:error];
}

@end

