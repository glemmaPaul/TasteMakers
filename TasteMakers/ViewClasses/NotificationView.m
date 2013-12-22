//
//  NotificationView.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 18-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "NotificationView.h"

@implementation NotificationView

@synthesize notificationMessage, view;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"MyView" owner:self options:nil];
        [self addSubview:self.view];
    }
    return self;
}


- (void) setMessage:(NSString *) message {
    [notificationMessage setText:message];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
