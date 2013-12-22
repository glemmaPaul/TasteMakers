//
//  ReviewsChildPageViewController.h
//  TasteMakers
//
//  Created by Paul Oostenrijk on 17-12-13.
//  Copyright (c) 2013 Paul Oostenrijk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface ReviewsChildPageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, UITextViewDelegate>
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) Restaurant *restaurant;
@property (assign, nonatomic) NSMutableArray *reviews;
@property (weak, nonatomic) IBOutlet UITableView *reviewsTableView;
@property (weak, nonatomic) IBOutlet UIView *TopBarViewNewReview;
@property BOOL NewReviewOpen;
@property (weak, nonatomic) IBOutlet UIView *ViewNewReview;
@property CGFloat animatedDistance;
@property (weak, nonatomic) IBOutlet UITextView *NewReviewTextView;
@property (weak, nonatomic) IBOutlet UIButton *NewReviewSaveButton;
@property (weak, nonatomic) IBOutlet UIImageView *firstReviewImage;

@end
