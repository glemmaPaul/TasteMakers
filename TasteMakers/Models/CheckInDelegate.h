//
//  CheckInDelegate.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CheckInDelegate <NSObject>
-(void) didReceiveRestaurants:(NSArray *) restaurants;
-(void) errorDuringGettingRestaurants:(NSError *)error;
@end
