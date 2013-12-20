//
//  NotificationManager.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 18-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationManager : NSObject

@property (retain, readonly) UIColor *errorColor;
@property (retain, readonly) UIColor *successColor;
@property (retain, readonly) UIColor *warningColor;
@property  CGFloat duration;

- (void) showSuccessNotification:(NSString *)message;
- (void) showErrorNotification: (NSString *) message;
- (void) showWarningNotification: (NSString *) message;

@end
