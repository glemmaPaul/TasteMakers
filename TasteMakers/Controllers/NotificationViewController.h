//
//  NotificationViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 18-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *messageTextField;
-(void) setMessage:(NSString *)message;
@property (strong, nonatomic) IBOutlet UIView *viewOutlet;
@end
