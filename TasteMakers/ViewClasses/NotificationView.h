//
//  NotificationView.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 18-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationView : UIView
{
    UIView *view;
    UILabel *l;
}
@property (weak, nonatomic) IBOutlet UILabel *notificationMessage;
@property (nonatomic, retain) IBOutlet UIView *view;
- (void) setMessage:(NSString *) message;
@end
