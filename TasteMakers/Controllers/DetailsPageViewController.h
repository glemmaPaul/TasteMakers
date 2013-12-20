//
//  DetailsPageViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 15-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsPageViewController : UIPageViewController <UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageController;
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
+ (id) sharedInstance;
- (void) animateToReviewPage;

@property NSMutableArray *currentChildViews;
@end
