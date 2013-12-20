//
//  MainTabBarViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 16-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewAnimationDelegate.h"
#import "MapViewController.h"
@interface MainTabBarViewController : UITabBarController <ViewAnimationDelegate>
@property (strong,nonatomic) MapViewController * mapViewController;
@end
