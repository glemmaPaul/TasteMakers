//
//  NotificationManager.m
//  TasteMakers
//
//  Created by Paul Oostenrijk on 18-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import "NotificationManager.h"
#import "NotificationViewController.h"
#import "CAKeyframeAnimation+AHEasing.h"

@implementation NotificationManager
@synthesize errorColor,successColor,warningColor, duration;
- (id)init {
    successColor = [[UIColor alloc] initWithRed:134.0f/255.0f green:196.0f/255.0f blue:65.0f/255.0f alpha:1.0f];
    errorColor = [[UIColor alloc] initWithRed:219 green:78 blue:0 alpha:1];
    warningColor = [[UIColor alloc] initWithRed:255  green:139 blue:0 alpha:1];
    duration = 0.3f;
    
    return self;
}

- (void) showErrorNotification:(NSString *)message {
    [self showNotification:message withDuration:duration andColor:[[UIColor alloc] initWithRed:193.0f/255.0f green:81.0f/255.0f blue:66.0f/255.0f alpha:1.0f]];
}

- (void) showSuccessNotification:(NSString *)message {
    [self showNotification:message withDuration:duration andColor:[[UIColor alloc] initWithRed:134.0f/255.0f green:196.0f/255.0f blue:65.0f/255.0f alpha:1.0f]];
}

- (void) showWarningNotification:(NSString *)message {
    [self showNotification:message withDuration:duration andColor:warningColor];
}

- (void) showNotification:(NSString *)message withDuration:(CGFloat)floatDuration andColor:(UIColor *)color {
    
    UIViewController *rootView = [self topViewController];
    NotificationViewController *notificationView = [[NotificationViewController alloc] initWithNibName:@"NotificationView" bundle:nil];


    
    // giving the notification border two rounded corners at the bottom
    UIRectCorner borderCorners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
    CGSize borderRadius = CGSizeMake(5.0f, 5.0f);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:notificationView.view.bounds
                                               byRoundingCorners:borderCorners
                                                     cornerRadii:borderRadius];
    // Mask the notifications view’s layer to round the corners.
    CAShapeLayer *cornerMaskLayer = [CAShapeLayer layer];
    [cornerMaskLayer setPath:path.CGPath];
    notificationView.view.layer.mask = cornerMaskLayer;
    
    
    [notificationView.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    [notificationView setMessage:message];
    
    [notificationView.view setFrame:CGRectMake(0,0, notificationView.view.frame.size.width, notificationView.view.frame.size.height)];
    [notificationView.view setBackgroundColor:color];
    [rootView.view addSubview:notificationView.view];
    
    // animate the view into the view
    CGPoint targetCenter = rootView.view.center;
    targetCenter.y = notificationView.view.frame.size.height /2;
    CGPoint fromTarget = rootView.view.center;
    fromTarget.y = -100;
    
    
    CALayer *layer= [notificationView.view layer];
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:floatDuration] forKey:kCATransactionAnimationDuration];
    
    CAAnimation *notificationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"
                                                                     function:ExponentialEaseInOut
                                                                    fromPoint:fromTarget
                                                                      toPoint:targetCenter];
    [CATransaction setCompletionBlock:^{
        [self performSelector:@selector(hideNotificationView:) withObject:notificationView.view afterDelay:2];
    }];
    [layer addAnimation:notificationAnimation forKey:@"position"];
    
    [CATransaction commit];
    
    [notificationView.view setCenter:targetCenter];

    
}

- (void) hideNotificationView:(UIView*) notificationView {
    // animate the view into the view
    CGPoint targetCenter = notificationView.center;
    targetCenter.y = -(notificationView.frame.size.height /2);
    CGPoint fromTarget = notificationView.center;
    
    
    CALayer *layer= [notificationView layer];
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.7f] forKey:kCATransactionAnimationDuration];
    
    CAAnimation *notificationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"
                                                                          function:ExponentialEaseInOut
                                                                         fromPoint:fromTarget
                                                                           toPoint:targetCenter];
    [CATransaction setCompletionBlock:^{
        [notificationView removeFromSuperview];
    }];
    [layer addAnimation:notificationAnimation forKey:@"position"];
    
    [CATransaction commit];
    
    [notificationView setCenter:targetCenter];
    
}



+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    UIApplication *application = [UIApplication sharedApplication];
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        size = CGSizeMake(size.height, size.width);
    }
    if (application.statusBarHidden == NO)
    {
        size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
    }
    return size;
}



/* Stole the code from github, I think it's not the best way to do it, but it works :-)
 https://gist.github.com/snikch/3661188
*/
- (UIViewController *)topViewController{
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}



@end
