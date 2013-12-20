//
//  DetailsRestaurantViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 14-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"
#import "MapViewController.h"
#import "DetailsPageViewController.h"
#import "DetailsViewDelegate.h"


@interface DetailsRestaurantViewController : UIViewController

-(void) startAnimatingObjects;
@property Restaurant *restaurant;
@property (strong, nonatomic) IBOutlet UIView *blueBackgroundView;
@property (weak, nonatomic) NSString * mode;
@property (weak, nonatomic) IBOutlet UIView *PageViewContainer;
@property (weak, nonatomic) IBOutlet UIView *detailsToolbar;
@property (weak, nonatomic) IBOutlet UINavigationBar *detailsNavigationBar;
@property (strong, nonatomic) DetailsPageViewController *pageViewControllerInstance;
@property (nonatomic, weak) id<DetailsViewDelegate>  delegate;
@end