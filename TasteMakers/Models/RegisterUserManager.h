//
//  RegisterManager.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TasteApiCommunicatorDelegate.h"
#import "TasteApiCommunicator.h"
#import "TasteRestaurantsDelegate.h"
#import "RegisterUserDelegate.h"

@interface RegisterUserManager : NSObject <TasteApiCommunicatorDelegate>
@property (strong, nonatomic) TasteApiCommunicator *communicator;
@property (weak, nonatomic) id<RegisterUserDelegate> delegate;
- (void) registerUser:(NSString *)username;
@end
