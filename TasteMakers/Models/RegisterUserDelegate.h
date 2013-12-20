//
//  RegisterUserDelegate.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@protocol RegisterUserDelegate <NSObject>

- (void) didReceiveUser: (User *) userObject;
- (void) errorDuringFetchingUser: (NSError *) error;

@end
